variable "instance_count" {
  type        = number
  description = "The number of instances to provision"
  default     = 3
}

variable "availability_zone" {
  type        = string
  description = "The availability zone of your instance"
  default     = "us-west-2a"
}
