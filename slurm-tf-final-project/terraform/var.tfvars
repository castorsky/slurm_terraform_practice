cidr_blocks = [
  ["192.168.11.0/24"],
  ["192.168.12.0/24"],
  ["192.168.13.0/24"]
]

resources = {
  platform = "standard-v3"
  cpu = 2
  memory = 1
  disk = 20
  core_fraction = 20
}

image_family = "centos"
