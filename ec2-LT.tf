resource "aws_launch_template" "app" {
  name          = var.launch_template
  image_id      = var.ami-ID
  instance_type = var.instance_type
  key_name      = var.key_name

  network_interfaces {
    subnet_id                   = aws_subnet.public[0].id
    security_groups             = [aws_security_group.app.id]
    associate_public_ip_address = true
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.agent_profile.name
  }

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_type           = "gp2"
      volume_size           = 25
      delete_on_termination = true
      encrypted             = true
      kms_key_id            = aws_kms_key.ec2_key.arn
    }
  }

  user_data = base64encode(<<-EOF
              #!/bin/bash
              sudo apt update -y

              # Install AWS CLI
              apt install -y unzip
              curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
              unzip awscliv2.zip
              sudo ./aws/install

              # Install jq for JSON parsing
              sudo apt install -y jq

              # Fetch database credentials from Secrets Manager
              SECRET=$(aws secretsmanager get-secret-value --secret-id --region "us-east-1" "${aws_secretsmanager_secret.random_password.id}" --query 'SecretString' --output text)
              PASS=$(echo $SECRET | jq -r '.password')

              echo "DB_HOST=${aws_db_instance.postgres.address}" >> /opt/src/webapp/.env
              echo "DB_USER=${var.DB_USER}" >> /opt/src/webapp/.env
              echo "DB_PASS=$PASS" >> /opt/src/webapp/.env
              echo "DB_NAME=${var.DB_NAME}" >> /opt/src/webapp/.env
              echo "BUCKET=${aws_s3_bucket.my_bucket.bucket}" >> /opt/src/webapp/.env
              echo "SNS_TOPIC_ARN=${aws_sns_topic.userUpdate.arn}" >> /opt/src/webapp/.env

              # Start the app
              sudo systemctl restart packer-webapp.service

              # Start CloudWatch Agent
              echo "Starting Amazon CloudWatch Agent..."
              sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
              -a fetch-config \
              -m ec2 \
              -c file:/opt/cloudwatch-config.json \
              -s
              EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "App-${var.environment}"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}
