# Домашнее задание к занятию "`Ansible. Часть 2`" - `Хромов Р.Д`


### Инструкция по выполнению домашнего задания

   1. Сделайте `fork` данного репозитория к себе в Github и переименуйте его по названию или номеру занятия, например, https://github.com/имя-вашего-репозитория/git-hw или  https://github.com/имя-вашего-репозитория/7-1-ansible-hw).
   2. Выполните клонирование данного репозитория к себе на ПК с помощью команды `git clone`.
   3. Выполните домашнее задание и заполните у себя локально этот файл README.md:
      - впишите вверху название занятия и вашу фамилию и имя
      - в каждом задании добавьте решение в требуемом виде (текст/код/скриншоты/ссылка)
      - для корректного добавления скриншотов воспользуйтесь [инструкцией "Как вставить скриншот в шаблон с решением](https://github.com/netology-code/sys-pattern-homework/blob/main/screen-instruction.md)
      - при оформлении используйте возможности языка разметки md (коротко об этом можно посмотреть в [инструкции  по MarkDown](https://github.com/netology-code/sys-pattern-homework/blob/main/md-instruction.md))
   4. После завершения работы над домашним заданием сделайте коммит (`git commit -m "comment"`) и отправьте его на Github (`git push origin`);
   5. В личном кабинете прикрепите и отправьте ссылку на решение в виде md-файла в вашем Github.
   6. Любые вопросы по выполнению заданий спрашивайте в разделе “Вопросы по заданию” в личном кабинете.

Желаем успехов в выполнении домашнего задания!

### Дополнительные материалы, которые могут быть полезны для выполнения задания

1. [Руководство по оформлению Markdown файлов](https://gist.github.com/Jekins/2bf2d0638163f1294637#Code)

---

### Задание 1

Выполните действия, приложите файлы с плейбуками и вывод выполнения.

Напишите три плейбука. При написании рекомендуем использовать текстовый редактор с подсветкой синтаксиса YAML.
Плейбуки должны:

**1. Скачать какой-либо архив, создать папку для распаковки и распаковать скаченный архив. Например, можете использовать официальный сайт и зеркало Apache Kafka. При этом можно скачать как исходный код, так и бинарные файлы, запакованные в архив — в нашем задании не принципиально.**

**2. Установить пакет tuned из стандартного репозитория вашей ОС. Запустить его, как демон — конфигурационный файл systemd появится автоматически при установке. Добавить tuned в автозагрузку.**

**3. Изменить приветствие системы (motd) при входе на любое другое. Пожалуйста, в этом задании используйте переменную для задания приветствия. Переменную можно задавать любым удобным способом.**

**Решение:**

1. Плейбук скачивает архив, создает папку и распаковывает его в созданную папку. Запускаем комадой  `ansible-playbook -i  inventory.ini playbook-archive.yml --vault-password-file .env`
<img width="1221" height="701" alt="изображение" src="https://github.com/user-attachments/assets/16690d0e-daeb-4cb0-bbbe-e5e3f9adf1e4" />

**Код плейбука:** <a href="https://github.com/heeisboy/netology-devops-homework/blob/main/ansible-hw-2/playbook-archive.yml">playbook-archive.yml</a>

2. Плейбук устанавливает пакет tuned, запускает его как демон и добавляет в автозагрузку. Запускаем командой `ansible-playbook -i inventory.ini  playbook-archive.yml --vault-password-file .env`
<img width="1252" height="599" alt="изображение" src="https://github.com/user-attachments/assets/08544953-d67d-4bf7-8673-110918990a69" />

**Код плейбука:** <a href="https://github.com/heeisboy/netology-devops-homework/blob/main/ansible-hw-2/playbook-tuned-demon.yml">playbook-tuned-demon.yml</a>

3. Плейбук изменяет приветствие системы (motd) при входе на:
```
"Hello, netology! Have a nice session!
Current time: <time>
Date: <date>"
```
Запускаем командой `ansible-playbook -i inventory.ini playbook-edit-motd.yml --vault-password-file .env`

<img width="1247" height="778" alt="изображение" src="https://github.com/user-attachments/assets/d882605e-1e4b-4d70-ab51-8edb6ab75d68" />

**Код плейбука:** <a href="https://github.com/heeisboy/netology-devops-homework/blob/main/ansible-hw-2/playbook-edit-motd.yml">playbook-edit-motd.yml</a>


---

### Задание 2

**Выполните действия, приложите файлы с модифицированным плейбуком и вывод выполнения.**

Модифицируйте плейбук из пункта 3, задания 1. В качестве приветствия он должен установить IP-адрес и hostname управляемого хоста, пожелание хорошего дня системному администратору.

**Решение:**

Плейбук изменяет приветствие системы (motd) при входе на:
```
"Hello, netology! Have a nice day!
Current time: <time>
Date: <date>
Hostname: <hostname>
IP Address: <ip-address>"
```
Запускаем командой `ansible-playbook -i inventory.ini playbook-modify-motd.yml --vault-password-file.yml .env`

<img width="1329" height="770" alt="изображение" src="https://github.com/user-attachments/assets/df937698-aba8-44c7-b945-78e07bbebcca" />

**Код плейбука:** <a href="https://github.com/heeisboy/netology-devops-homework/blob/main/ansible-hw-2/playbook-modify-motd.yml">playbook-modify-motd.yml</a>

---

### Задание 3

**Выполните действия, приложите архив с ролью и вывод выполнения.**

Ознакомьтесь со статьёй «Ansible - это вам не bash», сделайте соответствующие выводы и не используйте модули shell или command при выполнении задания.

Создайте плейбук, который будет включать в себя одну, созданную вами роль. Роль должна:

    Установить веб-сервер Apache на управляемые хосты.
    Сконфигурировать файл index.html c выводом характеристик каждого компьютера как веб-страницу по умолчанию для Apache. Необходимо включить CPU, RAM, величину первого HDD, IP-адрес. Используйте Ansible facts и jinja2-template. Необходимо реализовать handler: перезапуск Apache только в случае изменения файла конфигурации Apache.
    Открыть порт 80, если необходимо, запустить сервер и добавить его в автозагрузку.
    Сделать проверку доступности веб-сайта (ответ 200, модуль uri).

**Решение:**

<ul>
  <li>Роль устанавливает веб-сервер apache, открывает 80 порт (если необходимо), запускает сервер и добавляет его в автозагрузку.</li>
  <li>Конфигурирует файл index.html с указанием характеристик управляемых узлов.</li>
  <li>Выводит информацию: CPU, RAM, величину первого HDD, IP-адрес.</li>
  <li>Перезапуск Apache только в случае изменения файла конфигурации apache.</li>
   <li>Производится проверка доступности веб-сайта с выводом ответа.</li>
</ul>

Запускаем командой `ansible-playbook -i inventory.ini playbook-apache.yml --vault-password-file .env`

<img width="1346" height="676" alt="изображение" src="https://github.com/user-attachments/assets/5640ca66-15ba-4f8a-b1ca-679a660c5796" />
<img width="1348" height="779" alt="изображение" src="https://github.com/user-attachments/assets/2f6c600f-6173-466f-82c4-490c6653114c" />

**Код плейбука:** <a href="https://github.com/heeisboy/netology-devops-homework/blob/main/ansible-hw-2/playbook-apache.yml">playbook-apache.yml</a>

**Код роли:** <a href="https://github.com/heeisboy/netology-devops-homework/tree/main/ansible-hw-2/apache_status_role">apache_status_role</a>

*Пример отображения веб-сайта*
<img width="787" height="312" alt="изображение" src="https://github.com/user-attachments/assets/de2fd5fe-0639-42c2-9546-92b19f65a522" />




