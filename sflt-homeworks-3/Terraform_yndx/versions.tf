# Настройки самого Terraform (не Yandex Cloud) — какая версия CLI и какая
# версия провайдера нужны для этой конфигурации.
terraform {
  # Минимальная версия Terraform CLI. Проверить свою: `terraform version`.
  required_version = ">= 1.5.0"

  required_providers {
    # Провайдер yandex-cloud/yandex — "переводчик" между HCL-описанием
    # ресурсов ниже и реальным Yandex Cloud API.
    # Актуальные версии: https://registry.terraform.io/providers/yandex-cloud/yandex/latest
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.130.0"
    }

    # Провайдер local — используется только для записи ansible/inventory.ini
    # (см. ansible_inventory.tf), ни с каким внешним API не общается.
    local = {
      source  = "hashicorp/local"
      version = ">= 2.4.0"
    }
  }
}
