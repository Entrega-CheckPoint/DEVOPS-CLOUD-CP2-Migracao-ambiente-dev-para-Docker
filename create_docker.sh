#!/bin/bash

echo ""
echo "============================================================"
echo "   INICIANDO A CONTAINERIZAÇÃO DO PROJETO MOTTU "
echo "============================================================"
echo ""

cd deploy

CAMINHO=$(pwd)

echo ""
echo "🔵 Criando a rede virtual 'rm557313-net'"
docker network create rm557313-net
docker network ls

echo ""
echo "============================================================"
echo " 🛢️  Criando container do banco de dados MySQL 'mysql-rm557313'"
echo "============================================================"
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

echo ""
echo "⏳ Aguardando banco de dados iniciar..."
sleep 20

echo ""
echo "📄 Criando tabelas no banco de dados"
docker exec -i mysql-rm557313 mysql -umottuser -pmottupass mottuDB <create_table.sql

echo ""
echo "============================================================"
echo " 🖥️  Criando container da interface gráfica Adminer 'adminer-rm557313'"
echo "============================================================"
docker run -d --name adminer-rm557313 --network rm557313-net -p 8081:8080 adminer

echo ""
echo "============================================================"
echo " 📦 Criando container da aplicação ASP.NET 'mottu-api-rm557313'"
echo "============================================================"
docker run -d \
  --name mottu-api-rm557313 \
  --network rm557313-net \
  -p 8080:80 \
  -v $CAMINHO:/app \
  -w /app \
  mcr.microsoft.com/dotnet/aspnet:8.0 \
  dotnet mottu.dll

echo ""
echo "============================================================"
echo " ✅ TUDO PRONTO! SISTEMA CONTAINERIZADO COM SUCESSO ✅"
echo "============================================================"
echo ""

echo ""
echo "============================================================"
echo "Lista volumes no Docker: 'docker volume ls'"
echo "============================================================"
docker volume ls

echo ""
echo "============================================================"
echo "Lista de imagens no Docker: 'docker image ls'"
docker image ls
echo "============================================================"

echo ""
echo "============================================================"
echo "📦 Lista de containers ativos: 'docker ps'"
docker ps
echo "============================================================"
