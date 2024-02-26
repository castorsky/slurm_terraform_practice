variable "image_version" {
  type = number
  description = "Version number (> 1)"
}

source "yandex" "nginx" {
  folder_id           = "b1gb8hdq6c2nrgv3o033"
  token               = "y0_AgAAAAACWOMGAATuwQAAAAD7EF53AADHw3V9xiFDFJZt7HDzxEDtiQDWPQ"
  source_image_family = "centos-7"
  ssh_username        = "centos"
  use_ipv4_nat        = "true"
  image_family        = "centos"
  image_name          = "nginx-v${var.image_version}"
  subnet_id           = "e9btuqj1h85o1v0in53p"
}

build {
  sources = ["source.yandex.nginx"]

  provisioner "ansible" {
    playbook_file = "./playbook.yml"
    sftp_command  = "/usr/libexec/openssh/sftp-server -e"
    use_proxy     = "false"
  }

}
