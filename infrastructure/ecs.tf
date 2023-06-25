resource "aws_ecs_cluster" "main" {
  name = "example-cluster"
}

resource "aws_ecs_service" "node_js" {
  name            = "node-js-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.node_js.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = [aws_security_group.node_js_task.id]
    subnets         = aws_subnet.private.*.id
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.node_js.id
    container_name   = "node-js-app"
    container_port   = 8080
  }

  depends_on = [aws_lb_listener.node_js, aws_db_instance.mysql]
}

