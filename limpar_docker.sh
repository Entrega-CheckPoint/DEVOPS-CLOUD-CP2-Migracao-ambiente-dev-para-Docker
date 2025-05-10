docker stop dimdim-mysql dimdim-phpmyadmin dimdim-php-app
docker rm dimdim-mysql dimdim-phpmyadmin dimdim-php-app
docker network rm dimdim-network
docker system prune -a -f --volumes