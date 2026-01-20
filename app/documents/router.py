from fastapi import APIRouter

from app.documents.dao import DocumentsDAO

router = APIRouter(tags=["Documents"], prefix="/docs")

@router.get("/all")
async def get_all_docs():
    return await DocumentsDAO.get_all()