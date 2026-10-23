"""
Module Courses — Router Endpoints
"""
from typing import List, Optional
from fastapi import APIRouter, Depends, Query
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.deps import get_db
from app.modules.courses.schemas import CourseCardResponse, CourseDetailResponse
from app.modules.courses.service import CourseService

router = APIRouter(prefix="/courses", tags=["Courses"])


@router.get("", response_model=List[CourseCardResponse])
async def list_courses(
    category: Optional[str] = Query(None, description="Lọc theo môn: math, science, arts, language"),
    age: Optional[int] = Query(None, description="Lọc theo độ tuổi bé (6-12)"),
    search: Optional[str] = Query(None, description="Tìm kiếm theo tiêu đề khóa học"),
    db: AsyncSession = Depends(get_db),
):
    """Lấy danh sách khóa học (dành cho màn hình Courses Hub & Home Popular Courses)"""
    service = CourseService(db)
    return await service.get_courses(category=category, age=age, search=search)


@router.get("/{course_id}", response_model=CourseDetailResponse)
async def get_course_detail(
    course_id: str,
    db: AsyncSession = Depends(get_db),
):
    """Lấy thông tin chi tiết khóa học kèm danh sách bài giảng (dành cho màn hình Course Detail)"""
    service = CourseService(db)
    return await service.get_course_detail(course_id)
