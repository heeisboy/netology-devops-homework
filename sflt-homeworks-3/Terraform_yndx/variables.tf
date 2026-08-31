# Объявление всех настраиваемых параметров конфигурации.
# Здесь только описания и значения по умолчанию — реальные значения
# для вашего облака задаются в terraform.tfvars (см. этот файл).

# ---------------------------------------------------------------------------
# Аутентификация и адрес ресурсов (обязательные параметры)
# ---------------------------------------------------------------------------

variable "yc_token" {
  description = "OAuth или IAM-токен Yandex Cloud (способ авторизации №1). Оставьте null, если используете yc_service_account_key_file."
  type        = string
  default     = null
  sensitive   = true
}

variable "yc_service_account_key_file" {
  description = "Путь к JSON-файлу авторизованного ключа сервисного аккаунта (способ авторизации №2, рекомендуемый). Оставьте null, если используете yc_token."
  type        = string
  default     = null
}

variable "yc_cloud_id" {
  description = "ID облака Yandex Cloud. Смотреть: консоль → обзор облака, либо `yc config list`."
  type        = string
  default     = null
}

variable "yc_folder_id" {
  description = "ID каталога (folder) Yandex Cloud, в котором создаются ресурсы. Смотреть: консоль → каталог → настройки, либо `yc config list`."
  type        = string
  default     = null
}

variable "yc_zone" {
  description = <<-EOT
    Зона доступности, в которой создаются ресурсы (сеть/подсеть/ВМ).
    Варианты (регион ru-central1):
      "ru-central1-a" (используется сейчас)
      "ru-central1-b"
      "ru-central1-d"
    Актуальный список зон: https://yandex.cloud/ru/docs/overview/concepts/geo-scope
  EOT
  type        = string
  default     = "ru-central1-a"
}

# ---------------------------------------------------------------------------
# Параметры виртуальной машины
# ---------------------------------------------------------------------------

variable "vm_name" {
  description = "Базовое имя ВМ (используется и как основа имени сети/подсети). При vm_count > 1 к имени каждой ВМ добавляется порядковый номер: example-vm-1, example-vm-2, ..."
  type        = string
  default     = "example-vm"
}

variable "vm_count" {
  description = "Сколько одинаковых ВМ создать. Все они получат одинаковую конфигурацию (ресурсы, диск, образ), но разные имена/id и подключатся к одной и той же подсети."
  type        = number
  default     = 1
}

variable "vm_platform_id" {
  description = <<-EOT
    Платформа (поколение процессора) ВМ. Варианты:
      "standard-v3" (используется сейчас) — Intel Ice Lake, самое актуальное поколение
      "standard-v2"                       — Intel Cascade Lake
      "standard-v1"                       — Intel Broadwell, самое старое/дешёвое поколение
      "gpu-standard-v3"                   — с GPU (для ML/рендеринга)
    Подробнее: https://yandex.cloud/ru/docs/compute/concepts/vm-platforms
  EOT
  type        = string
  default     = "standard-v3"
}

variable "vm_cores" {
  description = "Количество vCPU."
  type        = number
  default     = 2
}

variable "vm_memory" {
  description = "Объём RAM в ГБ."
  type        = number
  default     = 2
}

variable "vm_core_fraction" {
  description = <<-EOT
    Гарантированная доля производительности vCPU, в процентах. Варианты:
      100 (используется сейчас) — полная (негарантированная) мощность ядра постоянно, дороже
      50                        — дешевле, ядро может "разгоняться" до 100% при нагрузке
      20                        — ещё дешевле, для лёгких/фоновых задач
      5                         — самый дешёвый вариант, для очень редкой нагрузки
    Подробнее: https://yandex.cloud/ru/docs/compute/concepts/performance-levels
  EOT
  type        = number
  default     = 100
}

# ---------------------------------------------------------------------------
# Загрузочный диск
# ---------------------------------------------------------------------------

