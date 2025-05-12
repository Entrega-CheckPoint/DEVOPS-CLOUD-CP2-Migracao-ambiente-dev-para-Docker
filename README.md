# $DEVOPS-CLOUD-CP2-Migracao-ambiente-dev-para-Docker$

## __Objetivo__

Migrar o ambiente DEV da DimDim para container rodando a aplicação em uma VM.

## __Metodologia__

1. Criar a network para comunicação interna dos containers.
2. Criar container com banco de dados MySQL.
3. Criar o container da interface gráfica usando _Adminer_
4. Criar a imagem personalizada da nossa aplicação ASP.NET.
5. Criar o container da nossa aplicação ASP.NET.
   > Usar docker com imagens oficiais do Dockerhub para iniciar a aplicação.

## __Implementação da solução__

Para realizar o processo de migração foi realizado um script shell que realiza todas as funções de forma única.

- O uso do script shell permite reprodutibilidade e escalabilidade do ambiente.

### 1. Clone do repositório

A aplicação foi criada localmente e salva no repositório do git, onde sera necessário clona-lo.

```bash
# Clonar o repositório
git clone https://github.com/Entrega-CheckPoint/DEVOPS-CLOUD-CP2-Migracao-ambiente-dev-para-Docker
```

```bash
# Entrar no diretório
cd DEVOPS-CLOUD-CP2-Migracao-ambiente-dev-para-Docker
```

### 2. Conceder a permissão e executar o script

Sem a permissão de escrita o arquivo .sh será apenas um arquivo, sendo assim deve-se liberar sua execução.

```bash
chmod 744 create_docker.sh
```

```bash
# Executar o script
./create_docker.sh
```

## __Código Fonte__

#### Script usado -> [create_docker](./create_docker.sh)

1. entrar no diretório que possui o Dockerfile

```sh
cd deploy
```

2. Criar e listar a redes locais

```sh
docker network create rm557313-net
docker network ls
```

3. Criar o container com servidor MySQL para criar o banco de dados

```sh

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

```

4. Criar as tabelas no banco de dados

```sh
docker exec -i mysql-rm557313 mysql -umottuser -pmottupass mottuDB < create_table.sql

```

5. Criar o container da interface gráfica usando _Adminer_

```sh
docker run -d --name adminer-rm557313 --network rm557313-net -p 8081:8080 adminer
```

6. Criar a imagem personalizada da nossa aplicação ASP.NET.

```sh
docker build -t mottu-api .
```

7. Criar o container da nossa aplicação ASP.NET.

```sh
docker run -d --name mottu-api-rm557313 --network rm557313-net -p 8080:8080 mottu-api
```

8. Listar os Volumes criados

- Usado para persistência de dados no banco.

```sh
docker volume ls
```

9. Listar as imagens presentes no docker

```sh
docker image ls
```

10. Listar os container em execução

```sh
docker ps
```

## Resultado Obtidos

Temos como resultado um MVP da aplicação ASP.NET em **container** em uma **maquina virtual**.

## Observações durante desenvolvimento

1. Abrir as portas necessárias:
   - 3306 para uso do banco de dados MySQL
   - 8080 para acesso a aplicação ASP.NET
   - 8081 para Login no Adminer
2. O Docker já estava instalado na VM.
3. Para acesso ao Adminer na porta 8081 não usar o usuario root:
   - SERVIDOR: mysql-rm557313
   - USER: mottuser
   - PASSWORD: mottupass
