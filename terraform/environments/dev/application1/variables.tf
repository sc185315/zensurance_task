variable "task_name" {}
variable "task_role_arn" {}
variable "execution_role_arn" {}
variable "cpu" {}
variable "memory" {}
variable "container_definition" {}
variable "service_name" {}
variable "cluster_name" {}
variable "desired_count" {}
variable "container_name" {}
variable "container_port" {}
variable "subnets" {
  type = list(any)
}
variable "vpc_id"{}
variable "listener_arn"{}