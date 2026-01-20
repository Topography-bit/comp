from sqlalchemy import insert, select
from app.database import new_session


class BaseDAO():

    model = None

    @classmethod
    async def get_all(cls):
        async with new_session() as session:
            query = select(cls.model)
            res = await session.execute(query)
            return res.scalars().all()

    @classmethod
    async def add_to_db(cls, **data):
        async with new_session() as session:
            query = insert(cls.model).values(**data).returning(cls.model)
            res = await session.execute(query)
            await session.commit()
            return res.scalar_one()
        
    @classmethod
    async def find_one_by(cls, **data):
        async with new_session() as session:
            query = select(cls.model).filter_by(**data)
            res = await session.execute(query)
            return res.scalar_one_or_none()