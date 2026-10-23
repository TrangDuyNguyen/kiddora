"""
Module Auth — Pydantic Schemas (DTOs)
"""
import uuid
from typing import Optional
from pydantic import BaseModel, ConfigDict, EmailStr, Field


VALID_MASCOTS = {
    'lion', 'bear', 'dino', 'bunny',
    'zodiac_mouse', 'zodiac_buffalo', 'zodiac_tiger', 'zodiac_cat',
    'zodiac_dragon', 'zodiac_snake', 'zodiac_horse', 'zodiac_goat',
    'zodiac_monkey', 'zodiac_rooster', 'zodiac_dog', 'zodiac_pig'
}


class UserRegisterRequest(BaseModel):
    email: EmailStr
    password: str = Field(..., min_length=6, description="Mật khẩu ít nhất 6 ký tự")
    full_name: Optional[str] = None
    role: str = "parent"


class UserLoginRequest(BaseModel):
    email: EmailStr
    password: str


class KidProfileCreateRequest(BaseModel):
    nickname: str = Field(..., min_length=2, max_length=50, description="Biệt danh của bé từ 2 đến 50 ký tự")
    age: int = Field(..., ge=6, le=12, description="Tuổi của bé từ 6 đến 12 tuổi theo chuẩn COPPA")
    mascot_id: str = Field(default="zodiac_dragon", description="Mã linh vật trong danh sách được hỗ trợ")


class KidProfileResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    user_id: uuid.UUID
    nickname: str
    age: int
    grade_level: Optional[str] = None
    mascot_id: str
    star_points: int = 10
    streak_days: int = 1


class UserBaseResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    email: str
    full_name: Optional[str] = None
    role: str


class TokenResponse(BaseModel):
    access_token: str
    refresh_token: str
    token_type: str = "bearer"
    user: UserBaseResponse
    kid_profile: Optional[KidProfileResponse] = None


class UserProfileResponse(BaseModel):
    user: UserBaseResponse
    kid_profile: Optional[KidProfileResponse] = None
