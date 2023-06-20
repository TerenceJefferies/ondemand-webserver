variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "ami" {
  type = string
}

variable "definitions" {
  type = list(object({
    alias = string,
    reference = string
  }))
}
