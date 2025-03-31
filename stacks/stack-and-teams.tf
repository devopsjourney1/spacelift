resource "github_team" "stack-readers" {
  name = "managed-stack-readers"
}

resource "github_team" "stack-writers" {
  name = "managed-stack-writers"
}

resource "spacelift_stack" "lightsail-stack" {
  name = "lightsail-servers"
  space_id = "root"

  repository = "spacelift"
  branch = "main"
  project_root = "lightsail"
}


# Telling Spacelift stack to assume it.
resource "spacelift_stack_aws_role" "lightsail-stack" {
  stack_id = spacelift_stack.lightsail-stack.id
  role_arn = "arn:aws:iam::688062348185:role/spacelift"
}
