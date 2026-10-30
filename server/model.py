from sqlalchemy import Column, Integer, String, ForeignKey
from database import Base

class Users(Base):
    __tablename__ = "Users"
    id = Column(Integer, primary_key= True, index= True)
    email = Column(String, unique=True, nullable=False)
    username = Column(String, nullable=False)
    password = Column(String, nullable=False)

class Sets(Base):
    __tablename__ = "Sets"
    id = Column(Integer, primary_key= True, index= True)
    title = Column(String, nullable=False)
    description = Column(String, nullable=False)
    user_id = Column(Integer, ForeignKey("Users.id"), nullable=False)

class Cards(Base):
    __tablename__ = "Cards"
    id = Column(Integer, primary_key= True, index= True)
    question = Column(String, nullable=False)
    answer = Column(String, nullable=False)
    set_id = Column(Integer, ForeignKey("Sets.id"), nullable=False)