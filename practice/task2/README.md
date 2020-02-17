1. Сервер master.puppet.vm (Debian Buster)
	1. Установить nginx с использованием модуля puppet/nginx
	1. Настроить nginx в режим Load Balancer
    (nginx::resource::upstream, nginx::resource::server)
	1. Выбор upstream сервера должен производиться случайным образом (random = 'two')
2. Сервера slave1.puppet.vm (Debian), slave2.puppet.vm (CentOS 7)
	1. Установить apache + php с помощью самописного класса (не используя модули)
	1. Создать файл index.php с содержимым:
    ```php
     <?php phpinfo(); ?>
    ```
	1. Владельцем файла должен быть пользователь, от имени которого запускается демон httpd
