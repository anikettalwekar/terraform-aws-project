resource "aws_security_group" "ec2" {
  name        = "${var.project_name}-ec2-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = var.vpc_id

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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  count                  = length(var.subnet_ids)
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_ids[count.index]
  key_name               = length(trimspace(var.key_name)) > 0 ? var.key_name : null
  associate_public_ip_address = true
  iam_instance_profile   = var.iam_instance_profile
  vpc_security_group_ids = [aws_security_group.ec2.id]

  tags = {
    Name = "${var.project_name}-web-${count.index}"
  }
}

output "public_ips" {
  value = aws_instance.web[*].public_ip
}
