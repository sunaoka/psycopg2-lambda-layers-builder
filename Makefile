PYTHON ?= 3.12
PSYCOPG2 ?= 2.9.9

# x86_64 or arm64
ARCH ?= x86_64

NAME := psycopg2-$(PSYCOPG2)-python$(PYTHON)-$(ARCH)
IMAGE := $(NAME)-builder:latest
ZIP := $(NAME).zip

all: clean build

build:
	docker build \
		--build-arg PYTHON_VERSION=$(PYTHON) \
		--build-arg PSYCOPG2_VERSION=$(PSYCOPG2) \
		--build-arg ARCHITECTURE=$(ARCH) \
		--tag $(IMAGE) .

	docker run --rm -v $(CURDIR):/data $(IMAGE) \
		zip -rT $(ZIP) /python

	docker rmi $(IMAGE)

	@echo
	@echo 'Run the following command to publish the lambda layer:'
	@echo
	@echo 'aws lambda publish-layer-version \'
	@echo '    --layer-name $(subst .,_,$(NAME)) \'
	@echo '    --zip-file fileb://$(ZIP) \'
	@echo '    --compatible-runtimes python$(PYTHON)'

clean:
	-$(RM) $(ZIP)

.PHONY: all build clean
