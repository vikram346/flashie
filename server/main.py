from database import engine, Base
# from model import Users
from fastapi import FastAPI
from routes import users, sets, cards

Base.metadata.create_all(bind = engine)
app = FastAPI()
app.include_router(users.router)
app.include_router(sets.router)
app.include_router(cards.router)

@app.get("/")
def first():
    return "hello world"