FROM python:slim-bullseye AS builder

WORKDIR /app
COPY poetry.lock pyproject.toml main.py .env gunicorn.sh ./

RUN python -m pip install --no-cache-dir poetry==1.5.1 \
    && poetry config virtualenvs.in-project true \
    && poetry install --no-interaction --no-ansi || true \
    && poetry shell || true

FROM alpine:latest AS base

RUN  apk update \
    && apk upgrade \
    && apk add ca-certificates \
    && update-ca-certificates \
    && echo http://dl-cdn.alpinelinux.org/alpine/v3.6/main >> /etc/apk/repositories \
    && echo http://dl-cdn.alpinelinux.org/alpine/v3.6/community >> /etc/apk/repositories \
    && apk add --update coreutils && rm -rf /var/cache/apk/*   \ 
    && apk add --update python3 py3-pip \
    && apk add --no-cache nss \
    && rm -rf /var/cache/apk/*


FROM base

WORKDIR /web

ENV ENVIRONMENT=dev
ENV ENVIRONMENT_FROM_SECRET=secret_dev

RUN python -m pip install --no-cache-dir fastapi gunicorn uvicorn

COPY --from=builder /app ./
COPY app ./app

CMD ["./gunicorn.sh"]