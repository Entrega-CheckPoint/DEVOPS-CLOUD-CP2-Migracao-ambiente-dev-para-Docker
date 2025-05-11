echo "Iniciando a containização..."
echo ""
cd deploy

echo "Criando a rede virtual 'rm557313-net'"
docker network create rm557313-net

docker network ls

echo ""
echo "Criando banco de dados MySQL 'mysql-rm557313'"

docker run -d \
  --name mysql-rm557313 \
  --network rm557313-net \
  -e MYSQL_ROOT_PASSWORD=senha123 \
  -e MYSQL_DATABASE=mottuDB \
  -e MYSQL_USER=mottuser \
  -e MYSQL_PASSWORD=mottupass \
  -v mottu-vol:/var/lib/mysql \
  -p 3306:3306 \
  mysql:8.0

sleep 20

echo ""
echo "Criando as tabelas do banco de dados"

docker exec -i mysql-rm557313 mysql -umottuser -pmottupass mottuDB < create_table.sql

echo ""
echo "Criando as interface grafica para interagir com banco"

docker run -d --name adminer-rm557313 --network rm557313-net -p 8081:8080 adminer

echo ""
echo "Build da aplicação ASP.NET"

docker build -t mottu-api .

echo ""
echo "Criando container da aplicação ASP.NET"

docker run -d --name mottu-api-rm557313 --network rm557313-net -p 8080:8080 mottu-api

echo ""
echo "============================================================================"
echo ""

echo ""
echo "Lista de imagens no Docker"
docker image ls

echo ""
echo "Lista de conteiners ativos"
docker ps