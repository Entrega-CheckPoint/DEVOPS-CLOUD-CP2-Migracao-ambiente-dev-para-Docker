cd deploy

docker network create rm557313-net

docker build -t mottu-api .

docker run -d --name mysql-rm557313 --network rm557313-net -e MYSQL_ROOT_PASSWORD=senha123 -e MYSQL_DATABASE=mottuDB -p 3306:3306 mysql:8.0

docker run -d --name adminer-rm557313 --network rm557313-net -p 8081:8080 adminer

docker run -d --name mottu-api-rm557313 --network rm557313-net -p 8080:80 mottu-api
