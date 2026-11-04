"""
Module Courses — SQLAlchemy Models
"""
import uuid
from datetime import datetime, timezone
from sqlalchemy import Column, String, DateTime, Integer, Float, Boolean, ForeignKey, Text, JSON
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import relationship

from app.core.database import Base


class Course(Base):
    """Bảng Khóa học (Toán tư duy, Khoa học thực nghiệm, Nghệ thuật, Ngôn ngữ)"""
    __tablename__ = "courses"

    id = Column(String(50), primary_key=True, index=True)  # VD: course_amazing_animals
    title = Column(String(200), nullable=False)
    subtitle = Column(String(300), nullable=True)
    description = Column(Text, nullable=True)
    category = Column(String(50), nullable=False, index=True)  # science, math, arts, language, technology
    min_age = Column(Integer, default=6, nullable=False)
    max_age = Column(Integer, default=12, nullable=False)
    level = Column(String(30), default="beginner", nullable=False)  # beginner, intermediate, advanced
    rating = Column(Float, default=5.0, nullable=False)
    review_count = Column(Integer, default=0, nullable=False)
    thumbnail_url = Column(String(500), nullable=True)
    is_featured = Column(Boolean, default=False, nullable=False)

    coach_id = Column(UUID(as_uuid=True), ForeignKey("users.id"), nullable=True)

    created_at = Column(DateTime(timezone=True), default=lambda: datetime.now(timezone.utc), nullable=False)

    # Relationships
    lessons = relationship("Lesson", back_populates="course", cascade="all, delete-orphan", order_by="Lesson.order_index")


class Lesson(Base):
    """Bảng Bài giảng chi tiết trong một khóa học"""
    __tablename__ = "lessons"

    id = Column(String(50), primary_key=True, index=True)  # VD: lesson_anim_01
    course_id = Column(String(50), ForeignKey("courses.id", ondelete="CASCADE"), nullable=False, index=True)
    order_index = Column(Integer, default=1, nullable=False)
    title = Column(String(200), nullable=False)
    duration_mins = Column(Integer, default=10, nullable=False)
    thumbnail_url = Column(String(500), nullable=True)
    video_url = Column(String(500), nullable=True)  # URL trỏ tới MinIO storage
    is_unlocked = Column(Boolean, default=False, nullable=False)
    is_completed = Column(Boolean, default=False, nullable=False)
    blueprint_json = Column(JSON, nullable=True)

    created_at = Column(DateTime(timezone=True), default=lambda: datetime.now(timezone.utc), nullable=False)

    # Relationship
    course = relationship("Course", back_populates="lessons")


class UserLessonProgress(Base):
    """Bảng ghi nhận tiến độ học tập từng bài của học sinh"""
    __tablename__ = "user_lesson_progress"

    id = Column(Integer, primary_key=True, autoincrement=True)
    user_id = Column(UUID(as_uuid=True), ForeignKey("users.id", ondelete="CASCADE"), nullable=False, index=True)
    lesson_id = Column(String(50), ForeignKey("lessons.id", ondelete="CASCADE"), nullable=False, index=True)
    is_completed = Column(Boolean, default=False, nullable=False)
    score = Column(Integer, default=0, nullable=False)
    stars_earned = Column(Integer, default=0, nullable=False)
    completed_at = Column(DateTime(timezone=True), default=lambda: datetime.now(timezone.utc), nullable=False)
