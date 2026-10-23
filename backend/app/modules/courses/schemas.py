"""
Module Courses — Pydantic Schemas (DTOs)
"""
from typing import List, Optional
from pydantic import BaseModel


class LessonItemResponse(BaseModel):
    id: str
    order_index: int
    title: str
    duration_mins: int
    video_url: Optional[str] = None
    is_completed: bool = False

    class Config:
        from_attributes = True


class CourseCardResponse(BaseModel):
    id: str
    title: str
    description: Optional[str] = None
    category: str
    min_age: int
    max_age: int
    total_lessons: int
    rating: float
    review_count: int
    thumbnail_url: Optional[str] = None
    is_featured: bool = False

    class Config:
        from_attributes = True


class CourseDetailResponse(CourseCardResponse):
    lessons: List[LessonItemResponse] = []


class CourseFilterParams(BaseModel):
    category: Optional[str] = None
    age: Optional[int] = None
    search: Optional[str] = None
