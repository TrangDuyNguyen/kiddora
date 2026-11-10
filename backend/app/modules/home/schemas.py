"""
Module Home — Schemas (DTOs) for Home Dashboard Summary
"""
from typing import Optional
from pydantic import BaseModel, ConfigDict


class KidProfileSummary(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    nickname: str = "Chay"
    mascot_id: str = "zodiac_dragon"
    avatar_asset: str = "assets/images/zodiac_dragon.png"
    star_points: int = 120
    streak_days: int = 5


class HomeStats(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    active_courses_count: int = 3
    upcoming_sessions_count: int = 1
    earned_badges_count: int = 5
    progress_percentage: int = 60


class ContinueLearningSummary(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    course_id: str = "c-science-01"
    course_title: str = "Amazing Animals"
    subject_name: str = "Science"
    thumbnail_asset: str = "assets/images/course_dino.png"
    next_lesson_id: str = "les-animal-01"
    next_lesson_title: str = "Meet the Animals"
    completed_lessons: int = 3
    total_lessons: int = 5
    progress_percentage: float = 0.6


class UpcomingSessionSummary(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    session_id: str = "sess-live-101"
    title: str = "Math Fun with Numbers"
    coach_name: str = "Coach Sarah"
    coach_avatar: str = "assets/images/avatar_coach_sarah.png"
    scheduled_time: str = "Today, 4:00 PM"
    status: str = "upcoming"


class HomeDashboardSummaryResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    kid_profile: KidProfileSummary
    stats: HomeStats
    continue_learning: ContinueLearningSummary
    upcoming_session: UpcomingSessionSummary
    unread_notifications_count: int = 3

