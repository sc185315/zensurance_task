provider "aws" {
  region = "us-east-1"
}

module "ecs-dev-cluster" {
  source               = "../../../modules/ecs-taskdefinition"
  task_name            = var.task_name
  task_role_arn        = var.task_role_arn
  execution_role_arn   = var.execution_role_arn
  cpu                  = var.cpu
  memory               = var.memory
  container_definition = var.container_definition
  service_name         = var.service_name
  cluster_name         = var.cluster_name
  desired_count        = var.desired_count
  target_group_arn     = aws_lb_target_group.ecs-target-group.arn
  container_name       = var.container_name
  container_port       = var.container_port
  subnets              = var.subnets
}

resource "aws_lb_target_group" "ecs-target-group" {
  name        = "${var.task_name}-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
}

resource "aws_lb_listener_rule" "static" {
  listener_arn =var.listener_arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs-target-group.arn
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }

  
}


