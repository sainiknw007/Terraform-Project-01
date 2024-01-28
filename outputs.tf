output "ec2_public_ip" {
  value = aws_instance.my-appserver.public_ip
}