variable "boot_disk_type" {
  description = <<-EOT
    Тип загрузочного диска. Варианты:
      "network-hdd"              (используется сейчас) — сетевой HDD, самый дешёвый
      "network-ssd"                                     — сетевой SSD, быстрее
      "network-ssd-nonreplicated"                        — сетевой SSD без репликации, ещё быстрее, но менее надёжен
      "local-ssd"                                        — локальный SSD, максимальная скорость, но диск живёт только пока жива ВМ
    Подробнее: https://yandex.cloud/ru/docs/compute/concepts/disk
  EOT
  type        = string
  default     = "network-hdd"
}

variable "boot_disk_size" {
  description = "Размер загрузочного диска в ГБ."
  type        = number
  default     = 20
}

# ---------------------------------------------------------------------------
# Образ операционной системы
# ---------------------------------------------------------------------------

variable "image_family" {
  description = <<-EOT
    Семейство публичного образа ОС (провайдер сам возьмёт последнюю версию
    внутри семейства через data "yandex_compute_image", см. main.tf). Варианты:
      "ubuntu-2204-lts" (используется сейчас)
      "ubuntu-2404-lts"
      "debian-12"
      "centos-stream-9"
    Полный список публичных образов: `yc compute image list --folder-id standard-images`
  EOT
  type        = string
  default     = "ubuntu-2204-lts"
}

# ---------------------------------------------------------------------------
# Сеть
# ---------------------------------------------------------------------------

variable "network_cidr" {
  description = "CIDR для создаваемой подсети (диапазон внутренних IP-адресов ВМ)."
  type        = string
  default     = "10.10.0.0/24"
}

variable "assign_public_ip" {
  description = "Выдавать ли ВМ публичный (внешний) IP-адрес через NAT. false — ВМ будет доступна только из внутренней сети/по VPN."
  type        = bool
  default     = true
}

# ---------------------------------------------------------------------------
# Target-группа (для Network Load Balancer)
# ---------------------------------------------------------------------------

variable "create_target_group" {
  description = "Создавать ли target-группу и добавлять в неё все созданные ВМ. Сама target-группа лишь группирует адресатов — балансировщик (yandex_lb_network_load_balancer) в этой конфигурации не создаётся и подключается к группе отдельно."
  type        = bool
  default     = true
}

variable "target_group_name" {
  description = "Имя target-группы. Если не задано (null) — используется \"<vm_name>-target-group\"."
  type        = string
  default     = null
}

# ---------------------------------------------------------------------------
# Сетевой балансировщик нагрузки (Network Load Balancer)
# ---------------------------------------------------------------------------

variable "create_load_balancer" {
  description = "Создавать ли сетевой балансировщик нагрузки (слушает порт 80, отправляет трафик на порт 80 ВМ, HTTP healthcheck по порту 80). Требует create_target_group = true — без target-группы балансировщику некуда направлять трафик."
  type        = bool
  default     = true
}

variable "lb_name" {
  description = "Имя балансировщика. Если не задано (null) — используется \"<vm_name>-lb\"."
  type        = string
  default     = null
}

# ---------------------------------------------------------------------------
# Доступ по SSH
# ---------------------------------------------------------------------------

variable "ssh_user" {
  description = <<-EOT
    Имя пользователя для SSH-доступа. Должно соответствовать выбранному образу:
      "ubuntu" (используется сейчас) — подходит для image_family = "ubuntu-*"
      "debian"                       — для image_family = "debian-*"
      "centos"                       — для image_family = "centos-*"
  EOT
  type        = string
  default     = "ubuntu"
}

variable "ssh_public_key_path" {
  description = "Путь к публичному SSH-ключу (файл *.pub), который будет добавлен в metadata ВМ. Поддерживает ~ (домашний каталог)."
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "ssh_private_key_path" {
  description = "Путь к приватному SSH-ключу, парному к ssh_public_key_path — используется Ansible-инвентарём (ansible/inventory.ini) для подключения к ВМ. Если не задано (null) — берётся ssh_public_key_path с обрезанным \".pub\"."
  type        = string
  default     = null
}

# ---------------------------------------------------------------------------
# Ansible-инвентарь
# ---------------------------------------------------------------------------

variable "generate_ansible_inventory" {
  description = "Генерировать ли файл ansible/inventory.ini со списком созданных ВМ (для последующего запуска ansible-playbook ansible/playbook.yml)."
  type        = bool
  default     = true
}
