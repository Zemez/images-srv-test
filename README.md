# images-srv-test
Image tools microservice:

## Настройки:

```
# .env
DATABASE_HOSTNAME=localhost	# db hostname (optional)
DATABASE_PORT=5432			# db port (optional)
DATABASE_USERNAME=username	# db username (optional if connect through socket/peer)
DATABASE_PASSWORD=secret123 # db password (optional if connect through socket/peer)
DATABASE_NAME=dbname 		# db name

PUBLIC_DIR=/var/www/public 	# общедоступная папка для хранения картинок
```
```
# config/app.rb
set :resources, [ 'models', 'vehicles' ] # ресурсы для которых будут храниться картинки
```
```
# config/puma.rb
DAEMON=yes	# running as daemon
PORT=3333	# tcp/ip port binding
```
## Загрузка картинок (role: admin):

POST запросом отправляем форму с action:
```
http://<hostname>/images/<resource>/<id>/upload
```
Так же есть простенькая форма через GET запрос

## Вывести список всех картинок на сервере (role: admin):

GET запрос:
```
http://<hostname>/images
```
Выведет список всех картинок на сервере в JSON формате.
