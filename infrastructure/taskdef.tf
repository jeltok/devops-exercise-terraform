resource "aws_ecs_task_definition" "node_js" {
  family                   = "node-js-app"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 1024
  memory                   = 2048

  container_definitions = <<DEFINITION
[
  {
    "image": "354386841181.dkr.ecr.us-east-1.amazonaws.com/devops/node_js:latest",
    "cpu": 512,
    "memory": 1024,
    "name": "node-js-app",
    "networkMode": "awsvpc",
    "portMappings": [
      {
        "containerPort": 8080,
        "hostPort": 8080
      }
    ]
  }
]
DEFINITION
}