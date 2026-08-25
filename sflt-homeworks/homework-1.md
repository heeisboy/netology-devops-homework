# Домашнее задание к занятию 1 «Disaster recovery и Keepalived»
---
## Задание 1

    Дана схема для Cisco Packet Tracer, рассматриваемая в лекции.
    На данной схеме уже настроено отслеживание интерфейсов маршрутизаторов Gi0/1 (для нулевой группы)
    Необходимо аналогично настроить отслеживание состояния интерфейсов Gi0/0 (для первой группы).
    Для проверки корректности настройки, разорвите один из кабелей между одним из маршрутизаторов и Switch0 и запустите ping между PC0 и Server0.
    Отправьте получившуюся схему в формате pkt и скриншот, где виден процесс настройки маршрутизатора.

---

## Решение

**Настройки CLI**<img width="987" height="793" alt="image" src="https://github.com/user-attachments/assets/eeb7c728-825d-4337-a8be-b98abe81a6e8" />
**show standby brief**<img width="692" height="197" alt="image" src="https://github.com/user-attachments/assets/77d6bac2-9791-46c3-9713-417a0d9b7b98" />
**ping во время обрыва**<img width="1035" height="395" alt="image" src="https://github.com/user-attachments/assets/1b5ae18f-5c73-4b53-add8-748a4b13394c" />

[>>>Схема<<<](https://github.com/heeisboy/netology-devops-homework/blob/main/sflt-homeworks/hsrp_homework.pkt)
