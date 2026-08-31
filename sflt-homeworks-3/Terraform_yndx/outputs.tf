# Значения, которые Terraform выведет в консоль после apply
# (и которые можно получить командой `terraform output`).
#
# Так как ВМ теперь может быть несколько (count в main.tf), все outputs —
# списки: элемент с индексом N относится к yandex_compute_instance.this[N].

output "internal_ip_addresses" {
  description = "Внутренние IP-адреса всех ВМ (в пределах подсети из network.tf)."
  value       = [for vm in yandex_compute_instance.this : vm.network_interface.0.ip_address]
}

output "external_ip_addresses" {
  description = "Внешние (публичные) IP-адреса всех ВМ. Пусто, если assign_public_ip = false."
  # try(...) нужен, чтобы не падать с ошибкой, если nat_ip_address отсутствует
  # (когда assign_public_ip = false и внешнего IP просто нет).
  value = [for vm in yandex_compute_instance.this : try(vm.network_interface.0.nat_ip_address, null)]
}

output "ssh_connect_commands" {
  description = "Готовые команды для подключения по SSH к каждой ВМ (работает только при assign_public_ip = true)."
  value = [
    for vm in yandex_compute_instance.this :
    try("ssh ${var.ssh_user}@${vm.network_interface.0.nat_ip_address}", null)
  ]
}

output "target_group_id" {
  description = "ID target-группы со всеми созданными ВМ. null, если create_target_group = false (см. target_group.tf)."
  value       = try(yandex_lb_target_group.this[0].id, null)
}

output "load_balancer_ip_address" {
  description = "Внешний IP-адрес сетевого балансировщика (слушает порт 80). null, если create_load_balancer/create_target_group = false (см. load_balancer.tf)."
  # listener и external_address_spec — блоки типа "set", поэтому для
  # обращения по индексу их сначала нужно привести к списку через tolist().
  value = try(tolist(tolist(yandex_lb_network_load_balancer.this[0].listener)[0].external_address_spec)[0].address, null)
}
