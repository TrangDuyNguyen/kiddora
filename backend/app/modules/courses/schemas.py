"""
Module Courses — Pydantic Schemas (DTOs)
"""
from typing import List, Optional
from pydantic import BaseModel, ConfigDict


class LessonItemResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: str
    order_index: int
    title: str
    duration_mins: int
    thumbnail_url: Optional[str] = None
    video_url: Optional[str] = None
    is_completed: bool = False
    is_unlocked: bool = False


class CourseCardResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: str
    title: str
    description: Optional[str] = None
    category: str
    min_age: int
    max_age: int
    level: str = "beginner"
    total_lessons: int
    rating: float
    review_count: int
    thumbnail_url: Optional[str] = None
    is_featured: bool = False


class CourseDetailResponse(CourseCardResponse):
    subtitle: Optional[str] = None
    lessons: List[LessonItemResponse] = []


class LessonBlueprintResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    lesson_id: str
    course_id: str
    title: str
    archetype: str
    target_age_group: str
    estimated_duration_mins: int
    stages: List[dict] = []


class LessonCompleteRequest(BaseModel):
    score: int = 100
    stars_earned: int = 10


class LessonCompleteResponse(BaseModel):
    status: str = "success"
    lesson_id: str
    stars_earned: int
    total_stars: int
    streak_days: int
