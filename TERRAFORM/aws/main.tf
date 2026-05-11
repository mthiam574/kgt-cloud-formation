# Configuration du provider AWS
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Récupérer le VPC par défaut
data "aws_vpc" "default" {
  default = true
}

# Récupérer les subnets par défaut
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Security Group
resource "aws_security_group" "kgt_app" {
  name        = "${var.app_name}-sg-tf"
  description = "Security group KGT formation Terraform"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = var.container_port
    to_port     = var.container_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.app_name}-sg-tf"
    Env  = "formation"
  }
}

# Cluster ECS
resource "aws_ecs_cluster" "kgt" {
  name = "${var.cluster_name}-tf"

  tags = {
    Name = "${var.cluster_name}-tf"
    Env  = "formation"
  }
}

# Task Definition ECS
resource "aws_ecs_task_definition" "kgt_app" {
  family                   = "${var.app_name}-tf"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = "arn:aws:iam::${var.account_id}:role/ecsTaskExecutionRole"

  container_definitions = jsonencode([
    {
      name  = var.app_name
      image = "${var.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${var.app_name}:v1.0"
      portMappings = [
        {
          containerPort = var.container_port
          protocol      = "tcp"
        }
      ]
    }
  ])

  tags = {
    Name = "${var.app_name}-tf"
    Env  = "formation"
  }
}

# Service ECS
resource "aws_ecs_service" "kgt_app" {
  name            = "${var.app_name}-service-tf"
  cluster         = aws_ecs_cluster.kgt.id
  task_definition = aws_ecs_task_definition.kgt_app.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = data.aws_subnets.default.ids
    security_groups  = [aws_security_group.kgt_app.id]
    assign_public_ip = true
  }

  tags = {
    Name = "${var.app_name}-service-tf"
    Env  = "formation"
  }
}
