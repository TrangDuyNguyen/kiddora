"""
Module Classroom — Service Logic
"""
from datetime import timedelta
from livekit import api
from app.core.config import settings
from app.modules.classroom.schemas import JoinRoomTokenResponse


class ClassroomService:
    @staticmethod
    def generate_token(room_name: str, participant_identity: str, participant_name: str) -> JoinRoomTokenResponse:
        """Tạo LiveKit Access Token cho học sinh/giáo viên tham gia phiên học trực tiếp"""
        token = (
            api.AccessToken(settings.LIVEKIT_API_KEY, settings.LIVEKIT_API_SECRET)
            .with_identity(participant_identity)
            .with_name(participant_name)
            .with_grants(
                api.VideoGrants(
                    room_join=True,
                    room=room_name,
                    can_publish=True,
                    can_subscribe=True,
                )
            )
            .with_ttl(timedelta(hours=2))
            .to_jwt()
        )

        return JoinRoomTokenResponse(
            room_name=room_name,
            participant_name=participant_name,
            token=token,
            server_url=settings.LIVEKIT_URL,
        )
