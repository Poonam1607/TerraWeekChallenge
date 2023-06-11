#creating load balancer target group
resource "aws_lb_target_group" "My-lb-tg" {
  name     = "Customtargetgroup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.custom_vpc.id

  depends_on = [aws_vpc.custom_vpc]
}
