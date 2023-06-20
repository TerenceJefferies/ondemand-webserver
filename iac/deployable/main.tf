provider "aws" {
  region = var.aws_region
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_instance" "web" {
  for_each = var.definitions
  ami                    = var.ami
  instance_type          = var.instance_type
  user_data              = templatefile("${path.module}/userdata.tftpl", {
    nginx_config = base64encode(file("${path.module}/nginx.conf")),
    deployment_alias = each.value.alias,
    deployment_reference = each.value.reference
  })
  vpc_security_group_ids = [aws_security_group.web.id]

  tags = {
    Name = each.value.alias
  }
}

resource "aws_security_group" "web" {
  name        = "web_traffic"
  description = "Allow Web Traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description      = "Allow HTTP traffic"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "web_traffic"
  }
}
