# Домашнее задание к занятию «Очереди RabbitMQ»

## Задание 1. Установка RabbitMQ

Используя Vagrant или VirtualBox, создайте виртуальную машину и установите RabbitMQ. Добавьте management plug-in и зайдите в веб-интерфейс.

Итогом выполнения домашнего задания будет приложенный скриншот веб-интерфейса RabbitMQ.

## Решение

<img width="1828" height="774" alt="Снимок экрана от 2026-10-04 20-14-59" src="https://github.com/user-attachments/assets/2f781ecd-fc09-47c6-94a1-1d321775f121" />

---

## Задание 2. Отправка и получение сообщений

Используя приложенные скрипты, проведите тестовую отправку и получение сообщения. Для отправки сообщений необходимо запустить скрипт producer.py.

Для работы скриптов вам необходимо установить Python версии 3 и библиотеку Pika. Также в скриптах нужно указать IP-адрес машины, на которой запущен RabbitMQ, заменив localhost на нужный IP.

$ pip install pika

Зайдите в веб-интерфейс, найдите очередь под названием hello и сделайте скриншот. После чего запустите второй скрипт consumer.py и сделайте скриншот результата выполнения скрипта

В качестве решения домашнего задания приложите оба скриншота, сделанных на этапе выполнения.

Для закрепления материала можете попробовать модифицировать скрипты, чтобы поменять название очереди и отправляемое сообщение.


## Решение

<img width="1099" height="507" alt="Снимок экрана от 2026-10-04 20-29-51" src="https://github.com/user-attachments/assets/8365505e-83e1-4e9e-82e0-9f67239f1529" />

<img width="1098" height="450" alt="Снимок экрана от 2026-10-04 20-29-09" src="https://github.com/user-attachments/assets/2b435b97-4ab0-4ddf-a2b1-d950655848fd" />

---

## Задание 3. Подготовка HA кластера

Используя Vagrant или VirtualBox, создайте вторую виртуальную машину и установите RabbitMQ. Добавьте в файл hosts название и IP-адрес каждой машины, чтобы машины могли видеть друг друга по имени.

Пример содержимого hosts файла:

$ cat /etc/hosts
192.168.0.10 rmq01
192.168.0.11 rmq02

После этого ваши машины могут пинговаться по имени.

Затем объедините две машины в кластер и создайте политику ha-all на все очереди.

В качестве решения домашнего задания приложите скриншоты из веб-интерфейса с информацией о доступных нодах в кластере и включённой политикой.

Также приложите вывод команды с двух нод:

$ rabbitmqctl cluster_status

Для закрепления материала снова запустите скрипт producer.py и приложите скриншот выполнения команды на каждой из нод:

$ rabbitmqadmin get queue='hello'

После чего попробуйте отключить одну из нод, желательно ту, к которой подключались из скрипта, затем поправьте параметры подключения в скрипте consumer.py на вторую ноду и запустите его.

Приложите скриншот результата работы второго скрипта.

## Решение

<img width="1469" height="608" alt="Снимок экрана от 2026-10-04 20-49-46" src="https://github.com/user-attachments/assets/203c77fe-351a-4526-9691-d49fdd6f7bad" />

<img width="1094" height="363" alt="Снимок экрана от 2026-10-04 20-51-06" src="https://github.com/user-attachments/assets/1953883c-7627-4ba3-8b5e-39f0f1fb67af" />

**Вывод команды rabbitmqctl cluster_status с двух нод:**

