from fastapi import APIRouter, Depends, HTTPException, status
from database import get_db
import schemas, model
from sqlalchemy.orm import Session
from auth import get_current_user_id;


router = APIRouter(tags= ["Sets"], prefix="/sets")

@router.post("/add")
def add_set(set_data: schemas.AddSet,user_id:int =Depends(get_current_user_id),db:Session = Depends(get_db)):
    new_set = model.Sets(title = set_data.title, description = set_data.description, user_id = user_id)
    db.add(new_set)
    db.commit()
    db.refresh(new_set)
    return new_set

@router.get('/fetch')
def fetch_set(user_id: int = Depends(get_current_user_id), db:Session = Depends(get_db)):
    sets = db.query(model.Sets).filter(model.Sets.user_id == user_id).all()
    return sets

@router.delete('/delete/{id}')
def delete_set(id: int, user_id:int = Depends(get_current_user_id) , db:Session = Depends(get_db)):
    set = db.query(model.Sets).filter(model.Sets.id == id, model.Sets.user_id ==user_id).first()
    if set is None:
        raise HTTPException(status_code= status.HTTP_404_NOT_FOUND, detail="not found any set")
    db.query(model.Cards).filter(model.Cards.set_id ==id).delete(synchronize_session=False)
    db.delete(set)
    db.commit()
    return {"message": "Set deleted successfully"}
    