# Do not generate (count=0) if SSH pubkey is defined in input variables
resource "tls_private_key" "this" {
  count = var.public_ssh_key_path == "" ? 1 : 0
  algorithm = "ED25519"
}
