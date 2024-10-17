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
  tags = {
    Name = "App-${var.environment}"
  }
  lifecycle {
    create_before_destroy = true
  }
}