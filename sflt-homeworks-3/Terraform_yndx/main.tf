# Сама виртуальная машина и образ ОС, из которого она создаётся.

# data-источник — не создаёт ресурс, а просто ищет в каталоге публичных
# образов (folder-id = standard-images) последнюю версию образа из
# заданного семейства (var.image_family, см. variables.tf) и возвращает
# его актуальный image_id. Благодаря этому не нужно вручную обновлять
# id образа при выходе новых версий Ubuntu/Debian/CentOS.
data "yandex_compute_image" "boot" {
  family = var.image_family
}

resource "yandex_compute_instance" "this" {
  # count создаёт var.vm_count одинаковых копий этого ресурса:
  # yandex_compute_instance.this[0], .this[1], .this[2] и т.д.
  # Обращение к конкретной ВМ или ко всем сразу — см. outputs.tf.
  count = var.vm_count

  # count.index — порядковый номер копии, начиная с 0. Добавляем +1,
  # чтобы имена были example-vm-1, example-vm-2, ... (без -0).
  #
  # name     — имя ресурса в консоли/API Yandex Cloud.
  # hostname — имя хоста ВНУТРИ гостевой ОС (то, что видно в приглашении
  #            терминала user@hostname:~$ и в внутреннем DNS). Если не
  #            задать — облако сгенерирует случайную строку вида
  #            fhm6lrnf2q90k3bijheu. Держим оба значения одинаковыми.
  name        = "${var.vm_name}-${count.index + 1}" # variables.tf: vm_name
  hostname    = "${var.vm_name}-${count.index + 1}"
  platform_id = var.vm_platform_id # variables.tf: vm_platform_id (поколение CPU)
  zone        = var.yc_zone        # variables.tf: yc_zone — должна совпадать с зоной подсети (network.tf)

  # Вычислительные ресурсы ВМ.
  resources {
    cores         = var.vm_cores         # variables.tf: vm_cores
    memory        = var.vm_memory        # variables.tf: vm_memory (в ГБ)
    core_fraction = var.vm_core_fraction # variables.tf: vm_core_fraction (%, гарантированная доля CPU)
  }

  # Загрузочный диск: создаётся из найденного выше образа ОС.
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.boot.id # id, найденный data-источником выше
      type     = var.boot_disk_type                # variables.tf: boot_disk_type
      size     = var.boot_disk_size                # variables.tf: boot_disk_size (в ГБ)
    }
  }

  # Сетевой интерфейс: подключаем к подсети из network.tf.
  network_interface {
    subnet_id = yandex_vpc_subnet.this.id
    nat       = var.assign_public_ip # variables.tf: assign_public_ip — true = выдать внешний IP через NAT
  }

  # metadata — служебные данные, которые облако передаёт в ВМ при первом
  # старте. Ключ "ssh-keys" в формате "<user>:<публичный_ключ>" — то, как
  # Yandex Cloud добавляет SSH-доступ без пароля.
  # pathexpand() разворачивает "~" в путь до домашнего каталога
  # (голая file() этого не делает).
  metadata = {
    ssh-keys = "${var.ssh_user}:${file(pathexpand(var.ssh_public_key_path))}"

    # Альтернатива/дополнение: cloud-init скрипт первичной настройки ВМ
    # (установка пакетов, создание пользователей и т.д.). Раскомментируйте
    # и создайте файл cloud-init.yml рядом, если нужно:
    # user-data = file("${path.module}/cloud-init.yml")
  }

  # Прерываемая (preemptible) ВМ — до 2х дешевле, но может быть
  # принудительно остановлена облаком не более чем через 24 часа работы.
  # Подходит для тестовых/фоновых задач, не для прод-сервисов.
  # scheduling_policy {
  #   preemptible = true
  # }
}
