"""
Module Classroom — Service Logic
"""
from datetime import timedelta
from livekit import api
from app.core.config import settings
from app.modules.classroom.schemas import JoinRoomTokenResponse


class ClassroomService:
    @staticmethod
    def resolve_public_url(request_host: str | None = None) -> str:
        if settings.LIVEKIT_PUBLIC_URL.strip():
            return settings.LIVEKIT_PUBLIC_URL.strip()
        if request_host and request_host not in ("test", "livekit"):
            scheme = "wss" if settings.LIVEKIT_URL.startswith("wss://") else "ws"
            port = settings.LIVEKIT_URL.rsplit(":", 1)[-1] if ":" in settings.LIVEKIT_URL.split("//")[-1] else "7880"
            return f"{scheme}://{request_host}:{port}"
        return settings.LIVEKIT_URL

    @classmethod
    def generate_token(
        cls,
        room_name: str,
        participant_identity: str,
        participant_name: str,
        request_host: str | None = None,
    ) -> JoinRoomTokenResponse:
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
            server_url=cls.resolve_public_url(request_host),
        )
