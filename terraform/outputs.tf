output "ansible" {
  description = "Ansible EC2 instance info"
  value       = "[${aws_instance.ansible.id} -> public IP ${aws_instance.ansible.public_ip} and private IP ${aws_instance.ansible.private_ip}]"
}

output "nginx" {
  description = "Nginx EC2 instance info"
  value       = "[${aws_instance.nginx.id} -> public IP ${aws_instance.nginx.public_ip} and private IP ${aws_instance.nginx.private_ip}]"
}