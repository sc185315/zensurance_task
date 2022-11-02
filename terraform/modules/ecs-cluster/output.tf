output "ecs-cluster-name" {
  value = aws_ecs_cluster.ecs-cluster.name
}

output "role-arn" {
  value = aws_iam_role.ecs_task_execution_role.arn
}