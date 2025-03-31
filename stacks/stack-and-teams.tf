resource "github_team" "stack-readers" {
  name = "managed-stack-readers"
}

resource "github_team" "stack-writers" {
  name = "managed-stack-writers"
}

resource "spacelift_stack" "lightsail-stack" {
  name = "lightsail-servers"
  space_id = "root"

  namespace = "devopsjourney1"
  repository = "spacelift"
  branch = "main"
  project_root = "lightsail"

  terraform_version = "1.9.0"
  terraform_workflow_tool = "OPEN_TOFU"
  terraform_smart_sanitization = true

  additional_project_globs = [""]
  enable_well_known_secret_masking = true
  github_action_deploy = false  
}


# Telling Spacelift stack to assume it.
resource "spacelift_stack_aws_role" "lightsail-stack" {
  stack_id = spacelift_stack.managed-stack.id
  role_arn = "arn:aws:iam::688062348185:role/spacelift"
}
