resource "yandex_vpc_network" "this" {
  description = "True Yandex Ops Network"
}

resource "yandex_vpc_subnet" "this" {
  for_each       = toset(var.az)
  network_id     = yandex_vpc_network.this.id
  v4_cidr_blocks = var.cidr_blocks[index(var.az, each.value)]
  zone           = each.value
}
