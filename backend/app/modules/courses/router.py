"""
Module Courses & Lessons — Router Endpoints
"""
from typing import List, Optional
from fastapi import APIRouter, Depends, Query
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.deps import get_db, get_current_user_id
from app.modules.courses.schemas import (
    CourseCardResponse,
    CourseDetailResponse,
    LessonCompleteRequest,
    LessonCompleteResponse,
)
from app.modules.courses.service import CourseService

router = APIRouter(prefix="/courses", tags=["Courses"])
lessons_router = APIRouter(prefix="/lessons", tags=["Lessons"])


@router.get("", response_model=List[CourseCardResponse])
async def list_courses(
    category: Optional[str] = Query(None, description="Lọc theo môn: math, science, arts, language, technology"),
    age: Optional[int] = Query(None, description="Lọc theo độ tuổi bé (6-12)"),
    min_age: Optional[int] = Query(None, description="Lọc theo tuổi tối thiểu (7, 9, 11)"),
    max_age: Optional[int] = Query(None, description="Lọc theo tuổi tối đa (8, 10, 12)"),
    level: Optional[str] = Query(None, description="Lọc theo cấp độ: beginner, intermediate, advanced"),
    duration: Optional[str] = Query(None, description="Lọc theo thời lượng: short, medium, long"),
    search: Optional[str] = Query(None, description="Tìm kiếm theo tiêu đề khóa học"),
    db: AsyncSession = Depends(get_db),
):
    """Lấy danh sách khóa học (dành cho màn hình Courses Hub, Search, Filter & All Courses Grid)"""
    service = CourseService(db)
    return await service.get_courses(
        category=category,
        age=age,
        min_age=min_age,
        max_age=max_age,
        level=level,
        duration=duration,
        search=search,
    )


@router.get("/{course_id}", response_model=CourseDetailResponse)
async def get_course_detail(
    course_id: str,
    db: AsyncSession = Depends(get_db),
):
    """Lấy thông tin chi tiết khóa học kèm danh sách bài giảng (dành cho màn hình Course Detail)"""
    service = CourseService(db)
    return await service.get_course_detail(course_id)


# ── Lessons Endpoints (5E Engine & Progress Sync) ───────────

@lessons_router.get("/{lesson_id}/blueprint")
@router.get("/lessons/{lesson_id}/blueprint")
async def get_lesson_blueprint(
    lesson_id: str,
    db: AsyncSession = Depends(get_db),
):
    """Lấy kịch bản bài học chuẩn 5E DSL để nạp vào Lesson Player"""
    service = CourseService(db)
    return await service.get_lesson_blueprint(lesson_id)


@lessons_router.post("/{lesson_id}/complete", response_model=LessonCompleteResponse)
@router.post("/lessons/{lesson_id}/complete", response_model=LessonCompleteResponse)
async def complete_lesson(
    lesson_id: str,
    req: LessonCompleteRequest,
    user_id: str = Depends(get_current_user_id),
    db: AsyncSession = Depends(get_db),
):
    """Ghi nhận hoàn thành bài học, thưởng +10 sao và cập nhật chuỗi streak"""
    service = CourseService(db)
    return await service.complete_lesson(
        user_id_str=user_id,
        lesson_id=lesson_id,
        score=req.score,
        stars_earned=req.stars_earned,
    )
