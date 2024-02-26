resource "yandex_iam_service_account" "this" {
  name        = "vmmanager"
  description = "Service account to manage VMs"
}

resource "yandex_resourcemanager_folder_iam_binding" "this" {
  folder_id = "${local.folder_id}"
  members   = [
    "serviceAccount:${yandex_iam_service_account.this.id}"
  ]
  role      = "editor"
}
