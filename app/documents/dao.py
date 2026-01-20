from app.documents.models import Documents, Comments
from app.base_dao import BaseDAO


class DocumentsDAO(BaseDAO):
    model = Documents


class CommentsDAO(BaseDAO):
    model = Comments
