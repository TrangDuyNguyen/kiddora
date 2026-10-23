"""
Module Auth — Router Endpoints
"""
from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.deps import get_db, get_current_user_id
from app.modules.auth.schemas import UserRegisterRequest, UserLoginRequest, TokenResponse, UserProfileResponse
from app.modules.auth.service import AuthService
from app.modules.auth.models import User
from sqlalchemy.future import select
from sqlalchemy.orm import selectinload

router = APIRouter(prefix="/auth", tags=["Auth"])


@router.post("/register", response_model=TokenResponse)
async def register(req: UserRegisterRequest, db: AsyncSession = Depends(get_db)):
    """Đăng ký tài khoản mới (Học sinh kèm hồ sơ bé hoặc Phụ huynh)"""
    service = AuthService(db)
    return await service.register(req)


@router.post("/login", response_model=TokenResponse)
async def login(req: UserLoginRequest, db: AsyncSession = Depends(get_db)):
    """Đăng nhập bằng Email và Password, trả về JWT Access Token"""
    service = AuthService(db)
    return await service.login(req)


@router.get("/me", response_model=UserProfileResponse)
async def get_me(user_id: str = Depends(get_current_user_id), db: AsyncSession = Depends(get_db)):
    """Lấy thông tin profile người dùng hiện tại từ JWT"""
    import uuid
    stmt = select(User).options(selectinload(User.profile)).where(User.id == uuid.UUID(user_id))
    res = await db.execute(stmt)
    user = res.scalars().first()

    return UserProfileResponse(
        id=user.id,
        email=user.email,
        role=user.role,
        nickname=user.profile.nickname if user.profile else user.full_name,
        age=user.profile.age if user.profile else None,
        mascot_id=user.profile.mascot_id if user.profile else None,
        star_points=user.profile.star_points if user.profile else 0,
        streak_days=user.profile.streak_days if user.profile else 0,
    )