```

rmn@fedora:~/RabbitMQ-lession$ docker compose exec rabbitmq1 rabbitmqctl cluster_status
WARN[0000] /home/rmn/RabbitMQ-lession/docker-compose.yml: the attribute `version` is obsolete, it will be ignored, please remove it to avoid potential confusion 
RABBITMQ_ERLANG_COOKIE env variable support is deprecated and will be REMOVED in a future version. Use the $HOME/.erlang.cookie file or the --erlang-cookie switch instead.
Cluster status of node rabbit@rabbitmq1 ...
Basics

Cluster name: rabbit@rabbitmq1

Disk Nodes

rabbit@rabbitmq1
rabbit@rabbitmq2
rabbit@rabbitmq3

Running Nodes

rabbit@rabbitmq1
rabbit@rabbitmq2
rabbit@rabbitmq3

Versions

rabbit@rabbitmq1: RabbitMQ 3.10.7 on Erlang 25.0.4
rabbit@rabbitmq2: RabbitMQ 3.10.7 on Erlang 25.0.4
rabbit@rabbitmq3: RabbitMQ 3.10.7 on Erlang 25.0.4

Maintenance status

Node: rabbit@rabbitmq1, status: not under maintenance
Node: rabbit@rabbitmq2, status: not under maintenance
Node: rabbit@rabbitmq3, status: not under maintenance

Alarms

(none)

Network Partitions

(none)

Listeners

Node: rabbit@rabbitmq1, interface: [::], port: 15672, protocol: http, purpose: HTTP API
Node: rabbit@rabbitmq1, interface: [::], port: 61613, protocol: stomp, purpose: STOMP
Node: rabbit@rabbitmq1, interface: [::], port: 1883, protocol: mqtt, purpose: MQTT
Node: rabbit@rabbitmq1, interface: [::], port: 15692, protocol: http/prometheus, purpose: Prometheus exporter API over HTTP
Node: rabbit@rabbitmq1, interface: [::], port: 25672, protocol: clustering, purpose: inter-node and CLI tool communication
Node: rabbit@rabbitmq1, interface: [::], port: 5672, protocol: amqp, purpose: AMQP 0-9-1 and AMQP 1.0
Node: rabbit@rabbitmq2, interface: [::], port: 15672, protocol: http, purpose: HTTP API
Node: rabbit@rabbitmq2, interface: [::], port: 61613, protocol: stomp, purpose: STOMP
Node: rabbit@rabbitmq2, interface: [::], port: 1883, protocol: mqtt, purpose: MQTT
Node: rabbit@rabbitmq2, interface: [::], port: 15692, protocol: http/prometheus, purpose: Prometheus exporter API over HTTP
Node: rabbit@rabbitmq2, interface: [::], port: 25672, protocol: clustering, purpose: inter-node and CLI tool communication
Node: rabbit@rabbitmq2, interface: [::], port: 5672, protocol: amqp, purpose: AMQP 0-9-1 and AMQP 1.0
Node: rabbit@rabbitmq3, interface: [::], port: 15672, protocol: http, purpose: HTTP API
Node: rabbit@rabbitmq3, interface: [::], port: 61613, protocol: stomp, purpose: STOMP
Node: rabbit@rabbitmq3, interface: [::], port: 1883, protocol: mqtt, purpose: MQTT
Node: rabbit@rabbitmq3, interface: [::], port: 15692, protocol: http/prometheus, purpose: Prometheus exporter API over HTTP
Node: rabbit@rabbitmq3, interface: [::], port: 25672, protocol: clustering, purpose: inter-node and CLI tool communication
Node: rabbit@rabbitmq3, interface: [::], port: 5672, protocol: amqp, purpose: AMQP 0-9-1 and AMQP 1.0

Feature flags

Flag: classic_mirrored_queue_version, state: enabled
Flag: drop_unroutable_metric, state: enabled
Flag: empty_basic_get_metric, state: enabled
Flag: implicit_default_bindings, state: enabled
Flag: maintenance_mode_status, state: enabled
Flag: quorum_queue, state: enabled
Flag: stream_queue, state: enabled
Flag: user_limits, state: enabled
Flag: virtual_host_metadata, state: enabled

```

