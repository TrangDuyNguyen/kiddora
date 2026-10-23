"""
Module Gamification — Models
"""
from datetime import datetime, timezone
from sqlalchemy import Column, String, DateTime, Integer, ForeignKey
from sqlalchemy.dialects.postgresql import UUID
from app.core.database import Base


class Badge(Base):
    """Bảng Huy hiệu danh dự (Math Wizard, Streak Champion, STEM Explorer)"""
    __tablename__ = "badges"

    id = Column(String(50), primary_key=True)  # badge_math_wizard
    name = Column(String(100), nullable=False)
    description = Column(String(255), nullable=False)
    icon_url = Column(String(500), nullable=True)
    required_points = Column(Integer, default=50, nullable=False)


class UserBadge(Base):
    """Bảng liên kết học sinh đã đạt được huy hiệu nào"""
    __tablename__ = "user_badges"

    id = Column(Integer, primary_key=True, autoincrement=True)
    user_id = Column(UUID(as_uuid=True), ForeignKey("users.id", ondelete="CASCADE"), nullable=False, index=True)
    badge_id = Column(String(50), ForeignKey("badges.id"), nullable=False)
    earned_at = Column(DateTime(timezone=True), default=lambda: datetime.now(timezone.utc), nullable=False)
