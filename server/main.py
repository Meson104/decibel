from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class createUser(BaseModel):
    name : str
    email : str
    password : str

@app.post('/signup')
def test(user : createUser):
    pass