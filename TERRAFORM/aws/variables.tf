variable "aws_region" {
  description = "Région AWS"
  default     = "eu-west-3"
}

variable "account_id" {
  description = "ID du compte AWS"
  default     = "774941661781"
}

variable "cluster_name" {
  description = "Nom du cluster ECS"
  default     = "kgt-formation"
}

variable "app_name" {
  description = "Nom de l'application"
  default     = "kgt-app"
}

variable "container_port" {
  description = "Port du conteneur"
  default     = 8080
}
