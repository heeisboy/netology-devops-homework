# Target-группа объединяет созданные ВМ в единый пул адресатов для
# балансировки нагрузки (Network Load Balancer). Сам NLB тут не создаётся —
# группа лишь готова к тому, чтобы её подключили к
# yandex_lb_network_load_balancer через attached_target_group.

resource "yandex_lb_target_group" "this" {
  count = var.create_target_group ? 1 : 0

  name = coalesce(var.target_group_name, "${var.vm_name}-target-group")

  # region_id выводится из var.yc_zone (например, "ru-central1-a" -> "ru-central1"),
  # чтобы не задавать регион отдельной переменной и не рассинхронизировать его с зоной.
  region_id = replace(var.yc_zone, "/-[a-z]$/", "")

  # dynamic-блок добавляет в группу по одному target на каждую созданную
  # ВМ (yandex_compute_instance.this, count = var.vm_count в main.tf).
  # В таргет-группу NLB попадают только внутренние адреса ВМ.
  dynamic "target" {
    for_each = yandex_compute_instance.this
    content {
      subnet_id = target.value.network_interface.0.subnet_id
      address   = target.value.network_interface.0.ip_address
    }
  }
}
