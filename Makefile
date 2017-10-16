IMAGE:=nudj/how-to-hire
IMAGEDEV:=nudj/how-to-hire-dev

CWD=$(shell pwd)
BIN:=./node_modules/.bin

.PHONY: build buildLocal run dev

build:
	@docker build \
		-t $(IMAGEDEV) \
		-f $(CWD)/Dockerfile \
		.

buildLocal:
	@docker build \
		-t $(IMAGE):local \
		.

run:
	-@docker rm -f how-to-hire-container 2> /dev/null || true
	@echo 'App=http://localhost:9998/'
	@docker run --rm -it \
		--name how-to-hire-container \
		-p 0.0.0.0:9998:80 \
		$(IMAGE):local

dev:
	-@docker rm -f how-to-hire-container 2> /dev/null || true
	@echo 'App=http://localhost:9999/'
	@docker run --rm -it \
		--name how-to-hire-container \
		-v $(CWD)/src/lib:/usr/src/lib \
		-p 0.0.0.0:9999:80 \
		$(IMAGEDEV) \
		/bin/sh -c '$(BIN)/nodemon \
			-e js,html,css \
			--quiet \
			--watch ./ \
			--delay 250ms \
			-x "node ."'
