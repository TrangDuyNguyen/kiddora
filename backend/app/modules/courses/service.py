"""
Module Courses — Service (Business Logic)
"""
from typing import List, Optional
from fastapi import HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.modules.courses.repository import CourseRepository
from app.modules.courses.schemas import CourseCardResponse, CourseDetailResponse, LessonItemResponse


class CourseService:
    def __init__(self, db: AsyncSession):
        self.repo = CourseRepository(db)

    async def get_courses(
        self,
        category: Optional[str] = None,
        age: Optional[int] = None,
        search: Optional[str] = None,
    ) -> List[CourseCardResponse]:
        courses = await self.repo.list_courses(category=category, age=age, search=search)
        return [
            CourseCardResponse(
                id=c.id,
                title=c.title,
                description=c.description,
                category=c.category,
                min_age=c.min_age,
                max_age=c.max_age,
                total_lessons=len(c.lessons),
                rating=c.rating,
                review_count=c.review_count,
                thumbnail_url=c.thumbnail_url,
                is_featured=c.is_featured,
            )
            for c in courses
        ]

    async def get_course_detail(self, course_id: str) -> CourseDetailResponse:
        c = await self.repo.get_course_by_id(course_id)
        if not c:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Khóa học không tồn tại",
            )

        lessons = [
            LessonItemResponse(
                id=l.id,
                order_index=l.order_index,
                title=l.title,
                duration_mins=l.duration_mins,
                video_url=l.video_url,
                is_completed=False,
            )
            for l in c.lessons
        ]

        return CourseDetailResponse(
            id=c.id,
            title=c.title,
            description=c.description,
            category=c.category,
            min_age=c.min_age,
            max_age=c.max_age,
            total_lessons=len(lessons),
            rating=c.rating,
            review_count=c.review_count,
            thumbnail_url=c.thumbnail_url,
            is_featured=c.is_featured,
            lessons=lessons,
        )
