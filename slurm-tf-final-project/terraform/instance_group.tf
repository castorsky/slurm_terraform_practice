data "yandex_compute_image" "this" {
  family    = var.image_family
  folder_id = var.folder_id
}

resource "yandex_compute_instance_group" "this" {
  # With depends_on destruction process finishes correctly in right order
  depends_on = [
    yandex_resourcemanager_folder_iam_binding.this,
    yandex_vpc_subnet.this
  ]
  service_account_id = yandex_iam_service_account.this.id
  name               = "first-instance-group"
  folder_id          = var.folder_id

  instance_template {
    platform_id = var.resources.platform
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

    # If SSH pubkey is not defined in input variables then generate with TLS provider 
    metadata = {
      ssh-keys = var.public_ssh_key_path != "" ? "centos:${file(var.public_ssh_key_path)}" : "centos:${tls_private_key.this[0].public_key_openssh}"
    }

  }

  # If vm_number is not defined then create one instance in each availability zone
  scale_policy {
    fixed_scale {
      size = var.vm_number == -1 ? length(var.az) : var.vm_number
    }
  }

  allocation_policy {
    # var.az is list of availability zones
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