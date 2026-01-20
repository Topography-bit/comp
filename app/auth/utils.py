from datetime import datetime, timedelta, timezone
from passlib.context import CryptContext
from app.config import settings
from jose import jwt

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

ACCESS_TOKEN_EXPIRE = 15
REFRESH_TOKEN_EXPIRE = 30
ALGORITM = settings.ALGORITHM
SECRET_KEY = settings.SECRET_KEY

def hash_pw(password):
    return pwd_context.hash(password)


def verify_pw(pw, hashed_pw):
    return pwd_context.verify(pw, hashed_pw)


def create_access_token(data: dict) -> str:
    expire = datetime.now(timezone.utc) + timedelta(minutes=ACCESS_TOKEN_EXPIRE)
    to_encode = data.copy()
    to_encode.update({"exp": expire, "type": "access"})
    encoded_jwt = jwt.encode(claims=to_encode, key=SECRET_KEY, algorithm=ALGORITM)
    return encoded_jwt


def create_refresh_token(data: dict) -> str:
    expire = datetime.now(timezone.utc) + timedelta(minutes=REFRESH_TOKEN_EXPIRE)
    to_encode = data.copy()
    to_encode.update({"exp": expire, "type": "refresh"})
    encoded_jwt = jwt.encode(claims=to_encode, key=SECRET_KEY, algorithm=ALGORITM)
    return encoded_jwt

def set_cookies(response, user_id: int):
    access_token = create_access_token({"sub": str(user_id)})
    refresh_token = create_refresh_token({"sub": str(user_id)})

    response.set_cookie(key="access", value=access_token, httponly=True, max_age=ACCESS_TOKEN_EXPIRE*60)
    response.set_cookie(key="refresh", value=refresh_token, httponly=True, max_age=REFRESH_TOKEN_EXPIRE*24*60*60)