# Сетевой балансировщик нагрузки (L4 NLB): принимает внешний трафик на
# порту 80 и распределяет его по ВМ из target_group.tf, тоже на порт 80.
# Здоровье ВМ проверяется HTTP-healthcheck'ом на том же порту 80 — ВМ,
# не отвечающая на него, временно исключается из балансировки.

resource "yandex_lb_network_load_balancer" "this" {
  count = (var.create_target_group && var.create_load_balancer) ? 1 : 0

  name = coalesce(var.lb_name, "${var.vm_name}-lb")

  # region_id выводится из var.yc_zone, как и в target_group.tf.
  region_id = replace(var.yc_zone, "/-[a-z]$/", "")

  listener {
    name = "http"
    port = 80
    # target_port не задан — по умолчанию равен port (80), то есть трафик
    # приходит на ВМ тем же портом 80, на котором его принял балансировщик.

    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.this[0].id

    healthcheck {
      name = "http"

      http_options {
        port = 80
        path = "/"
      }
    }
  }
}
