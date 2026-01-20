from sqlalchemy import MetaData, Table

from app.auth.models import Users
from app.base_dao import BaseDAO

class AuthDAO(BaseDAO):
    model = Users