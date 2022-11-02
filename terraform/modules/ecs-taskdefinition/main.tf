resource "aws_ecs_task_definition" "ecs-td" {
  family                   = var.task_name
  task_role_arn            = var.task_role_arn
  execution_role_arn       = var.execution_role_arn  
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.cpu
  memory                   = var.memory
  container_definitions    = file(var.container_definition)

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}

resource "aws_ecs_service" "ecs-service" {

  name            = var.service_name
  cluster         = var.cluster_name
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.ecs-td.arn
  desired_count   = var.desired_count

  load_balancer {  
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }
    network_configuration {
        subnets = var.subnets
    }
}