from dotenv import load_dotenv

from pydantic_settings import BaseSettings

load_dotenv()


class Settings(BaseSettings):
    POSTGRES_URL: str = ""
    AUTH_ENCODING_KEY: str = ""
    CLOUDINARY_API_SECRET_KEY: str = ""
