from fastapi import APIRouter, HTTPException, Response

from app.auth.dao import AuthDAO
from app.auth.schemas import SRegister, SUserOut
from app.auth.utils import hash_pw, set_cookies, verify_pw

router = APIRouter(prefix="/users", tags=["Auth"])


@router.post("/register", response_model=SUserOut)
async def register(data: SRegister):

    user = await AuthDAO.find_one_by(name=data.name)

    if user:
        raise HTTPException(status_code=409, detail="Пользователь с таким именем уже существует, выберите другое")

    hashed_pw = hash_pw(data.password)

    return await AuthDAO.add_to_db(name=data.name, password=hashed_pw)


@router.post("/login", response_model=SUserOut)
async def login(data: SRegister, response: Response):
    
    user = await AuthDAO.find_one_by(name=data.name)

    if not user:
        raise HTTPException(status_code=404, detail="Пользователя с таким именем не существует")
    
    if not verify_pw(pw=data.password, hashed_pw=user.password):
        raise HTTPException(status_code=403, detail="Неверное имя или пароль")

    set_cookies(response, user.id)
    return user