# Сетевая инфраструктура для ВМ: облачная сеть (VPC) + подсеть в одной зоне.
# ВМ не может существовать без подсети — сетевой интерфейс ссылается на неё
# в main.tf (network_interface.subnet_id).

# Облачная сеть — просто контейнер верхнего уровня для подсетей.
# В одной сети можно создать несколько подсетей в разных зонах.
resource "yandex_vpc_network" "this" {
  name = "${var.vm_name}-network"
}

# Подсеть — тут уже задаётся конкретная зона доступности и диапазон
# внутренних IP-адресов (CIDR), из которого ВМ получит внутренний IP.
resource "yandex_vpc_subnet" "this" {
  name       = "${var.vm_name}-subnet"
  zone       = var.yc_zone # должна совпадать с зоной самой ВМ (var.yc_zone в main.tf)
  network_id = yandex_vpc_network.this.id

  v4_cidr_blocks = [var.network_cidr] # см. variable "network_cidr" в variables.tf
}
