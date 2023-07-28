FROM python:slim-bullseye AS base

WORKDIR /app
COPY poetry.lock pyproject.toml main.py .env ./

RUN python -m pip install --no-cache-dir poetry==1.5.1 \
    && poetry config virtualenvs.in-project true \
    && poetry install --no-interaction --no-ansi || true \
    && poetry shell || true

FROM python:slim-bullseye

WORKDIR /web

RUN python -m pip install --no-cache-dir fastapi gunicorn uvicorn

COPY --from=base /app ./
COPY app ./app

#ENTRYPOINT ['gunicorn', 'main:app', '--worker-class', 'uvicorn.workers.UvicornWorker', '--workers=1', '--bind="0.0.0.0:8000"', '--timeout=180']
ENTRYPOINT ["tail", "-f", "/dev/null"]