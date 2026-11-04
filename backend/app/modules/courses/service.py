"""
Module Courses — Service (Business Logic)
"""
import uuid
from typing import List, Optional
from fastapi import HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.modules.courses.repository import CourseRepository
from app.modules.courses.schemas import (
    CourseCardResponse,
    CourseDetailResponse,
    LessonItemResponse,
    LessonBlueprintResponse,
    LessonCompleteResponse,
)


class CourseService:
    def __init__(self, db: AsyncSession):
        self.repo = CourseRepository(db)

    async def get_courses(
        self,
        category: Optional[str] = None,
        age: Optional[int] = None,
        min_age: Optional[int] = None,
        max_age: Optional[int] = None,
        level: Optional[str] = None,
        duration: Optional[str] = None,
        search: Optional[str] = None,
    ) -> List[CourseCardResponse]:
        courses = await self.repo.list_courses(
            category=category,
            age=age,
            min_age=min_age,
            max_age=max_age,
            level=level,
            duration=duration,
            search=search,
        )
        return [
            CourseCardResponse(
                id=c.id,
                title=c.title,
                description=c.description,
                category=c.category,
                min_age=c.min_age,
                max_age=c.max_age,
                level=c.level or "beginner",
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
                thumbnail_url=l.thumbnail_url,
                video_url=l.video_url,
                is_completed=bool(l.is_completed),
                is_unlocked=bool(l.is_unlocked),
            )
            for l in c.lessons
        ]

        return CourseDetailResponse(
            id=c.id,
            title=c.title,
            subtitle=c.subtitle,
            description=c.description,
            category=c.category,
            min_age=c.min_age,
            max_age=c.max_age,
            level=c.level or "beginner",
            total_lessons=len(lessons),
            rating=c.rating,
            review_count=c.review_count,
            thumbnail_url=c.thumbnail_url,
            is_featured=c.is_featured,
            lessons=lessons,
        )

    async def get_lesson_blueprint(self, lesson_id: str) -> dict:
        lesson = await self.repo.get_lesson_by_id(lesson_id)
        if not lesson:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Bài học không tồn tại",
            )

        if lesson.blueprint_json:
            return lesson.blueprint_json

        # Default fallback 5E blueprint
        return {
            "lesson_id": lesson.id,
            "course_id": lesson.course_id,
            "title": lesson.title,
            "archetype": "exploration",
            "target_age_group": "7-10",
            "estimated_duration_mins": lesson.duration_mins,
            "stages": [
                {
                    "step_order": 1,
                    "stage_5e": "engage",
                    "type": "mascot_hook",
                    "config": {
                        "mascot_id": "lion",
                        "greeting_text": f"Chào bé! Cùng khám phá {lesson.title} nhé!",
                        "action_cta": "Bắt đầu nào!",
                    },
                },
                {
                    "step_order": 2,
                    "stage_5e": "explore",
                    "type": "interactive_explore",
                    "config": {
                        "instruction": f"Quan sát và chạm mở các bí mật trong {lesson.title}",
                    },
                },
                {
                    "step_order": 3,
                    "stage_5e": "explain",
                    "type": "concept_card_3d",
                    "config": {
                        "title": lesson.title,
                        "key_takeaways": ["Khám phá kiến thức mới", "Rèn luyện tư duy"],
                    },
                },
                {
                    "step_order": 4,
                    "stage_5e": "elaborate",
                    "type": "tactile_mini_game",
                    "config": {
                        "mechanic": "clay_bubble_popper",
                        "instruction": "Chạm bóng để hoàn thành thử thách!",
                    },
                },
                {
                    "step_order": 5,
                    "stage_5e": "evaluate",
                    "type": "celebration_summary",
                    "config": {
                        "motivational_quote": "Bé thật thông minh và xuất sắc!",
                    },
                },
            ],
        }

    async def complete_lesson(
        self,
        user_id_str: str,
        lesson_id: str,
        score: int = 100,
        stars_earned: int = 10,
    ) -> LessonCompleteResponse:
        lesson = await self.repo.get_lesson_by_id(lesson_id)
        if not lesson:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Bài học không tồn tại",
            )

        user_id = uuid.UUID(user_id_str)
        profile = await self.repo.get_kid_profile_by_user_id(user_id)

        if profile:
            profile.star_points += stars_earned
            profile.streak_days += 1
            total_stars = profile.star_points
            streak_days = profile.streak_days
        else:
            total_stars = stars_earned
            streak_days = 1

        await self.repo.record_lesson_progress(
            user_id=user_id,
            lesson_id=lesson_id,
            score=score,
            stars_earned=stars_earned,
        )
        await self.repo.db.commit()

        return LessonCompleteResponse(
            status="success",
            lesson_id=lesson_id,
            stars_earned=stars_earned,
            total_stars=total_stars,
            streak_days=streak_days,
        )
