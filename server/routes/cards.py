from fastapi import APIRouter, Depends, HTTPException, status
from database import get_db
import schemas, model
from sqlalchemy.orm import Session
from auth import get_current_user_id

router = APIRouter(tags= ["Cards"], prefix="/cards")

@router.post("/add")
def add_card(card: schemas.AddCard,db:Session = Depends(get_db), user_id:int = Depends(get_current_user_id)):
    parent_set = db.query(model.Sets).filter(model.Sets.id == card.set_id, model.Sets.user_id == user_id).first()
    if parent_set is None:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Set not found"
        )
    new_card = model.Cards(question = card.question, answer = card.answer, set_id = card.set_id)
    db.add(new_card)
    db.commit()
    db.refresh(new_card)
    return new_card

@router.get('/fetch')
def fetch_card(id: int, db:Session = Depends(get_db),  user_id:int = Depends(get_current_user_id)):
    parent_set  = db.query(model.Sets).filter(model.Sets.id == id, model.Sets.user_id == user_id).first()
    if parent_set is None:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Set not found"
            )
    cards = db.query(model.Cards).filter(model.Cards.set_id == id).all()
    return cards

@router.delete('/delete/{id}')
def delete_card(id: int, user_id:int = Depends(get_current_user_id) , db:Session = Depends(get_db)):
    
    card = db.query(model.Cards).filter(model.Cards.id == id).first()
    if card is None:
        raise HTTPException(status_code= status.HTTP_404_NOT_FOUND, detail="not found any card")
    parent_set = db.query(model.Sets).filter(model.Sets.id == card.set_id, model.Sets.user_id == user_id).first()
    if parent_set is None:
                raise HTTPException(
                    status_code=status.HTTP_404_NOT_FOUND,
                    detail="Set not found"
                    )
    db.delete(card)
    db.commit()
    return {"message": "Card deleted successfully"}