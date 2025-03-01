variable "instance_type" {
  default = "t2.micro"
}

variable "ami" {
  default = "ami-04b4f1a9cf54c11d0"  
}

variable "key_name" {
  default = "backend"  # Replace with your EC2 key pair name
}

variable "security_group" {
  default = "todo-app-sg"
}

variable "domain_name" {
  default = "israelcloud.xyz"
}
