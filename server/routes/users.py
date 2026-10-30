from fastapi import APIRouter, Depends, HTTPException, status
from database import get_db
import schemas, utils, model
from sqlalchemy.orm import Session
router = APIRouter(tags=["Users"], prefix= '/users')

# @router.get("/u")
# def second():
#     return "route is working fine"

@router.post('/signup')
def sign_up(user: schemas.signup, db:Session = Depends(get_db)):
    hasshed_pass = utils.passHash(user.password)
    user.password = hasshed_pass
    create_user = model.Users(**user.model_dump())
    db.add(create_user)
    db.commit()
    db.refresh(create_user)
    return create_user

@router.post('/signin')
def sign_in(user: schemas.signin, db:Session = Depends(get_db)):
    valid_user = db.query(model.Users).filter(model.Users.email == user.email).first()
    if not valid_user:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="User not found")
    if not utils.pwd_context.verify(user.password, valid_user.password):
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="incorrect password")
    access_token = utils.create_acess_token({"sub": str(valid_user.id)})
    return {"message": "login successfully", "userId": valid_user.id,"access_token": access_token, "token_type": "bearer"}