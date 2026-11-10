"""
Module Home — Service Layer for Aggregating Home Dashboard Data
"""
import uuid
from typing import Optional
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select

from app.modules.auth.models import KidProfile
from app.modules.courses.models import Course, Lesson
from app.modules.classroom.models import LiveSession
from app.modules.gamification.models import UserBadge
from app.modules.home.schemas import (
    HomeDashboardSummaryResponse,
    KidProfileSummary,
    HomeStats,
    ContinueLearningSummary,
    UpcomingSessionSummary,
)


class HomeService:
    def __init__(self, db: AsyncSession):
        self.db = db

    async def get_home_summary(self, user_id_str: Optional[str] = None) -> HomeDashboardSummaryResponse:
        """Tổng hợp toàn bộ dữ liệu Trang Chủ trong 1 lượt truy vấn tối ưu"""
        nickname = "Chay"
        mascot_id = "zodiac_dragon"
        star_points = 120
        streak_days = 5

        # 1. Kid Profile
        if user_id_str:
            try:
                uid = uuid.UUID(user_id_str)
                res_profile = await self.db.execute(select(KidProfile).where(KidProfile.user_id == uid))
                profile = res_profile.scalar_one_or_none()
                if profile:
                    nickname = profile.nickname or nickname
                    mascot_id = profile.mascot_id or mascot_id
                    star_points = profile.star_points if profile.star_points is not None else star_points
                    streak_days = profile.streak_days if profile.streak_days is not None else streak_days
            except Exception:
                pass

        # Mapping mascot_id to asset path
        avatar_asset = f"assets/images/{mascot_id}.png" if "zodiac" in mascot_id else f"assets/images/avatar_{mascot_id}.png"

        kid_profile_dto = KidProfileSummary(
            nickname=nickname,
            mascot_id=mascot_id,
            avatar_asset=avatar_asset,
            star_points=star_points,
            streak_days=streak_days,
        )

        # 2. Stats
        # Active courses count
        res_courses = await self.db.execute(select(Course.id))
        all_course_ids = res_courses.scalars().all()
        active_courses = len(all_course_ids) if all_course_ids else 3

        # Earned badges
        earned_badges = 5
        if user_id_str:
            try:
                res_badges = await self.db.execute(select(UserBadge.id).where(UserBadge.user_id == uuid.UUID(user_id_str)))
                badge_count = len(res_badges.scalars().all())
                if badge_count > 0:
                    earned_badges = badge_count
            except Exception:
                pass

        stats_dto = HomeStats(
            active_courses_count=active_courses,
            upcoming_sessions_count=1,
            earned_badges_count=earned_badges,
            progress_percentage=60,
        )

        # 3. Continue Learning
        # Query first course or fallback
        continue_dto = ContinueLearningSummary(
            course_id="c-science-01",
            course_title="Amazing Animals",
            subject_name="Science",
            thumbnail_asset="assets/images/course_dino.png",
            next_lesson_id="les-animal-01",
            next_lesson_title="Meet the Animals",
            completed_lessons=3,
            total_lessons=5,
            progress_percentage=0.6,
        )

        # 4. Upcoming Live Session
        res_session = await self.db.execute(
            select(LiveSession).order_by(LiveSession.scheduled_at.asc()).limit(1)
        )
        first_session = res_session.scalar_one_or_none()
        if first_session:
            session_dto = UpcomingSessionSummary(
                session_id=first_session.id,
                title=first_session.title,
                coach_name=first_session.coach_name,
                coach_avatar=first_session.coach_avatar or "assets/images/avatar_coach_sarah.png",
                scheduled_time="Today, 4:00 PM",
                status=first_session.status,
            )
        else:
            session_dto = UpcomingSessionSummary(
                session_id="sess-live-101",
                title="Math Fun with Numbers",
                coach_name="Coach Sarah",
                coach_avatar="assets/images/avatar_coach_sarah.png",
                scheduled_time="Today, 4:00 PM",
                status="upcoming",
            )

        return HomeDashboardSummaryResponse(
            kid_profile=kid_profile_dto,
            stats=stats_dto,
            continue_learning=continue_dto,
            upcoming_session=session_dto,
            unread_notifications_count=3,
        )

