echo "Stopping previously built container"
docker container stop kagajpatra_web || true
docker container stop kagajpatra_nginx || true
docker container stop kagajpatra_mysql || true

echo "Removing previously built container"
docker container rm kagajpatra_web || true 
docker container rm kagajpatra_nginx || true
docker container rm kagajpatra_mysql || true

echo "Creating new container"
docker run -itd --name kagajpatra-web -p 5000:5000 harbor.registry.local/kagajpatra/web:$BUILD_NUMBER

docker run -itd --name kagajpatra-mysql -p 3306:3306 harbor.registry.local/kagajpatra/mysql:$BUILD_NUMBER

docker run -itd --name kagajpatra-nginx -p 8200:80 -v ./nginx/nginx.conf:/etc/nginx/nginx.conf -v ./app/static:/kagajpatra/app/static ./app/uploads:/kagajpatra/app/uploads harbor.registry.local/kagajpatra/nginx:$BUILD_NUMBER
