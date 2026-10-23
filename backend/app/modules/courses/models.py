"""
Module Courses — SQLAlchemy Models
"""
import uuid
from datetime import datetime, timezone
from sqlalchemy import Column, String, DateTime, Integer, Float, Boolean, ForeignKey, Text
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import relationship

from app.core.database import Base


class Course(Base):
    """Bảng Khóa học (Toán tư duy, Khoa học thực nghiệm, Nghệ thuật, Ngôn ngữ)"""
    __tablename__ = "courses"

    id = Column(String(50), primary_key=True, index=True)  # VD: course_amazing_animals
    title = Column(String(200), nullable=False)
    description = Column(Text, nullable=True)
    category = Column(String(50), nullable=False, index=True)  # science, math, arts, language
    min_age = Column(Integer, default=6, nullable=False)
    max_age = Column(Integer, default=12, nullable=False)
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
    video_url = Column(String(500), nullable=True)  # URL trỏ tới MinIO storage

    created_at = Column(DateTime(timezone=True), default=lambda: datetime.now(timezone.utc), nullable=False)

    # Relationship
    course = relationship("Course", back_populates="lessons")


class UserProgress(Base):
    """Theo dõi tiến độ học tập từng bài của học sinh"""
    __tablename__ = "user_progress"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    user_id = Column(UUID(as_uuid=True), ForeignKey("users.id", ondelete="CASCADE"), nullable=False, index=True)
    course_id = Column(String(50), ForeignKey("courses.id"), nullable=False)
    lesson_id = Column(String(50), ForeignKey("lessons.id"), nullable=False)
    is_completed = Column(Boolean, default=False, nullable=False)
    completed_at = Column(DateTime(timezone=True), nullable=True)
