resource "github_team" "stack-readers" {
  name = "managed-stack-readers"
}

resource "github_team" "stack-writers" {
  name = "managed-stack-writers"
}

resource "spacelift_stack" "managed-stack" {
  name = "Stack managed by Spacelift"

  # Source code.
  repository = "spacelift"
  branch     = "main"

}


# Telling Spacelift stack to assume it.
resource "spacelift_stack_aws_role" "managed-stack" {
  stack_id = spacelift_stack.managed-stack.id
  role_arn = "arn:aws:iam::688062348185:role/spacelift"
}
