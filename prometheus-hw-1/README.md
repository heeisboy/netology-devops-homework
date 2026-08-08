# Домашнее задание к занятию «Система мониторинга Prometheus»

## Задание 1

Установите Prometheus.
Процесс выполнения

    Выполняя задание, сверяйтесь с процессом, отражённым в записи лекции
    Создайте пользователя prometheus
    Скачайте prometheus и в соответствии с лекцией разместите файлы в целевые директории
    Создайте сервис как показано на уроке
    Проверьте что prometheus запускается, останавливается, перезапускается и отображает статус с помощью systemctl

Требования к результату

    Прикрепите к файлу README.md скриншот systemctl status prometheus, где будет написано: prometheus.service — Prometheus Service Netology Lesson 9.4 — [Ваши ФИО]

---

## Задание 1. Решение

**systemctl status prometheus**<img width="1002" height="244" alt="изображение" src="https://github.com/user-attachments/assets/80a952f8-7400-4bc4-b559-784f33c88ff3" />

---

## Задание 2

Установите Node Exporter.
Процесс выполнения

    Выполняя ДЗ сверяйтесь с процессом отражённым в записи лекции.
    Скачайте node exporter приведённый в презентации и в соответствии с лекцией разместите файлы в целевые директории
    Создайте сервис для как показано на уроке
    Проверьте что node exporter запускается, останавливается, перезапускается и отображает статус с помощью systemctl

Требования к результату

    Прикрепите к файлу README.md скриншот systemctl status node-exporter, где будет написано: node-exporter.service — Node Exporter Netology Lesson 9.4 — [Ваши ФИО]

---

## Задание 2. Решение

**systemctl status node-exporter**<img width="1002" height="244" alt="изображение" src="https://github.com/user-attachments/assets/4c0945dc-caa8-4fba-b1ab-416ecfda8a77" />

---

## Задание 3

Подключите Node Exporter к серверу Prometheus.
Процесс выполнения

    Выполняя ДЗ сверяйтесь с процессом отражённым в записи лекции.
    Отредактируйте prometheus.yaml, добавив в массив таргетов установленный в задании 2 node exporter
    Перезапустите prometheus
    Проверьте что он запустился

Требования к результату

    Прикрепите к файлу README.md скриншот конфигурации из интерфейса Prometheus вкладки Status > Configuration
    Прикрепите к файлу README.md скриншот из интерфейса Prometheus вкладки Status > Targets, чтобы было видно минимум два эндпоинта

## Задание 3. Решение 

**Prometheus. Status -> Configuration**

```
global:
  scrape_interval: 15s
  scrape_timeout: 10s
  evaluation_interval: 15s
  metric_name_validation_scheme: utf8
  scrape_native_histograms: false
  extra_scrape_metrics: false
runtime:
  gogc: 75
alerting:
  alertmanagers:
  - follow_redirects: true
    enable_http2: true
    scheme: http
    timeout: 10s
    api_version: v2
    static_configs:
    - targets: []
scrape_configs:
- job_name: prometheus
  honor_timestamps: true
  track_timestamps_staleness: false
  scrape_interval: 15s
  scrape_timeout: 10s
  scrape_protocols:
  - OpenMetricsText1.0.0
  - OpenMetricsText0.0.1
  - PrometheusText1.0.0
  - PrometheusText0.0.4
  scrape_native_histograms: false
  always_scrape_classic_histograms: false
  convert_classic_histograms_to_nhcb: false
  metrics_path: /metrics
  scheme: http
  enable_compression: true
  metric_name_validation_scheme: utf8
  metric_name_escaping_scheme: allow-utf-8
  extra_scrape_metrics: false
  follow_redirects: true
  enable_http2: true
  static_configs:
  - targets:
    - localhost:9090
    - localhost:9100
    labels:
      app: prometheus
storage:
  tsdb:
    outofordertimewindow: 0
    retention:
      time: 15d
otlp:
  translation_strategy: UnderscoreEscapingWithSuffixes
  label_name_underscore_sanitization: true
  label_name_preserve_multiple_underscores: true
```

**Prometheus Status**<img width="1904" height="335" alt="изображение" src="https://github.com/user-attachments/assets/ee278314-2f33-4a8c-96f2-d48608231627" />

---

## Задание 4*

Установите Grafana.
Требования к результату

    Прикрепите к файлу README.md скриншот левого нижнего угла интерфейса, чтобы при наведении на иконку пользователя были видны ваши ФИО

---

## Задание 4. Решение

**Установка Grafana**

<img width="827" height="560" alt="изображение" src="https://github.com/user-attachments/assets/7910ed1f-40a3-4bae-82b2-9e3dbf6d4fdb" />

---

## Задание 5*

Интегрируйте Grafana и Prometheus.

---

## Задание 5. Решение

**Интеграция Grafana в Prometheus**

<img width="1603" height="905" alt="изображение" src="https://github.com/user-attachments/assets/46c68ffc-5b2c-41d7-978b-911a0eee0cf2" />
