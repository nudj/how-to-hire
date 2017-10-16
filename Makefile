IMAGE:=nudj/how-to-hire

CWD=$(shell pwd)
BIN:=./node_modules/.bin

.PHONY: build run

build:
	@docker build \
		-t $(IMAGE) \
		-f $(CWD)/Dockerfile \
		.

run:
	-@docker rm -f how-to-hire-container 2> /dev/null || true
	@echo 'App=http://localhost:9998/'
	@docker run --rm -it \
		--name how-to-hire-container \
		-p 0.0.0.0:9998:80 \
		$(IMAGE):local
