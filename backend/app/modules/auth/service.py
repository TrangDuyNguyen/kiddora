"""
Module Auth — Service Logic
"""
import uuid
from fastapi import HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select
from sqlalchemy import func
from sqlalchemy.orm import selectinload

from app.core.security import get_password_hash, verify_password, create_access_token, create_refresh_token
from app.modules.auth.models import User, KidProfile
from app.modules.auth.schemas import (
    UserRegisterRequest,
    UserLoginRequest,
    KidProfileCreateRequest,
    KidProfileResponse,
    UserBaseResponse,
    TokenResponse,
    UserProfileResponse,
    VALID_MASCOTS,
)


class AuthService:
    def __init__(self, db: AsyncSession):
        self.db = db

    async def register(self, req: UserRegisterRequest) -> TokenResponse:
        # Chuẩn hoá email chữ thường & cắt khoảng trắng
        normalized_email = req.email.strip().lower()
        stmt = select(User).where(func.lower(User.email) == normalized_email)
        res = await self.db.execute(stmt)
        if res.scalars().first():
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Email đã được sử dụng",
            )

        # Tạo User (Mặc định vai trò phụ huynh bảo hộ)
        user = User(
            email=normalized_email,
            hashed_password=get_password_hash(req.password),
            full_name=req.full_name,
            role=req.role or "parent",
        )
        self.db.add(user)
        await self.db.commit()
        await self.db.refresh(user)

        access_token = create_access_token(user.id)
        refresh_token = create_refresh_token(user.id)

        return TokenResponse(
            access_token=access_token,
            refresh_token=refresh_token,
            user=UserBaseResponse(
                id=user.id,
                email=user.email,
                full_name=user.full_name,
                role=user.role,
            ),
            kid_profile=None,
        )

    async def login(self, req: UserLoginRequest) -> TokenResponse:
        normalized_email = req.email.strip().lower()
        stmt = select(User).options(selectinload(User.profile)).where(func.lower(User.email) == normalized_email)
        res = await self.db.execute(stmt)
        user = res.scalars().first()

        if not user or not verify_password(req.password, user.hashed_password):
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Email hoặc mật khẩu không chính xác",
            )

        access_token = create_access_token(user.id)
        refresh_token = create_refresh_token(user.id)

        kid_profile_data = None
        if user.profile:
            kid_profile_data = KidProfileResponse.model_validate(user.profile)

        return TokenResponse(
            access_token=access_token,
            refresh_token=refresh_token,
            user=UserBaseResponse(
                id=user.id,
                email=user.email,
                full_name=user.full_name,
                role=user.role,
            ),
            kid_profile=kid_profile_data,
        )

    async def create_or_update_kid_profile(
        self, user_id: uuid.UUID, req: KidProfileCreateRequest
    ) -> KidProfileResponse:
        """Tạo mới hoặc cập nhật hồ sơ bé gắn với tài khoản phụ huynh"""
        mascot = req.mascot_id if req.mascot_id in VALID_MASCOTS else "zodiac_dragon"
        grade_calc = f"Lớp {req.age - 5}" if 6 <= req.age <= 12 else "Tiểu học"

        stmt = select(KidProfile).where(KidProfile.user_id == user_id)
        res = await self.db.execute(stmt)
        existing_profile = res.scalars().first()

        if existing_profile:
            existing_profile.nickname = req.nickname.strip()
            existing_profile.age = req.age
            existing_profile.grade_level = grade_calc
            existing_profile.mascot_id = mascot
            await self.db.commit()
            await self.db.refresh(existing_profile)
            return KidProfileResponse.model_validate(existing_profile)

        new_profile = KidProfile(
            user_id=user_id,
            nickname=req.nickname.strip(),
            age=req.age,
            grade_level=grade_calc,
            mascot_id=mascot,
            star_points=10,
            streak_days=1,
        )
        self.db.add(new_profile)
        await self.db.commit()
        await self.db.refresh(new_profile)
        return KidProfileResponse.model_validate(new_profile)

    async def get_user_profile(self, user_id: uuid.UUID) -> UserProfileResponse:
        stmt = select(User).options(selectinload(User.profile)).where(User.id == user_id)
        res = await self.db.execute(stmt)
        user = res.scalars().first()

        if not user:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Người dùng không tồn tại",
            )

        kid_profile_data = None
        if user.profile:
            kid_profile_data = KidProfileResponse.model_validate(user.profile)

        return UserProfileResponse(
            user=UserBaseResponse.model_validate(user),
            kid_profile=kid_profile_data,
        )
