output "cluster_name" {
  description = "Nom du cluster ECS"
  value       = aws_ecs_cluster.kgt.name
}

output "service_name" {
  description = "Nom du service ECS"
  value       = aws_ecs_service.kgt_app.name
}

output "security_group_id" {
  description = "ID du Security Group"
  value       = aws_security_group.kgt_app.id
}

output "task_definition" {
  description = "ARN de la Task Definition"
  value       = aws_ecs_task_definition.kgt_app.arn
}
