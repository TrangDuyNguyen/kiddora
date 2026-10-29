"""
Kiddora Backend — Remote Client (LAN & Tailscale) Dynamic Endpoint Resolution Tests
"""
import pytest
from httpx import ASGITransport, AsyncClient

from app.core.config import settings
from app.main import app
from app.modules.classroom.service import ClassroomService
from app.modules.storage.router import StorageService


@pytest.mark.asyncio
async def test_presigned_upload_resolves_lan_host(monkeypatch):
    monkeypatch.setattr(settings, "MINIO_PUBLIC_ENDPOINT", "")
    bucket = settings.MINIO_BUCKET_NAME
    transport = ASGITransport(app=app)
    async with AsyncClient(transport=transport, base_url="http://192.168.3.119:8000") as client:
        response = await client.post(
            "/api/v1/storage/presigned-upload",
            params={"folder": "avatars", "filename": "kid-clay.png"},
        )
        assert response.status_code == 200
        data = response.json()
        assert data["file_key"] == "avatars/kid-clay.png"
        assert data["upload_url"].startswith(f"http://192.168.3.119:9000/{bucket}/avatars/kid-clay.png?")
        assert data["download_url"] == f"http://192.168.3.119:9000/{bucket}/avatars/kid-clay.png"


@pytest.mark.asyncio
async def test_presigned_upload_resolves_tailscale_host(monkeypatch):
    monkeypatch.setattr(settings, "MINIO_PUBLIC_ENDPOINT", "")
    bucket = settings.MINIO_BUCKET_NAME
    transport = ASGITransport(app=app)
    async with AsyncClient(transport=transport, base_url="http://100.88.12.34:8000") as client:
        response = await client.post(
            "/api/v1/storage/presigned-upload",
            params={"folder": "lessons", "filename": "math-quest.mp4"},
        )
        assert response.status_code == 200
        data = response.json()
        assert data["upload_url"].startswith(f"http://100.88.12.34:9000/{bucket}/lessons/math-quest.mp4?")
        assert data["download_url"] == f"http://100.88.12.34:9000/{bucket}/lessons/math-quest.mp4"


@pytest.mark.asyncio
async def test_presigned_upload_rejects_invalid_folder():
    transport = ASGITransport(app=app)
    async with AsyncClient(transport=transport, base_url="http://127.0.0.1:8000") as client:
        response = await client.post(
            "/api/v1/storage/presigned-upload",
            params={"folder": "system_secrets", "filename": "hack.txt"},
        )
        assert response.status_code == 400
        assert "Thư mục không hợp lệ" in response.json()["detail"]


@pytest.mark.asyncio
async def test_presigned_upload_sanitizes_path_traversal():
    transport = ASGITransport(app=app)
    async with AsyncClient(transport=transport, base_url="http://127.0.0.1:8000") as client:
        response = await client.post(
            "/api/v1/storage/presigned-upload",
            params={"folder": "avatars", "filename": "../../etc/passwd"},
        )
        assert response.status_code == 200
        data = response.json()
        assert data["file_key"] == "avatars/passwd"


def test_storage_explicit_public_endpoint_override(monkeypatch):
    monkeypatch.setattr(settings, "MINIO_PUBLIC_ENDPOINT", "cdn.kiddora.vn:9000")
    assert StorageService.resolve_public_endpoint("192.168.3.119") == "cdn.kiddora.vn:9000"


def test_classroom_livekit_dynamic_host_resolution(monkeypatch):
    monkeypatch.setattr(settings, "LIVEKIT_PUBLIC_URL", "")
    monkeypatch.setattr(settings, "LIVEKIT_URL", "ws://livekit:7880")

    assert ClassroomService.resolve_public_url("192.168.3.119") == "ws://192.168.3.119:7880"
    assert ClassroomService.resolve_public_url("desktop-ghcs3nb") == "ws://desktop-ghcs3nb:7880"
    assert ClassroomService.resolve_public_url("test") == "ws://livekit:7880"

    monkeypatch.setattr(settings, "LIVEKIT_PUBLIC_URL", "wss://live.kiddora.vn")
    assert ClassroomService.resolve_public_url("192.168.3.119") == "wss://live.kiddora.vn"
