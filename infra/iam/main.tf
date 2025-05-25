# IAM group
resource "aws_iam_group" "symaon_iam_group" {
  for_each = toset(var.group_name)
  name = each.value
}

resource "aws_iam_user" "symaon_iam_user" {
  for_each = toset([
    for name in var.users : split("-", name)[1]
  ])
  name = each.value
}

# example backend-user to backend group,
resource "aws_iam_group_membership" "symaon_participate" {
  for_each = local.grouped_users
  name  = "${each.key}-group-members"
  users = each.value
  group = each.key
}

# think about policy, exmaple lambda
resource "aws_iam_policy" "symaon_lambda" {
  name = "symaonLambda"
  description = "Policy to allow Lambda deployment"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "lambda:CreateFunction",
          "lambda:UpdateFunctionCode",
          "lambda:UpdateFunctionConfiguration",
          "iam:PassRole"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "symaon_ec2" {
  name = "symaonEC2"
  description = "Policy to allow EC2 deployment"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:RunInstances",
          "ec2:AssociateIamInstanceProfile",
          "ec2:DisassociateIamInstanceProfile",
          "ec2:ReplaceIamInstanceProfileAssociation"
        ]
        Resource = "*"
      }
    ]
  })
}

# attach to group the policy
resource "aws_iam_group_policy_attachment" "symaon_attach_lambda_policy" {
  policy_arn = aws_iam_policy.symaon_lambda.arn
  group = aws_iam_group.symaon_iam_group[var.backend].name
}
