from fastapi import HTTPException, Request
from jose import jwt
from app.auth.dao import AuthDAO
from app.config import settings

async def get_current_user(request: Request):
    token = request.cookies.get("access")
    try:
        payload = jwt.decode(token=token, key=settings.SECRET_KEY, algorithms=[settings.ALGORITHM])
        user = await AuthDAO().find_one_or_none(id=int(payload.get("sub")))
        if user: return user
    except Exception:
        raise HTTPException(status_code=401, detail="Не авторизован")