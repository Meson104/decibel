
import uuid
from sqlalchemy.orm import Session
from fastapi import APIRouter, Depends, File, Form, UploadFile
from config import Settings
from database import db_access
from middlewares.auth_middleware import auth_middleware
import cloudinary
import cloudinary.uploader


settings = Settings()
router = APIRouter()

cloudinary.config( 
    cloud_name = "dvbnlssln", 
    api_key = "942958286169586", 
    api_secret = settings.CLOUDINARY_API_SECRET_KEY, 
    secure=True
)

@router.post('/')
def upload_songs(song:UploadFile= File(...) ,
                 thumbnail: UploadFile=File(...),
                 aritst:str = Form(...),
                 song_name:str = Form(...),
                 hex_code:str= Form(...),
                 db : Session = Depends(db_access),
                 auth_stat = Depends(auth_middleware)):
    song_id = str(uuid.uuid4())
    song_result = cloudinary.uploader.upload(song.file, resource_type='auto',folder = f'songs/{song_id}')
    print(song_result)
    thumbnail_result = cloudinary.uploader.upload(thumbnail.file, resource_type='image',folder=f'songs/{song_id}')
    print(thumbnail_result) 
