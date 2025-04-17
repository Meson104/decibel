
import uuid
from venv import create
import bcrypt
from fastapi import Depends, HTTPException
from database import db_access
from models.user import User
from pydantic_schemas.create_user import createUser
from fastapi import APIRouter
from sqlalchemy.orm import Session

from pydantic_schemas.login_user import loginUser 


router = APIRouter() 

@router.post('/signup',status_code=201)                                     
def signup(user : createUser , db:Session = Depends(db_access)):
    #check if user exists in the db , they shouldn't if we're registering
    user_exists = db.query(User).filter(User.email == user.email).first()

    if(user_exists):
        raise HTTPException(400,"User with the same email already exists!")  
    # moving on , create instance and  add the user to the db by setting all fields of our schema to that we will recieve in the request and store hashed pw
    hashed_pass  = bcrypt.hashpw(user.password.encode(),bcrypt.gensalt(16))
    user_instance = User(id= str(uuid.uuid4()),name= user.name  , email = user.email,password= hashed_pass) 
    db.add(user_instance )    
    db.commit() 
    db.refresh(user_instance)

    return user_instance   

@router.post('/login')
def login(user : loginUser, db:Session = Depends(db_access)):
    # check if user exists in the first place
    user_exists = db.query(User).filter(User.email == user.email).first()

    if not user_exists:
        raise HTTPException(400 , "User with this email doesn't exist")
    
    # password match checking 
    
    password_matches = bcrypt.checkpw(user.password.encode(),user_exists.password)
    if not password_matches:
        raise HTTPException(400,"Incorrect credentials, try again")
    
    return user_exists