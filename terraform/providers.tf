terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "~> 0.80"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token     = "y0_AgAAAAACWOMGAATuwQAAAAD7EF53AADHw3V9xiFDFJZt7HDzxEDtiQDWPQ"
  cloud_id  = "b1gnl4o5n4kor5aq620n"
  folder_id = "b1gb8hdq6c2nrgv3o033"
}
