# Docker image for liferay 6.2 
# Liferay-portal-6.2-ce-ga3
Source: https://github.com/snasello/docker-liferay-6.2

Default database is MySQL.

## Build image

```
sudo docker build .
```
## Start DataBase
```
docker run --name lep-mysql -e MYSQL_ROOT_PASSWORD=mysecretpassword -e MYSQL_USER=lportal -e MYSQL_PASSWORD=lportal -e MYSQL_DATABASE=lportal -d mysql:5.6
```

## Run & Link LifeRay with DB
```
docker run -d -it -p 8080:8080 --link lep-mysql:db_lep -e DB_TYPE=MYSQL <name_of_builded_image/repository_or_tag>
```
