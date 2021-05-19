PYTHON   ?= 3.8
POSTGRES := 11.12
PSYCOPG2 := 2_8_6

DIST = psycopg2-$(PSYCOPG2)-python-$(subst .,_,$(PYTHON)).zip

all: clean build $(DIST)

build:
	docker run --rm -w /data -v $(CURDIR):/data \
		amazon/aws-sam-cli-build-image-python$(PYTHON) \
		/bin/sh build.sh $(POSTGRES) $(PSYCOPG2)

$(DIST):
	zip -r $@ python

clean:
	-$(RM) -r python

distclean:
	-$(RM) *.zip

.PHONY: all clean distclean
