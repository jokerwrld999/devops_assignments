#!/bin/sh

gunicorn main:app \
  --worker-class uvicorn.workers.UvicornWorker \
  --workers=1 \
  --bind="0.0.0.0:8000" \
  --timeout=180
