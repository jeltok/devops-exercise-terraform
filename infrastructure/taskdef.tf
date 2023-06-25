resource "aws_cloudwatch_log_group" "ecs" {
  name              = "/devops"
}
resource "aws_ecs_task_definition" "node_js" {
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  family                   = "node-js-app"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 1024
  memory                   = 2048

  container_definitions = <<DEFINITION
[
  {
    "image": "${var.ecr_repo_uri}",
    "cpu": 512,
    "memory": 1024,
    "name": "node-js-app",
    "networkMode": "awsvpc",
    "portMappings": [
      {
        "containerPort": 8080,
        "hostPort": 8080
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-region" : "${var.aws_region}",
        "awslogs-group" : "/devops",
        "awslogs-stream-prefix" : "node_js"
      }
    },
    "environment": [
      {
        "name": "DB_HOST",
        "value": "${aws_db_instance.mysql.address}"
      },
      {
        "name": "DB_USER",
        "value": "${var.rds_db_username}"
      },
      {
        "name": "DB_PASSWORD",
        "value": "${var.rds_db_password}"
      },
      {
        "name": "DB_NAME",
        "value": "${var.rds_db_name}"
      },
      {
        "name": "DB_PORT",
        "value": "3306"
      },
      {
        "name": "NODE_DOCKER_PORT",
        "value": "8080"
      }
    ]
  }
]
DEFINITION
}