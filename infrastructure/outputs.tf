output "load_balancer_ip" {
  value = aws_lb.default.dns_name
}

output "mysql_endpoint" {
    value = aws_db_instance.mysql.endpoint
}