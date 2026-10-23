"""
Module Auth — Router Endpoints
"""
import uuid
from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.deps import get_db, get_current_user_id
from app.modules.auth.schemas import (
    UserRegisterRequest,
    UserLoginRequest,
    KidProfileCreateRequest,
    KidProfileResponse,
    TokenResponse,
    UserProfileResponse,
)
from app.modules.auth.service import AuthService

router = APIRouter(prefix="/auth", tags=["Auth"])


@router.post("/register", response_model=TokenResponse)
async def register(req: UserRegisterRequest, db: AsyncSession = Depends(get_db)):
    """Đăng ký tài khoản Phụ huynh mới"""
    service = AuthService(db)
    return await service.register(req)


@router.post("/login", response_model=TokenResponse)
async def login(req: UserLoginRequest, db: AsyncSession = Depends(get_db)):
    """Đăng nhập bằng Email và Password, trả về JWT Access Token & Profile nếu có"""
    service = AuthService(db)
    return await service.login(req)


@router.post("/kid-profile", response_model=KidProfileResponse)
async def create_or_update_kid_profile(
    req: KidProfileCreateRequest,
    user_id: str = Depends(get_current_user_id),
    db: AsyncSession = Depends(get_db),
):
    """Tạo hoặc cập nhật hồ sơ bé gắn liền với tài khoản phụ huynh hiện tại"""
    service = AuthService(db)
    return await service.create_or_update_kid_profile(uuid.UUID(user_id), req)


@router.get("/me", response_model=UserProfileResponse)
async def get_me(
    user_id: str = Depends(get_current_user_id),
    db: AsyncSession = Depends(get_db),
):
    """Lấy thông tin người dùng và hồ sơ bé hiện tại từ JWT"""
    service = AuthService(db)
    return await service.get_user_profile(uuid.UUID(user_id))
