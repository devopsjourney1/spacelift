
resource "spacelift_stack" "lightsail-stack" {
  name = "lightsail-servers"
  space_id = "root"

  namespace = "devopsjourney1"
  repository = "spacelift"
  branch = "main"
  project_root = "lightsail"
}


resource "spacelift_aws_integration_attachment" "my_stack" {
  integration_id = "spacelift"
  stack_id       = "lightsail-servers"
  read           = true
  write          = true

}

