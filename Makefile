NAME = pellepedro/weavesocks_user
DBNAME = pellepedro/weavesocks_user_db
TAG = latest

default: build-image


.PHONY: build-image
build-image:
	docker buildx use mybuilder
	docker buildx build --tag $(NAME):$(TAG) -f docker/user/Dockerfile-release . -o type=image --platform=linux/arm64,linux/amd64 
	docker buildx build --tag $(DBNAME):$(TAG) -f docker/user-db/Dockerfile docker/user-db -o type=image --platform=linux/arm64,linux/amd64

.PHONY: build-push
build-push:
	docker  buildx create --name mybuilder
	docker buildx use mybuilder
	docker buildx build --push --tag $(NAME):$(TAG) -f docker/user/Dockerfile-release . -o type=image --platform=linux/arm64,linux/amd64 
	docker buildx build --push --tag $(DBNAME):$(TAG) -f docker/user-db/Dockerfile docker/user-db -o type=image --platform=linux/arm64,linux/amd64
