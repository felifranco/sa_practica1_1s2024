output "ansible" {
  description = "Ansible EC2 instance info"
  value       = "[${aws_instance.ansible.id} -> ${aws_instance.ansible.public_ip}]"
}

output "nginx" {
  description = "Nginx EC2 instance info"
  value       = "[${aws_instance.nginx.id} -> ${aws_instance.nginx.public_ip}]"
}