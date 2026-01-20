from sqlalchemy.orm import mapped_column, Mapped

from app.database import Base



class Users(Base):
    __tablename__ = "users"

    id: Mapped[int] = mapped_column(primary_key=True)
    name: Mapped[str] = mapped_column(nullable=False)
    password: Mapped[str] = mapped_column(nullable=False)
    position: Mapped[str] = mapped_column(default="Администратор", nullable=True)