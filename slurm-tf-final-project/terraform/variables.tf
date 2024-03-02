variable "token" {
  type = string
  description = "Cloud.Yandex connection: token value"
  default = ""
}

variable "cloud_id" {
  type = string
  description = "Cloud.Yandex connection: cloud ID value"
  default = ""
}

variable "folder_id" {
  type = string
  description = "Cloud.Yandex connection: folder ID value"
  default = ""
}

variable "az" {
  type    = list(string)
  default = [
    "ru-central1-a",
    "ru-central1-b",
    "ru-central1-d"
  ]
  description = "List of availabiliy zones to use in project"
}

variable "cidr_blocks" {
  type        = list(list(string))
  description = "List of lists of IPv4 subnets for each subnet"
}

variable "resources" {
  type = object({
    platform = string
    cpu = number
    memory = number
    disk = number
    core_fraction = number
  })
  description = "Virtual resources definition to use when creating instances"
}

variable "image_family" {
  type = string
  description = "Image family to use when provisioning new instance (e.g., centos-7)"
}

variable "public_ssh_key_path" {
  type = string
  description = "Path to the SSH public key (if not defined then will be generated)"
  default = ""
}

variable "vm_number" {
  type = number
  default = -1
  description = "Number of virtual instances to create inside an instance_group"
}
