"""
Module Classroom — Router Endpoints
"""
from typing import List
from fastapi import APIRouter, Depends, Query, Request
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select

from app.core.deps import get_db, get_current_user_id
from app.modules.classroom.models import LiveSession
from app.modules.classroom.schemas import LiveSessionCardResponse, JoinRoomTokenResponse
from app.modules.classroom.service import ClassroomService

router = APIRouter(prefix="/classroom", tags=["Classroom"])


@router.get("/sessions", response_model=List[LiveSessionCardResponse])
async def list_sessions(db: AsyncSession = Depends(get_db)):
    """Lấy danh sách các phiên học trực tiếp sắp diễn ra hoặc đang live"""
    stmt = select(LiveSession).order_by(LiveSession.scheduled_at.asc())
    res = await db.execute(stmt)
    sessions = res.scalars().all()
    return [
        LiveSessionCardResponse(
            id=s.id,
            title=s.title,
            coach_name=s.coach_name,
            coach_avatar=s.coach_avatar,
            scheduled_at=s.scheduled_at,
            duration_mins=s.duration_mins,
            status=s.status,
            participant_count=0,
        )
        for s in sessions
    ]


@router.post("/sessions/{room_name}/token", response_model=JoinRoomTokenResponse)
async def get_join_token(
    request: Request,
    room_name: str,
    participant_name: str = Query("Student", description="Tên hiển thị trong phòng học"),
    user_id: str = Depends(get_current_user_id),
):
    """Cấp phát token WebRTC LiveKit để kết nối vào phòng học trực tiếp"""
    return ClassroomService.generate_token(
        room_name=room_name,
        participant_identity=user_id,
        participant_name=participant_name,
        request_host=request.url.hostname,
    )
