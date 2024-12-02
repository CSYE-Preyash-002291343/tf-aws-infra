resource "aws_iam_role" "ec2Role" {
  name = "CloudWatchAgentServerRole"


  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Purpose = "Role for EC2 instances to interact with CloudWatch"
  }
}

resource "aws_iam_role_policy_attachment" "cloudwatch_policy" {
  role       = aws_iam_role.ec2Role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

#aws s3 access policy
resource "aws_iam_policy" "s3_access_policy" {
  name        = "s3_access_policy"
  description = "Policy for EC2 instances to interact with specific S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:ListBucket",
          "s3:GetBucketLocation",
          "s3:HeadBucket"
        ],
        Resource = "arn:aws:s3:::${aws_s3_bucket.my_bucket.bucket}" # Bucket-level permissions
      },
      {
        Effect = "Allow",
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject"
        ],
        Resource = "arn:aws:s3:::${aws_s3_bucket.my_bucket.bucket}/*" # Object-level permissions
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_access_policy_attachment" {
  role       = aws_iam_role.ec2Role.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}

resource "aws_iam_policy" "sns_publish_policy" {
  name = "SNSPublishPolicy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "sns:Publish",
        Resource = aws_sns_topic.userUpdate.arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "sns_publish_policy_attachment" {
  role       = aws_iam_role.ec2Role.name
  policy_arn = aws_iam_policy.sns_publish_policy.arn
}

resource "aws_iam_policy" "secrets_manager_policy" {
  name = "secrets_manager_access"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "secretsmanager:GetSecretValue",
        Resource = aws_secretsmanager_secret_version.random_password.arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_secrets_manager_policy" {
  role       = aws_iam_role.ec2Role.name
  policy_arn = aws_iam_policy.secrets_manager_policy.arn
}

resource "aws_iam_policy" "ec2_kms_policy" {
  name        = "ec2-kms-access"
  description = "Allow EC2 instances to access the KMS key for encryption and decryption operations."

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AllowKMSKeyManagement",
        Effect = "Allow",
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:GenerateDataKeyWithoutPlaintext",
          "kms:DescribeKey",
          "kms:CreateGrant",
          "kms:ListGrants",
          "kms:RevokeGrant"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_kms_policy" {
  role       = aws_iam_role.ec2Role.name
  policy_arn = aws_iam_policy.ec2_kms_policy.arn
}

resource "aws_iam_instance_profile" "agent_profile" {
  name = "CloudWatchAgentInstanceProfile"
  role = aws_iam_role.ec2Role.name
}

resource "aws_iam_role" "lambda_exec_role" {
  name = "LambdaExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Purpose = "Role for Lambda function execution"
  }
}

resource "aws_iam_policy" "lambda_policy" {
  name = "LambdaExecutionPolicy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Action = [
          "rds:*",
          "sns:Publish"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy" "lambda_secrets_policy" {
  name = "LambdaSecretsPolicy"
  role = aws_iam_role.lambda_exec_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Resource = [
          aws_secretsmanager_secret.emailCreds.arn
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "kms:Decrypt"
        ]
        Resource = [
          aws_kms_key.secrets_key.arn
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attach" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}