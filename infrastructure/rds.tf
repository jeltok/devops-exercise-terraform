resource "aws_db_subnet_group" "db_subnet_group" {
    subnet_ids  = [aws_subnet.private[0].id, aws_subnet.private[1].id]
}

resource "aws_db_instance" "mysql" {
    identifier                = "mysql"
    allocated_storage         = 5
    backup_retention_period   = 1
    multi_az                  = true
    engine                    = "mysql"
    engine_version            = "5.7"
    parameter_group_name      = "default.mysql5.7"
    instance_class            = "db.t3.micro"
    db_name                   = var.rds_db_name
    username                  = var.rds_db_username
    password                  = var.rds_db_password
    port                      = "3306"
    db_subnet_group_name      = aws_db_subnet_group.db_subnet_group.id
    vpc_security_group_ids    = [aws_security_group.rds_sg.id]
    skip_final_snapshot       = true
    final_snapshot_identifier = "testdb-final"
}