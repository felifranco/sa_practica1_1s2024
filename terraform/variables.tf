variable "access_key" {
  description = "access_key"
  type        = string
  sensitive   = true
}

variable "secret_key" {
  description = "secret_key"
  type        = string
  sensitive   = true
}

variable "vpc_id" {
  description = "vpc_id"
  type        = string
  sensitive   = true
}

variable "subnet_id" {
  description = "subnet_id"
  type        = string
  sensitive   = true
}

variable "ssh_user" {
  description = "ssh_user"
  type        = string
  sensitive   = true
}

variable "private_key_path" {
  description = "private_key_path"
  type        = string
  sensitive   = true
}

variable "public_key_path" {
  description = "public_key_path"
  type        = string
  sensitive   = true
}