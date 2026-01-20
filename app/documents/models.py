from datetime import datetime, timezone
from sqlalchemy import ForeignKey, func
from sqlalchemy.orm import Mapped, mapped_column

from app.database import Base


class Documents(Base):
    __tablename__ = "documents"

    id: Mapped[int] = mapped_column(primary_key=True)
    title: Mapped[str] = mapped_column(nullable=False)
    date_created: Mapped[datetime] = mapped_column(nullable=False, default=func.now())
    date_updated: Mapped[datetime] = mapped_column(nullable=False, default=func.now())
    category: Mapped[str] = mapped_column(default=None)
    has_comments: Mapped[bool] = mapped_column(default=False)

class Comments(Base):
    __tablename__ = "comments"

    id: Mapped[int] = mapped_column(primary_key=True)
    document_id: Mapped[int] = mapped_column(ForeignKey("documents.id"))
    text: Mapped[str] = mapped_column()
    date_created: Mapped[datetime] = mapped_column(nullable=False, default=func.now())
    date_updated: Mapped[datetime] = mapped_column(nullable=False, default=func.now())
    author_id: Mapped[int] = mapped_column(ForeignKey("users.id"))
    