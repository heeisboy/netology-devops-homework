# Домашнее задание к занятию «ELK»

## Задание 1. Elasticsearch

Установите и запустите Elasticsearch, после чего поменяйте параметр cluster_name на случайный.

Приведите скриншот команды 'curl -X GET 'localhost:9200/_cluster/health?pretty', сделанной на сервере с установленным Elasticsearch. Где будет виден нестандартный cluster_name.

## Решение 
<img width="899" height="396" alt="изображение" src="https://github.com/user-attachments/assets/05ceccf5-1ab0-44ee-b686-2b5a5b5e77e3" />

---

## Задание 2. Kibana

Установите и запустите Kibana.

Приведите скриншот интерфейса Kibana на странице http://<ip вашего сервера>:5601/app/dev_tools#/console, где будет выполнен запрос GET /_cluster/health?pretty.

## Решение 
<img width="1850" height="546" alt="изображение" src="https://github.com/user-attachments/assets/858be78d-c3de-41b0-8076-8e78f25effd1" />

---

## Задание 3. Logstash

Установите и запустите Logstash и Nginx. С помощью Logstash отправьте access-лог Nginx в Elasticsearch.

Приведите скриншот интерфейса Kibana, на котором видны логи Nginx.

## Решение 
<img width="1901" height="937" alt="изображение" src="https://github.com/user-attachments/assets/b05fcccc-ca1b-41f2-9fd5-013c8e3fcc39" />


---

## Задание 4. Filebeat.

Установите и запустите Filebeat. Переключите поставку логов Nginx с Logstash на Filebeat.

Приведите скриншот интерфейса Kibana, на котором видны логи Nginx, которые были отправлены через Filebeat.

## Решение
<img width="1901" height="937" alt="изображение" src="https://github.com/user-attachments/assets/3fb47206-a795-410e-8d5a-95ea9770944d" />



