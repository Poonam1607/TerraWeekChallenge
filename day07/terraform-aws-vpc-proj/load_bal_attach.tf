#creating load balancer target group
resource "aws_lb_target_group_attachment" "My-target-group1" {
  target_group_arn = aws_lb_target_group.My_lb_tg.arn
  target_id        = aws_instance.My_web_instances.id
  port             = 80

  depends_on = [aws_instance.My_web_instances].count.index
}
#creating load balancer listener
resource "aws_lb_listener" "My-listener" {
  load_balancer_arn = aws_lb.My_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.My_lb_tg.arn
  }
}
