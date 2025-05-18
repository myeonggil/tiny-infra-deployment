# Team of DevOps

# 1. How to manage infrastructure?
- You can manage tfstate file at local or remote store
- If you work with your team, you have to manage tfstate file at remote store
# 2. How to write hcl?
```
resource "aws_vpc" "main" {
  cidr_block = var.base_cidr_block
}

<BLOCK TYPE> "<BLOCK LABEL>" "<BLOCK LABEL>" {
  # Block body
  <IDENTIFIER> = <EXPRESSION> # Argument
}

```
# 3. What is IaC lifecycle?
```shell
# init terraform
terraform init

# plan terraform
terraform plan

# deploy terraform
terraform apply

# destroy terraform
terraform destroy
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.72.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.72.0 |
| <a name="provider_http"></a> [http](#provider\_http) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_compute"></a> [compute](#module\_compute) | ./compute | n/a |
| <a name="module_container"></a> [container](#module\_container) | ./container | n/a |
| <a name="module_dns"></a> [dns](#module\_dns) | ./dns | n/a |
| <a name="module_lb"></a> [lb](#module\_lb) | ./lb | n/a |
| <a name="module_network"></a> [network](#module\_network) | ./network | n/a |
| <a name="module_rds"></a> [rds](#module\_rds) | ./rds | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/5.72.0/docs/data-sources/availability_zones) | data source |
| [http_http.icanhazip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Already registered | `any` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | compute | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | deploy region | `string` | `"ap-northeast-2"` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | service name | `any` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | vpc cidr | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_region"></a> [region](#output\_region) | n/a |
<!-- END_TF_DOCS -->