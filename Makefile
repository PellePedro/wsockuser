NAME = weaveworksdemos/user
DBNAME = weaveworksdemos/user-db
INSTANCE = user
TESTDB = weaveworkstestuserdb
OPENAPI = $(INSTANCE)-testopenapi
GROUP = weaveworksdemos
TAG = latest

default: docker


test:
	@docker build -t $(INSTANCE)-test -f ./Dockerfile-test .
	@docker run --rm -it $(INSTANCE)-test /bin/sh -c 'glide novendor| xargs go test -v'

.PHONY: docker
docker:
	docker buildx use mybuilder
	docker buildx build --tag $(NAME):$(TAG) -f docker/user/Dockerfile-release . -o type=image --platform=linux/arm64,linux/amd64 
	docker buildx build --tag $(DBNAME):$(TAG) -f docker/user-db/Dockerfile docker/user-db -o type=image --platform=linux/arm64,linux/amd64

