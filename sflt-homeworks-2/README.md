# Домашнее задание к занятию 2 «Кластеризация и балансировка нагрузки»
---
## Задание 1

    Запустите два simple python сервера на своей виртуальной машине на разных портах
    Установите и настройте HAProxy, воспользуйтесь материалами к лекции по ссылке
    Настройте балансировку Round-robin на 4 уровне.
    На проверку направьте конфигурационный файл haproxy, скриншоты, где видно перенаправление запросов на разные серверы при обращении к HAProxy.

---

## Решение

1. Запускаем 2 simple python сервера на вм на портах 8888 и 9999
<img width="646" height="70" alt="image" src="https://github.com/user-attachments/assets/6ac7e4dc-6cca-462c-b250-8ca849fd85f6" />
<img width="582" height="72" alt="image" src="https://github.com/user-attachments/assets/61d7329a-ae6a-4e8b-b9ac-32e081d54b94" />

2. Устанавливаем Haproxy командой sudo apt-get install haproxy
3. Настраиваем балансировку Round-robin на 4 уровне
<img width="584" height="284" alt="image" src="https://github.com/user-attachments/assets/8eb85a0d-062b-484e-ac53-57d3459e4714" />

<img width="1664" height="146" alt="image" src="https://github.com/user-attachments/assets/6d32917e-19f6-41b5-a26c-a04ac62d9c56" />


*Как мы видим, при обращении к серверу, haproxy балансирует между двумя разными адресами*


[Конфиг haproxy](https://github.com/heeisboy/netology-devops-homework/blob/main/sflt-homeworks-2/haproxy-1.conf)

---

## Задание 2

    Запустите три simple python сервера на своей виртуальной машине на разных портах
    Настройте балансировку Weighted Round Robin на 7 уровне, чтобы первый сервер имел вес 2, второй - 3, а третий - 4
    HAproxy должен балансировать только тот http-трафик, который адресован домену example.local
    На проверку направьте конфигурационный файл haproxy, скриншоты, где видно перенаправление запросов на разные серверы при обращении к HAProxy c использованием домена example.local и без него.

---

## Решение

1. Запускаем 3 simple python сервера на vm
 <img width="628" height="77" alt="image" src="https://github.com/user-attachments/assets/e2470c22-ff62-47a5-8800-8affafbc656a" />
 <img width="628" height="77" alt="image" src="https://github.com/user-attachments/assets/d82fa19a-f5de-4601-be52-9ad046d3a1f8" />
 <img width="564" height="71" alt="image" src="https://github.com/user-attachments/assets/9937a13c-7855-4ac1-9492-263125c0ba0a" />

2. Настраиваем балансировку Weighted Round Robin на 7 уровне, чтобы первый сервер имел вес 2, второй - 3, а третий - 4

<img width="444" height="177" alt="image" src="https://github.com/user-attachments/assets/320c3d17-6728-404e-9a78-e131834b60f6" />
<img width="511" height="379" alt="image" src="https://github.com/user-attachments/assets/3617e0b2-4474-4b56-9bb0-054d371bcfb7" />

3. Проверка

<img width="727" height="417" alt="image" src="https://github.com/user-attachments/assets/4a14f991-3962-4c84-baa5-b3056aba67f7" />

<img width="1848" height="473" alt="image" src="https://github.com/user-attachments/assets/1835a856-8b1b-42d6-9f3c-5c037c9688e7" />


[Конфиг haproxy](https://github.com/heeisboy/netology-devops-homework/blob/main/sflt-homeworks-2/haproxy-2.conf)

---



