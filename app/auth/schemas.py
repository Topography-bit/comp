


from pydantic import BaseModel, Field


class SRegister(BaseModel):
    name: str = Field(min_length=1)
    password: str = Field(min_length=5)


class SUserOut(BaseModel):
    id: int
    name: str