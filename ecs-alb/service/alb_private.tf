variable "alb_name" {}
variable "alb_sg" {}
variable "alb_subnets" {}
variable "certificate_arn" {}

resource "aws_lb" "private_alb" {
  name               = var.alb_name
  internal           = true
  load_balancer_type = "application"
  security_groups    = var.alb_sg
  subnets            = var.alb_subnets

  enable_deletion_protection = false
}

resource "aws_lb_target_group" "default" {
  name = "alb-tg-${var.image_name}"
  port = 80
  protocol = "HTTP"
  vpc_id = "${var.vpc_id}"
  target_type = "ip"
  deregistration_delay = 10
  health_check {
    healthy_threshold = "2"
    interval = "16"
    path = "/health"
    timeout = "15"
    unhealthy_threshold = "2"
    matcher = "200-399"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = "${aws_lb.private_alb.arn}"
  port = 80
  protocol = "HTTP"
  //certificate_arn = var.certificate_arn

  default_action {
    type = "forward"
    target_group_arn = "${aws_lb_target_group.default.arn}"
  }
}
output "alb_listener_arn" {
  value = aws_lb_listener.http.arn
}