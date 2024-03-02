variable "image_name" {
  type = string
  description = "Image name to use when generating new image"
  default = "nginx-v"
}

variable "image_version" {
  type = number
  description = "Version number (> 1)"
  default = 1
}

variable "token" {
  type = string
  description = "Cloud.Yandex connection: token value"
  default = ""
}

variable "folder_id" {
  type = string
  description = "Cloud.Yandex connection: folder ID value"
  default = ""
}

variable "subnet_id" {
  type = string
  description = "Cloud.Yandex network ID where image will be built"
  default = ""
}

source "yandex" "nginx" {
  folder_id           = var.folder_id
  token               = var.token
  source_image_family = "centos-7"
  ssh_username        = "centos"
  use_ipv4_nat        = "true"
  image_family        = "centos"
  image_name          = "${var.image_name}-${var.image_version}"
  subnet_id           = var.subnet_id
}

build {
  sources = ["source.yandex.nginx"]

  provisioner "ansible" {
    playbook_file = "./playbook.yml"
    sftp_command  = "/usr/libexec/openssh/sftp-server -e"
    use_proxy     = "false"
  }

}
