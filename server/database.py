
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

from config import Settings

settings = Settings()

DATABASE_URI = DATABASE_URI = settings.POSTGRES_URL

engine = create_engine(DATABASE_URI)
SessionLocal = sessionmaker(autoflush=False, autocommit=False, bind=engine)


def db_access():
    db = SessionLocal()
    try:
        yield db

    finally:
        db.close()
