NAME = zkui
VERSION=2.0-SNAPSHOT
DOCKERUSER=tjmaster

.PHONY: all build publish

all: build publish

build:
	mvn clean install
	cp config.cfg docker
	cp target/$(NAME)-*.jar docker
	docker build -t $(DOCKERUSER)/$(NAME):$(VERSION) --no-cache --rm docker
	rm docker/$(NAME)-*.jar
	rm docker/config.cfg

publish:
	docker tag $(DOCKERUSER)/$(NAME):$(VERSION) $(NAME):$(VERSION)
	docker tag $(DOCKERUSER)/$(NAME):$(VERSION) $(NAME):latest
	docker push $(DOCKERUSER)/$(NAME):$(VERSION)
