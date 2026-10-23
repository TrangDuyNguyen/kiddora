"""
Module Gamification — Schemas & Router
"""
from typing import List, Optional
from fastapi import APIRouter, Depends
from pydantic import BaseModel
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select

from app.core.deps import get_db, get_current_user_id
from app.modules.gamification.models import Badge, UserBadge

router = APIRouter(prefix="/gamification", tags=["Gamification"])


class BadgeResponse(BaseModel):
    id: str
    name: str
    description: str
    icon_url: Optional[str] = None
    required_points: int
    is_earned: bool = False

    class Config:
        from_attributes = True


@router.get("/badges", response_model=List[BadgeResponse])
async def list_badges(
    user_id: str = Depends(get_current_user_id),
    db: AsyncSession = Depends(get_db),
):
    """Lấy danh sách tất cả huy hiệu kèm trạng thái đã đạt được của học sinh"""
    import uuid
    # Lấy all badges
    res_b = await db.execute(select(Badge))
    badges = res_b.scalars().all()

    # Lấy badges mà user đã đạt được
    res_ub = await db.execute(select(UserBadge.badge_id).where(UserBadge.user_id == uuid.UUID(user_id)))
    earned_badge_ids = set(res_ub.scalars().all())

    return [
        BadgeResponse(
            id=b.id,
            name=b.name,
            description=b.description,
            icon_url=b.icon_url,
            required_points=b.required_points,
            is_earned=(b.id in earned_badge_ids),
        )
        for b in badges
    ]
