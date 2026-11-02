"""
Module Courses — Repository (DB Queries)
"""
from typing import List, Optional
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select
from sqlalchemy.orm import selectinload

from app.modules.courses.models import Course, Lesson


class CourseRepository:
    def __init__(self, db: AsyncSession):
        self.db = db

    async def list_courses(
        self,
        category: Optional[str] = None,
        age: Optional[int] = None,
        min_age: Optional[int] = None,
        max_age: Optional[int] = None,
        level: Optional[str] = None,
        duration: Optional[str] = None,
        search: Optional[str] = None,
    ) -> List[Course]:
        stmt = select(Course).options(selectinload(Course.lessons))

        if category and category.lower() != "all":
            stmt = stmt.where(Course.category == category.lower())
        if age:
            stmt = stmt.where(Course.min_age <= age, Course.max_age >= age)
        if min_age is not None and max_age is not None:
            stmt = stmt.where(Course.min_age <= max_age, Course.max_age >= min_age)
        elif min_age is not None:
            stmt = stmt.where(Course.max_age >= min_age)
        elif max_age is not None:
            stmt = stmt.where(Course.min_age <= max_age)

        if level and level.lower() != "all":
            stmt = stmt.where(Course.level == level.lower())
        if search:
            stmt = stmt.where(Course.title.ilike(f"%{search}%"))

        res = await self.db.execute(stmt)
        courses = list(res.scalars().all())

        if duration and duration.lower() != "all":
            dur = duration.lower()
            if dur == "short":
                courses = [c for c in courses if 1 <= len(c.lessons) <= 3]
            elif dur == "medium":
                courses = [c for c in courses if 4 <= len(c.lessons) <= 6]
            elif dur == "long":
                courses = [c for c in courses if len(c.lessons) >= 7]

        return courses

    async def get_course_by_id(self, course_id: str) -> Optional[Course]:
        stmt = select(Course).options(selectinload(Course.lessons)).where(Course.id == course_id)
        res = await self.db.execute(stmt)
        return res.scalars().first()
