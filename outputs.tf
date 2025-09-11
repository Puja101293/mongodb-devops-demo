output "instance_public_ip" {
  description = "Public IP address"
  value       = aws_instance.mongodb.public_ip
}
