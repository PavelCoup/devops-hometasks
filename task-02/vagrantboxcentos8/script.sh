#!/bin/bash

dnf install -y mc
dnf install -y httpd
dnf install -y php
dnf install -y mysql-server

systemctl enable httpd
systemctl start httpd
systemctl enable httpd
systemctl start mysqld


systemctl status httpd
systemctl status mysqld
