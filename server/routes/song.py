
import uuid
from sqlalchemy.orm import Session , joinedload
from fastapi import APIRouter, Depends, File, Form, UploadFile
from config import Settings
from database import db_access
from middlewares.auth_middleware import auth_middleware
import cloudinary
import cloudinary.uploader

from models.favorite import Favorite
from models.song import Song
from pydantic_schemas.favorite_songs import FavoriteSong


settings = Settings()
router = APIRouter()

cloudinary.config( 
    cloud_name = "dvbnlssln", 
    api_key = "942958286169586", 
    api_secret = settings.CLOUDINARY_API_SECRET_KEY, 
    secure=True
)

@router.post('/upload', status_code=201)
def upload_songs(song:UploadFile= File(...) ,
                 thumbnail: UploadFile=File(...),
                 artist:str = Form(...),
                 song_name:str = Form(...),
                 hex_code:str= Form(...),
                 db : Session = Depends(db_access),
                 auth_stat = Depends(auth_middleware)):
    song_id = str(uuid.uuid4())
    song_result = cloudinary.uploader.upload(song.file, resource_type='auto',folder = f'songs/{song_id}')
    # print(song_result['url'])
    thumbnail_result = cloudinary.uploader.upload(thumbnail.file, resource_type='image',folder=f'songs/{song_id}')
    # print(thumbnail_result['url'])

    new_song = Song(
        id = song_id,
        song_url = song_result['url'],
        thumbnail_url = thumbnail_result['url'],
        artist = artist,
        song_name = song_name,
        hex_code = hex_code
    )

    db.add(new_song)
    db.commit()
    db.refresh(new_song)
    return new_song

@router.get('/list')
def list_songs(db : Session = Depends(db_access),auth_stat = Depends(auth_middleware)):
    songs = db.query(Song).all()
    return songs


@router.post('/favorite')
def favorite_songs(song : FavoriteSong, db : Session = Depends(db_access) , auth_stat = Depends(auth_middleware)):
    
    user_id = auth_stat['uid']
    fav_song = db.query(Favorite).filter(Favorite.song_id == song.song_id , Favorite.user_id == user_id).first()

    if fav_song:
        db.delete(fav_song)
        db.commit()
        return {"message": False}
    else:
        new_fav = Favorite(id= uuid.uuid4(), song_id = song.song_id ,user_id = user_id)
        db.add(new_fav)
        db.commit()
        return {"message": True}

@router.get('/list/favorites')
def list_favorite_songs(db: Session = Depends(db_access), auth_stat = Depends(auth_middleware)):

    user_id = auth_stat['uid']
    fav_songs = db.query(Favorite).filter(Favorite.user_id == user_id).options(joinedload(Favorite.song)).all()

    return fav_songs 