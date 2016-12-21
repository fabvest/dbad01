#!/bin/bash

# создаем тестовую БД 
sudo su -c "/usr/local/pgsql/bin/createdb shoppingquest" postgres
sudo su -c "/usr/local/pgsql/bin/psql -d shoppingquest -a -f /vagrant_sql_data/shoppingquest.sql" postgres
