resource "aws_ecs_task_definition" "app" {
  family                   = var.container_name
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  network_mode             = "awsvpc"
  task_role_arn            = aws_iam_role.task_execution_role.arn
  execution_role_arn       = aws_iam_role.task_execution_role.arn
  container_definitions    = <<EOF
[
  {
    "logConfiguration": {
      "logDriver": "awslogs",
      "secretOptions": null,
      "options": {
        "awslogs-group": "${aws_cloudwatch_log_group.task_log.name}",
        "awslogs-region": "${data.aws_region.current.name}",
        "awslogs-stream-prefix": "ecs"
      }
    },
    "portMappings": [
      {
        "hostPort": 80,
        "protocol": "tcp",
        "containerPort": 80
      }
    ],
    "cpu": 0,
    "image": "${aws_ecr_repository.app.repository_url}:latest",
    "name": "${var.container_name}"
  }
]
EOF

}

# Service resource without load balancer
resource "aws_ecs_service" "app" {
  name            = var.container_name
  cluster         = aws_ecs_cluster.app.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = [var.security_group_id]
    assign_public_ip = var.assign_public_ip
  }
}

resource "aws_ecs_cluster" "app" {
  name               = "app"
  capacity_providers = ["FARGATE_SPOT"]

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
  }

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_cloudwatch_log_group" "task_log" {
  name = "/ecs/${var.environment}/${var.container_name}"
}
