
# Ligthsail

resource "spacelift_stack" "lightsail-stack" {
  name = "lightsail-servers"
  space_id = "root"

  repository = "spacelift"
  branch = "main"
  project_root = "lightsail"
}


# IAM role.
resource "aws_iam_role" "lightsail-stack" {
  name = "lightsail-stack"

  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      jsondecode(
        spacelift_stack.lightsail-stack.aws_assume_role_policy_statement
      )
    ]
  })
}

# Attaching a policy to it
resource "aws_iam_role_policy_attachment" "managed-stack" {
  role       = aws_iam_role.lightsail-stack.name
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}

# Telling Spacelift stack to assume it.
resource "spacelift_stack_aws_role" "lightsail-stack" {
  stack_id = spacelift_stack.lightsail-stack.id
  role_arn = aws_iam_role.lightsail-stack.arn
}

# EKS Dev

resource "spacelift_stack" "eks-dev" {
  name = "eks-servers"
  space_id = "root"

  repository = "spacelift"
  branch = "main"
  project_root = "eks/karpenter"
}


# IAM role.
resource "aws_iam_role" "eks-dev" {
  name = "eks-dev"

  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      jsondecode(
        spacelift_stack.eks-dev.aws_assume_role_policy_statement
      )
    ]
  })
}

# Attaching a policy to it
resource "aws_iam_role_policy_attachment" "managed-stack" {
  role       = aws_iam_role.eks-dev.name
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}

# Telling Spacelift stack to assume it.
resource "spacelift_stack_aws_role" "eks-dev" {
  stack_id = spacelift_stack.eks-dev.id
  role_arn = aws_iam_role.eks-dev.arn
}