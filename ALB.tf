resource "aws_lb" "webapp_alb" {
  name               = "web-app-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ALB-SG.id]
  subnets            = [aws_subnet.public[0].id, aws_subnet.public[1].id, aws_subnet.public[2].id]

  enable_deletion_protection = false
}

resource "aws_lb_target_group" "webapp" {
  name     = "webapp-target-group"
  port     = 5000
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    path                = "/healthz"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.webapp_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webapp.arn
  }
}
