"""
Module Classroom — Schemas (DTOs)
"""
from datetime import datetime
from typing import Optional
from pydantic import BaseModel, ConfigDict


class LiveSessionCardResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: str
    title: str
    coach_name: str
    coach_avatar: Optional[str] = None
    scheduled_at: datetime
    duration_mins: int
    status: str
    participant_count: int = 0


class JoinRoomTokenResponse(BaseModel):
    room_name: str
    participant_name: str
    token: str
    server_url: str
