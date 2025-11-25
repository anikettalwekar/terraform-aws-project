variable "project_name" { type = string }
variable "subnet_ids" { type = list(string) }
variable "ami" { type = string }
variable "instance_type" { type = string }
variable "key_name" {type = string}
variable "iam_instance_profile" { type = string }
variable "vpc_id" { type = string }
