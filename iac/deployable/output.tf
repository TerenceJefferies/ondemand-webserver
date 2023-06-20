output "server_ips" {
  value = values(aws_instance.web).*.public_ip
}
