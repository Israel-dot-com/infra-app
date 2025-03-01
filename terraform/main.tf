resource "aws_security_group" "todo_app_sg" {
  name = var.security_group

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "todo_app" {
  ami             = var.ami
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [aws_security_group.todo_app_sg.name]
   root_block_device {
   volume_size = 20
 }

  tags = {
    Name = "todo-app-instance"
  }
}

resource "local_file" "ansible_inventory" {
  content  = <<EOT
[servers]
${aws_instance.todo_app.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/backend.pem
EOT
  filename = "../ansible/inventory.yml"

  depends_on = [aws_instance.todo_app]
}

resource "null_resource" "run_ansible" {
  depends_on = [aws_instance.todo_app, local_file.ansible_inventory]

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ../ansible/inventory.yml ../ansible/playbook.yml"
  }
}
