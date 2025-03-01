
from pydantic import BaseModel


class loginUser(BaseModel):
    email : str
    password : str