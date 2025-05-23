# IAM group
resource "aws_iam_group" "symaon_iam_group" {
  for_each = toset(var.symaon_iam_group_name)
  name = each.key
}

resource "aws_iam_user" "symaon_iam_user" {
  for_each = toset(var.users)
  name = each.key
}
