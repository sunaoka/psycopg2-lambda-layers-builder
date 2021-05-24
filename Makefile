PYTHON   ?= 3.8
POSTGRES := 11.12
PSYCOPG2 := 2_8_6

all: clean build

build:
	docker run --rm -w /data -v $(CURDIR):/data \
		amazon/aws-sam-cli-build-image-python$(PYTHON) \
		/bin/sh build.sh $(POSTGRES) $(PSYCOPG2) $(PYTHON)

clean:
	-$(RM) *.zip

.PHONY: all build clean
