"""
Module Auth — Pydantic Schemas (DTOs)
"""
import uuid
from typing import Optional
from pydantic import BaseModel, EmailStr, Field


class UserRegisterRequest(BaseModel):
    email: EmailStr
    password: str = Field(..., min_length=6, description="Mật khẩu ít nhất 6 ký tự")
    full_name: Optional[str] = None
    role: str = "student"
    # Dữ liệu hồ sơ bé đi kèm nếu đăng ký học sinh
    nickname: Optional[str] = None
    age: Optional[int] = Field(None, ge=6, le=12)
    mascot_id: Optional[str] = "mascot_dragon"


class UserLoginRequest(BaseModel):
    email: EmailStr
    password: str


class TokenResponse(BaseModel):
    access_token: str
    refresh_token: str
    token_type: str = "bearer"
    user_id: uuid.UUID
    email: str
    role: str
    nickname: Optional[str] = None


class UserProfileResponse(BaseModel):
    id: uuid.UUID
    email: str
    role: str
    nickname: Optional[str] = None
    age: Optional[int] = None
    mascot_id: Optional[str] = None
    star_points: int = 0
    streak_days: int = 0

    class Config:
        from_attributes = True
