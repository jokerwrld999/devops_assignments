# -*- coding: utf-8 -*-
from fastapi import FastAPI
from app import config
from app.routers import api_router
import socket

#app = FastAPI(title="config.ENVIRONMENT_FROM_SECRET")
app = FastAPI(title=config.ENVIRONMENT_FROM_SECRET)


@app.get("/")
async def root():
    message = f"Hello World {config.ENVIRONMENT}!"
    host = f"Hello World! Served from {socket.gethostname()}"
    return {"message": message, "host": host}

@app.get("/secret")
async def root():
    message = f"Hello World {config.ENVIRONMENT_FROM_SECRET}!"
    host = f"Hello World! Served from {socket.gethostname()}"
    return {"message": message, "host": host}

app.include_router(api_router)
