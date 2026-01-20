from fastapi import FastAPI
from app.auth.router import router as auth_router
from app.documents.router import router as docsrouter 

app = FastAPI()

app.include_router(auth_router)
app.include_router(docsrouter)