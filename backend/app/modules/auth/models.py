"""
Module Auth — SQLAlchemy Models
"""
import uuid
from datetime import datetime, timezone
from sqlalchemy import Column, String, DateTime, Integer, Boolean, ForeignKey
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import relationship

from app.core.database import Base


class User(Base):
    """Bảng người dùng chính (Học sinh, Phụ huynh, Giáo viên)"""
    __tablename__ = "users"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4, index=True)
    email = Column(String(255), unique=True, index=True, nullable=False)
    hashed_password = Column(String(255), nullable=False)
    full_name = Column(String(100), nullable=True)
    role = Column(String(20), default="parent", nullable=False)  # parent, student, coach
    is_active = Column(Boolean, default=True, nullable=False)

    # Quan hệ cha con (COPPA child account liên kết với parent)
    parent_id = Column(UUID(as_uuid=True), ForeignKey("users.id"), nullable=True)

    created_at = Column(DateTime(timezone=True), default=lambda: datetime.now(timezone.utc), nullable=False)
    updated_at = Column(DateTime(timezone=True), default=lambda: datetime.now(timezone.utc), onupdate=lambda: datetime.now(timezone.utc), nullable=False)

    def __init__(self, **kwargs):
        if "id" not in kwargs or kwargs["id"] is None:
            kwargs["id"] = uuid.uuid4()
        super().__init__(**kwargs)

    # Relationships
    profile = relationship("KidProfile", back_populates="user", uselist=False, cascade="all, delete-orphan")


class KidProfile(Base):
    """Bảng hồ sơ cá nhân hóa của trẻ (Avatar linh vật 12 con giáp hoặc Classic, tuổi, điểm sao)"""
    __tablename__ = "kid_profiles"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4, index=True)
    user_id = Column(UUID(as_uuid=True), ForeignKey("users.id", ondelete="CASCADE"), unique=True, nullable=False)
    nickname = Column(String(50), nullable=False)
    age = Column(Integer, nullable=False)  # 6 - 12 (COPPA range)
    grade_level = Column(String(50), nullable=True)
    mascot_id = Column(String(50), default="zodiac_dragon", nullable=False)
    star_points = Column(Integer, default=10, nullable=False)
    streak_days = Column(Integer, default=1, nullable=False)

    created_at = Column(DateTime(timezone=True), default=lambda: datetime.now(timezone.utc), nullable=False)
    updated_at = Column(DateTime(timezone=True), default=lambda: datetime.now(timezone.utc), onupdate=lambda: datetime.now(timezone.utc), nullable=False)

    def __init__(self, **kwargs):
        if "id" not in kwargs or kwargs["id"] is None:
            kwargs["id"] = uuid.uuid4()
        super().__init__(**kwargs)

    # Relationship
    user = relationship("User", back_populates="profile")

