# IAM group
resource "aws_iam_group" "symaon_iam_group" {
  for_each = toset(var.symaon_iam_group_name)
  name = each.value
}

resource "aws_iam_user" "symaon_iam_user" {
  for_each = toset(var.users)
  name = each.value
}

# access each value to add in group
resource "aws_iam_user_group_membership" "symaon_backend" {
  user = aws_iam_user.symaon_iam_user["name"].name
  groups = [ 
    aws_iam_group.symaon_iam_group["name"].name
   ]
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

# attach to group the policy
resource "aws_iam_group_policy_attachment" "symaon_attach_lambda_policy" {
  policy_arn = aws_iam_policy.symaon_lambda.arn
  group = aws_iam_group.symaon_iam_group[""].name
}
