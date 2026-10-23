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
        search: Optional[str] = None,
    ) -> List[Course]:
        stmt = select(Course).options(selectinload(Course.lessons))

        if category and category.lower() != "all":
            stmt = stmt.where(Course.category == category.lower())
        if age:
            stmt = stmt.where(Course.min_age <= age, Course.max_age >= age)
        if search:
            stmt = stmt.where(Course.title.ilike(f"%{search}%"))

        res = await self.db.execute(stmt)
        return list(res.scalars().all())

    async def get_course_by_id(self, course_id: str) -> Optional[Course]:
        stmt = select(Course).options(selectinload(Course.lessons)).where(Course.id == course_id)
        res = await self.db.execute(stmt)
        return res.scalars().first()
