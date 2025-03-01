
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker


DATABASE_URI = 'postgresql://postgres:whatswithdaelephant@localhost:5432/decibel'

engine = create_engine(DATABASE_URI)
SessionLocal = sessionmaker(autoflush=False,autocommit = False , bind = engine)

def db_access():
    db = SessionLocal()
    try:
        yield db

    finally:
        db.close()




