"""
Kiddora Backend — Home Dashboard Summary Tests
"""
from unittest.mock import AsyncMock, MagicMock
import pytest
from httpx import ASGITransport, AsyncClient

from app.main import app
from app.core.deps import get_db


@pytest.mark.asyncio
async def test_get_home_summary_guest():
    mock_db = AsyncMock()
    mock_result = MagicMock()
    mock_result.scalars.return_value.all.return_value = []
    mock_result.scalar_one_or_none.return_value = None
    mock_db.execute.return_value = mock_result

    app.dependency_overrides[get_db] = lambda: mock_db

    transport = ASGITransport(app=app)
    async with AsyncClient(transport=transport, base_url="http://test") as client:
        response = await client.get("/api/v1/home/summary")
        assert response.status_code == 200
        data = response.json()
        assert "kid_profile" in data
        assert data["kid_profile"]["nickname"] == "Chay"
        assert "stats" in data
        assert "active_courses_count" in data["stats"]
        assert "continue_learning" in data
        assert data["continue_learning"]["course_title"] == "Amazing Animals"
        assert "upcoming_session" in data
        assert data["upcoming_session"]["coach_name"] == "Coach Sarah"
        assert data["unread_notifications_count"] == 3

    app.dependency_overrides.clear()
