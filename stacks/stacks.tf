
resource "spacelift_stack" "lightsail-stack" {
  name = "lightsail-servers"
  space_id = "root"

  repository = "spacelift"
  branch = "main"
  project_root = "lightsail"
}
