
from fastapi import FastAPI
from models.base import Base
from routes import auth
from database import engine
from fastapi.middleware.cors import CORSMiddleware


app = FastAPI()
app.include_router(auth.router,prefix='/auth')
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  
    allow_credentials=True,
    allow_methods=["*"], 
    allow_headers=["*"],  
)

Base.metadata.create_all(engine)