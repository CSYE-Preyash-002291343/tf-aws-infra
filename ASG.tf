resource "aws_autoscaling_group" "webapp_asg" {
  desired_capacity     = 3
  max_size             = 5
  min_size             = 3

  launch_template {
    id      = aws_launch_template.web_app.id
    version = "$Latest"
  }

  vpc_zone_identifier = [aws_subnet.public[0].id, aws_subnet.public[1].id, aws_subnet.public[2].id]

  tag {
    key                 = "Name"
    value               = "App-${var.environment}"
    propagate_at_launch = true
  }

  target_group_arns = [aws_lb_target_group.webapp.arn] 
}

resource "aws_autoscaling_policy" "scale_up" {
  name                   = "scale_up_policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = aws_autoscaling_group.webapp_asg.name

  metric_aggregation_type = "Average"
  estimated_instance_warmup = 300

  step_adjustment {
    metric_interval_lower_bound = 5
    scaling_adjustment          = 1
  }
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "scale_down_policy"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = aws_autoscaling_group.webapp_asg.name

  step_adjustment {
    metric_interval_upper_bound = 3
    scaling_adjustment          = -1
  }
}
