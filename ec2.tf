resource "aws_instance" "app" {
  ami                    = var.ami-ID
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public[0].id
  vpc_security_group_ids = [aws_security_group.app.id]

  root_block_device {
    volume_type = "gp2"
    volume_size = 25
  }
  disable_api_termination = false
  lifecycle {
    create_before_destroy = true
  }

  #add user data script to create environment variables for rds to pick and connect
  user_data = <<-EOF
              #!/bin/bash
              echo " DB_HOST=${aws_db_instance.postgres.address}" >> /opt/src/webapp/.env
              echo " DB_USER=${var.DB_USER}" >> /opt/src/webapp/.env
              echo " DB_PASS=${var.DB_PASS}" >> /opt/src/webapp/.env
              echo " DB_NAME=${var.DB_NAME}" >> /opt/src/webapp/.env

              #start the app
              sudo systemctl restart packer-webapp.service
              EOF

  tags = {
    Name = "App-${var.environment}"
  }

}