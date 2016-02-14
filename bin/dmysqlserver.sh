docker run --name mysql-server -v $(pwd)/startup:/docker-entrypoint-initdb.d -v $(pwd)/data:/var/lib/mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=mysqlpass -d mysql:latest


