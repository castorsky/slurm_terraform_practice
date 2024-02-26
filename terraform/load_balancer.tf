resource "yandex_alb_backend_group" "this" {
  name = "first-backend-group"
  http_backend {
    name             = "first-http-backend"
    weight           = 1
    port             = 80
    target_group_ids = [
      yandex_compute_instance_group.this.application_load_balancer[0].target_group_id
    ]

    load_balancing_config {
      panic_threshold = 40
      mode            = "ROUND_ROBIN"
    }

    healthcheck {
      interval         = "5s"
      timeout          = "5s"
      healthcheck_port = 80
      http_healthcheck {
        path = "/"
      }
    }
  }
}

resource "yandex_alb_http_router" "this" {
  name = "first-http-router"
}

resource "yandex_alb_virtual_host" "this" {
  http_router_id = yandex_alb_http_router.this.id
  name           = "first-virtual-host"
  route {
    name = "first-http-route"
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.this.id
      }
    }
  }
}

resource "yandex_alb_load_balancer" "this" {
  name       = "first-load-balancer"
  network_id = yandex_vpc_network.this.id

  allocation_policy {
    dynamic "location" {
      for_each = yandex_vpc_subnet.this
      content {
        subnet_id = location.value.id
        zone_id   = location.value.zone
      }
    }
  }

  listener {
    name = "first-http-listener"

    endpoint {
      ports = [ 80 ]
      address {
        external_ipv4_address {}
      }
    }

    http {
      handler {
        http_router_id = yandex_alb_http_router.this.id
      }
    }
  }
}

