# syntax=docker/dockerfile:1.4
ARG PYTHON_VERSION
ARG ARCHITECTURE

FROM public.ecr.aws/lambda/python:${PYTHON_VERSION}-${ARCHITECTURE}

ARG PSYCOPG2_VERSION

ENV PIP_ROOT_USER_ACTION ignore
ENV PYTHONPATH /python

WORKDIR /data

COPY --link test.py ${LAMBDA_TASK_ROOT}

RUN <<EOT sh -ex
      if type dnf >/dev/null 2>&1; then dnf update; dnf install -y zip unzip; \
    elif type yum >/dev/null 2>&1; then yum update; yum install -y zip unzip; \
    else echo 'Unsupported package manager' 1>&2; exit 1; fi

    pip install --upgrade pip
    pip install psycopg2-binary==${PSYCOPG2_VERSION} -t /python

    # testing
    python -c 'import psycopg2; print(psycopg2.__version__)'

    exit 0
EOT

ENTRYPOINT [""]
