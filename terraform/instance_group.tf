data "yandex_compute_image" "this" {
  family    = var.image_family
  folder_id = local.folder_id
}

resource "yandex_compute_instance_group" "this" {
  depends_on = [
    yandex_resourcemanager_folder_iam_binding.this,
    yandex_vpc_subnet.this
  ]
  service_account_id = yandex_iam_service_account.this.id
  name               = "first-instance-group"
  folder_id          = local.folder_id

  instance_template {
    platform_id = "standard-v3"
    resources {
      cores         = var.resources.cpu
      memory        = var.resources.memory
      core_fraction = var.resources.core_fraction
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = data.yandex_compute_image.this.id
        size     = var.resources.disk
      }
    }

    network_interface {
      network_id = yandex_vpc_network.this.id
      subnet_ids = [
        for subnet in values(yandex_vpc_subnet.this) : subnet.id
      ]
      nat        = true
    }

    metadata = {
      ssh-keys = "centos:${file("./id_ed25519.pub")}"
    }

  }

  scale_policy {
    fixed_scale {
      size = length(var.az)
    }
  }

  allocation_policy {
    zones = var.az
  }

  deploy_policy {
    max_unavailable = 1
    max_expansion   = 1
  }

  application_load_balancer {
    target_group_name = "this-tg-name"
  }

}