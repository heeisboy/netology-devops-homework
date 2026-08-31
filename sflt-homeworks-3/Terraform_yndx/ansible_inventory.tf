# Генерирует ansible/inventory.ini со всеми созданными ВМ, чтобы не
# собирать список хостов для Ansible вручную после каждого apply.
# Сам плейбук — ansible/playbook.yml.

locals {
  # Приватный ключ для Ansible: явно заданный var.ssh_private_key_path,
  # либо var.ssh_public_key_path с обрезанным ".pub".
  ansible_ssh_private_key_path = coalesce(
    var.ssh_private_key_path,
    replace(var.ssh_public_key_path, "/\\.pub$/", "")
  )
}

resource "local_file" "ansible_inventory" {
  count = var.generate_ansible_inventory ? 1 : 0

  filename = "${path.module}/ansible/inventory.ini"

  content = templatefile("${path.module}/ansible/inventory.tpl", {
    instances = [
      for vm in yandex_compute_instance.this : {
        name = vm.name
        # Внешний IP, если он есть (assign_public_ip = true), иначе
        # внутренний — тогда ansible-playbook нужно запускать из той же
        # сети/VPN, что и сами ВМ.
        ip = try(vm.network_interface[0].nat_ip_address, vm.network_interface[0].ip_address)
      }
    ]
    ssh_user             = var.ssh_user
    ssh_private_key_path = pathexpand(local.ansible_ssh_private_key_path)
  })
}
