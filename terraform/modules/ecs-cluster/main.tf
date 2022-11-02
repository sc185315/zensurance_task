resource "aws_cloudwatch_log_group" "ecs-cw" {
  name = var.name_prefix
}

resource "aws_kms_key" "ecs-kms" {
  description             = var.name_prefix
  deletion_window_in_days = 7
}

resource "aws_ecs_cluster" "ecs-cluster" {
  name = var.name_prefix

  configuration {
    execute_command_configuration {
      kms_key_id = aws_kms_key.ecs-kms.arn
      logging    = "OVERRIDE"

      log_configuration {
        cloud_watch_encryption_enabled = true
        cloud_watch_log_group_name     = aws_cloudwatch_log_group.ecs-cw.name
      }
    }
  }
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name                 = "${var.name_prefix}-ecs-task-execution-role"
  assume_role_policy   = file("${path.module}/iam/policy.json")
  inline_policy {
   name = "ecs-task-policy"
   policy               = file("${path.module}/iam/permissions.json") 
  }
  
}