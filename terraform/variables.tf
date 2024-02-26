locals {
  folder_id = "b1gb8hdq6c2nrgv3o033"
}

variable "az" {
  type    = list(string)
  default = [
    "ru-central1-a",
    "ru-central1-b",
    "ru-central1-d"
  ]
}

variable "cidr_blocks" {
  type        = list(list(string))
  description = "List of lists of IPv4 subnets for each subnet"
}

variable "resources" {
  type = object({
    cpu = number
    memory = number
    disk = number
    core_fraction = number
  })
}

variable "image_family" {
  type = string
  description = "Image family to use when provisioning new instance (e.g., centos-7)"
}
