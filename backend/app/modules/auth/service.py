"""
Module Auth — Service Logic
"""
from fastapi import HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select
from sqlalchemy.orm import selectinload

from app.core.security import get_password_hash, verify_password, create_access_token, create_refresh_token
from app.modules.auth.models import User, KidProfile
from app.modules.auth.schemas import UserRegisterRequest, UserLoginRequest, TokenResponse


class AuthService:
    def __init__(self, db: AsyncSession):
        self.db = db

    async def register(self, req: UserRegisterRequest) -> TokenResponse:
        # Kiểm tra email trùng
        stmt = select(User).where(User.email == req.email)
        res = await self.db.execute(stmt)
        if res.scalars().first():
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Email đã được sử dụng",
            )

        # Tạo User
        user = User(
            email=req.email,
            hashed_password=get_password_hash(req.password),
            full_name=req.full_name or req.nickname,
            role=req.role,
        )
        self.db.add(user)
        await self.db.flush()

        # Tạo KidProfile nếu có
        nickname = req.nickname or "Learner"
        if req.role == "student":
            profile = KidProfile(
                user_id=user.id,
                nickname=nickname,
                age=req.age or 7,
                mascot_id=req.mascot_id or "mascot_dragon",
            )
            self.db.add(profile)

        await self.db.commit()
        await self.db.refresh(user)

        access_token = create_access_token(user.id)
        refresh_token = create_refresh_token(user.id)

        return TokenResponse(
            access_token=access_token,
            refresh_token=refresh_token,
            user_id=user.id,
            email=user.email,
            role=user.role,
            nickname=nickname,
        )

    async def login(self, req: UserLoginRequest) -> TokenResponse:
        stmt = select(User).options(selectinload(User.profile)).where(User.email == req.email)
        res = await self.db.execute(stmt)
        user = res.scalars().first()

        if not user or not verify_password(req.password, user.hashed_password):
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Email hoặc mật khẩu không chính xác",
            )

        nickname = user.profile.nickname if user.profile else user.full_name

        access_token = create_access_token(user.id)
        refresh_token = create_refresh_token(user.id)

        return TokenResponse(
            access_token=access_token,
            refresh_token=refresh_token,
            user_id=user.id,
            email=user.email,
            role=user.role,
            nickname=nickname,
        )
