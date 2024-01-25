docker image build -t harbor.registry.local/kagajpatra/web:$BUILD_NUMBER -f Dockerfile-web .

docker image build -t harbor.registry.local/kagajpatra/nginx:$BUILD_NUMBER -f Dockerfile-nginx .

docker image tag mysql:latest harbor.registry.local/kagajpatra/mysql:$BUILD_NUMBER

docker image push harbor.registry.local/kagajpatra/web:$BUILD_NUMBER || true

docker image push harbor.registry.local/kagajpatra/nginx:$BUILD_NUMBER || true