```

rmn@fedora:~/RabbitMQ-lession$ docker compose exec rabbitmq2 rabbitmqctl cluster_status
WARN[0000] /home/rmn/RabbitMQ-lession/docker-compose.yml: the attribute `version` is obsolete, it will be ignored, please remove it to avoid potential confusion 
RABBITMQ_ERLANG_COOKIE env variable support is deprecated and will be REMOVED in a future version. Use the $HOME/.erlang.cookie file or the --erlang-cookie switch instead.
Cluster status of node rabbit@rabbitmq2 ...
Basics

Cluster name: rabbit@rabbitmq2

Disk Nodes

rabbit@rabbitmq1
rabbit@rabbitmq2
rabbit@rabbitmq3

Running Nodes

rabbit@rabbitmq1
rabbit@rabbitmq2
rabbit@rabbitmq3

Versions

rabbit@rabbitmq1: RabbitMQ 3.10.7 on Erlang 25.0.4
rabbit@rabbitmq2: RabbitMQ 3.10.7 on Erlang 25.0.4
rabbit@rabbitmq3: RabbitMQ 3.10.7 on Erlang 25.0.4

Maintenance status

Node: rabbit@rabbitmq1, status: not under maintenance
Node: rabbit@rabbitmq2, status: not under maintenance
Node: rabbit@rabbitmq3, status: not under maintenance

Alarms

(none)

Network Partitions

(none)

Listeners

Node: rabbit@rabbitmq1, interface: [::], port: 15672, protocol: http, purpose: HTTP API
Node: rabbit@rabbitmq1, interface: [::], port: 61613, protocol: stomp, purpose: STOMP
Node: rabbit@rabbitmq1, interface: [::], port: 1883, protocol: mqtt, purpose: MQTT
Node: rabbit@rabbitmq1, interface: [::], port: 15692, protocol: http/prometheus, purpose: Prometheus exporter API over HTTP
Node: rabbit@rabbitmq1, interface: [::], port: 25672, protocol: clustering, purpose: inter-node and CLI tool communication
Node: rabbit@rabbitmq1, interface: [::], port: 5672, protocol: amqp, purpose: AMQP 0-9-1 and AMQP 1.0
Node: rabbit@rabbitmq2, interface: [::], port: 15672, protocol: http, purpose: HTTP API
Node: rabbit@rabbitmq2, interface: [::], port: 61613, protocol: stomp, purpose: STOMP
Node: rabbit@rabbitmq2, interface: [::], port: 1883, protocol: mqtt, purpose: MQTT
Node: rabbit@rabbitmq2, interface: [::], port: 15692, protocol: http/prometheus, purpose: Prometheus exporter API over HTTP
Node: rabbit@rabbitmq2, interface: [::], port: 25672, protocol: clustering, purpose: inter-node and CLI tool communication
Node: rabbit@rabbitmq2, interface: [::], port: 5672, protocol: amqp, purpose: AMQP 0-9-1 and AMQP 1.0
Node: rabbit@rabbitmq3, interface: [::], port: 15672, protocol: http, purpose: HTTP API
Node: rabbit@rabbitmq3, interface: [::], port: 61613, protocol: stomp, purpose: STOMP
Node: rabbit@rabbitmq3, interface: [::], port: 1883, protocol: mqtt, purpose: MQTT
Node: rabbit@rabbitmq3, interface: [::], port: 15692, protocol: http/prometheus, purpose: Prometheus exporter API over HTTP
Node: rabbit@rabbitmq3, interface: [::], port: 25672, protocol: clustering, purpose: inter-node and CLI tool communication
Node: rabbit@rabbitmq3, interface: [::], port: 5672, protocol: amqp, purpose: AMQP 0-9-1 and AMQP 1.0

Feature flags

Flag: classic_mirrored_queue_version, state: enabled
Flag: drop_unroutable_metric, state: enabled
Flag: empty_basic_get_metric, state: enabled
Flag: implicit_default_bindings, state: enabled
Flag: maintenance_mode_status, state: enabled
Flag: quorum_queue, state: enabled
Flag: stream_queue, state: enabled
Flag: user_limits, state: enabled
Flag: virtual_host_metadata, state: enabled

```


