"""
Module Classroom — Models
"""
from datetime import datetime, timezone
from sqlalchemy import Column, String, DateTime, Integer, ForeignKey
from sqlalchemy.dialects.postgresql import UUID
from app.core.database import Base


class LiveSession(Base):
    """Bảng Phiên học trực tuyến Live Video"""
    __tablename__ = "live_sessions"

    id = Column(String(50), primary_key=True, index=True)  # VD: live_space_exp
    title = Column(String(200), nullable=False)
    coach_id = Column(UUID(as_uuid=True), ForeignKey("users.id"), nullable=True)
    coach_name = Column(String(100), default="Coach Sarah", nullable=False)
    coach_avatar = Column(String(500), nullable=True)
    livekit_room = Column(String(100), nullable=False, unique=True)
    scheduled_at = Column(DateTime(timezone=True), nullable=False)
    duration_mins = Column(Integer, default=45, nullable=False)
    status = Column(String(20), default="upcoming", nullable=False)  # upcoming, live_now, completed

    created_at = Column(DateTime(timezone=True), default=lambda: datetime.now(timezone.utc), nullable=False)
