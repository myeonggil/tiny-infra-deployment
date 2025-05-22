# definition auto scaling group, instance, ec2, template

resource "tls_private_key" "tiny_rsa" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "tiny_pem_key" {
  key_name = "tiny-key"
  public_key = tls_private_key.tiny_rsa.public_key_openssh

  provisioner "local-exec" {
    command = "echo ${tls_private_key.tiny_rsa.private_key_pem} > ./tiny_key.pem"
  }
  tags = {
    Name = "tiny-pem-key"
  }
}

resource "aws_launch_template" "tiny_ec2_template" {
  name = var.service_name
  block_device_mappings {
    device_name = "/dev/sdf"
    ebs {
      volume_size = 20
      volume_type = "gp2"
    }
  }
  tags = {
    Name = "tiny-ec2-template"
  }
  image_id = "ami-06087749a704b8168"
  instance_type = var.instance_type
  key_name = aws_key_pair.tiny_pem_key.key_name
  network_interfaces {
    subnet_id = var.tiny_subnet_group_id
    security_groups = [ var.tiny_sg_id ]
  }
}

resource "aws_autoscaling_group" "tiny_ec2_starter" {
  min_size = 1
  max_size = 1
  desired_capacity = 1
  name = var.service_name
  # launch_template {
  #   id = aws_launch_template.tiny_ec2_template.id
  #   version = "$Latest"
  # }
  # load_balancers = ""
  # instance_maintenance_policy {
  #   min_healthy_percentage = 90
  #   max_healthy_percentage = 120 
  # }
  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.tiny_ec2_template.id
      }
    }
    instances_distribution {
      on_demand_base_capacity = 0
      on_demand_percentage_above_base_capacity = 60
      spot_allocation_strategy = "capacity-optimized"
    }
  }
}
