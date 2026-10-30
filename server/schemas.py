from pydantic import BaseModel, EmailStr

class signup(BaseModel):
    username: str
    password: str
    email: EmailStr

class signin(BaseModel):
    password: str
    email: EmailStr
    

class AddSet(BaseModel):
    title: str
    description: str
    # user_id : int

class AddCard(BaseModel):
    set_id: int
    question: str
    answer: str