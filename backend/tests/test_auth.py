"""
Unit & Integration Tests for Module Auth (FastAPI)
"""
import uuid
from unittest.mock import AsyncMock, MagicMock, patch
import pytest
from httpx import ASGITransport, AsyncClient

from app.main import app
from app.core.deps import get_db, get_current_user_id
from app.modules.auth.models import User, KidProfile
from app.core.security import get_password_hash


@pytest.fixture
def mock_db():
    db = AsyncMock()
    return db


@pytest.mark.asyncio
async def test_register_success():
    """Test đăng ký tài khoản Phụ huynh thành công"""
    mock_db = AsyncMock()
    mock_db.add = MagicMock()
    # Mock kiểm tra email trùng (trả về None -> email chưa có)
    mock_result = MagicMock()
    mock_result.scalars.return_value.first.return_value = None
    mock_db.execute.return_value = mock_result

    app.dependency_overrides[get_db] = lambda: mock_db

    transport = ASGITransport(app=app)
    async with AsyncClient(transport=transport, base_url="http://test") as client:
        res = await client.post(
            "/api/v1/auth/register",
            json={
                "email": "test_parent@kiddora.com",
                "password": "Password123!",
                "full_name": "Nguyen Van A"
            }
        )

        assert res.status_code == 200
        data = res.json()
        assert "access_token" in data
        assert "refresh_token" in data
        assert data["token_type"] == "bearer"
        assert data["user"]["email"] == "test_parent@kiddora.com"
        assert data["user"]["role"] == "parent"
        assert data["kid_profile"] is None

    app.dependency_overrides.clear()


@pytest.mark.asyncio
async def test_register_duplicate_email():
    """Test đăng ký email đã tồn tại -> 400 Bad Request"""
    mock_db = AsyncMock()
    existing_user = User(
        id=uuid.uuid4(),
        email="test_parent@kiddora.com",
        hashed_password="hash",
        role="parent"
    )
    mock_result = MagicMock()
    mock_result.scalars.return_value.first.return_value = existing_user
    mock_db.execute.return_value = mock_result

    app.dependency_overrides[get_db] = lambda: mock_db

    transport = ASGITransport(app=app)
    async with AsyncClient(transport=transport, base_url="http://test") as client:
        res = await client.post(
            "/api/v1/auth/register",
            json={
                "email": "test_parent@kiddora.com",
                "password": "Password123!",
                "full_name": "Nguyen Van A"
            }
        )

        assert res.status_code == 400
        assert "Email đã được sử dụng" in res.json()["detail"]

    app.dependency_overrides.clear()


@pytest.mark.asyncio
async def test_login_success():
    """Test đăng nhập thành công với mật khẩu đúng"""
    mock_db = AsyncMock()
    test_user_id = uuid.uuid4()
    test_user = User(
        id=test_user_id,
        email="parent@kiddora.com",
        hashed_password=get_password_hash("Password123!"),
        full_name="Parent Keil",
        role="parent",
    )
    test_user.profile = None

    mock_result = MagicMock()
    mock_result.scalars.return_value.first.return_value = test_user
    mock_db.execute.return_value = mock_result

    app.dependency_overrides[get_db] = lambda: mock_db

    transport = ASGITransport(app=app)
    async with AsyncClient(transport=transport, base_url="http://test") as client:
        res = await client.post(
            "/api/v1/auth/login",
            json={
                "email": "parent@kiddora.com",
                "password": "Password123!"
            }
        )

        assert res.status_code == 200
        data = res.json()
        assert "access_token" in data
        assert data["user"]["email"] == "parent@kiddora.com"

    app.dependency_overrides.clear()


@pytest.mark.asyncio
async def test_login_wrong_password():
    """Test đăng nhập sai mật khẩu -> 401 Unauthorized"""
    mock_db = AsyncMock()
    test_user = User(
        id=uuid.uuid4(),
        email="parent@kiddora.com",
        hashed_password=get_password_hash("CorrectPassword!"),
        role="parent",
    )
    mock_result = MagicMock()
    mock_result.scalars.return_value.first.return_value = test_user
    mock_db.execute.return_value = mock_result

    app.dependency_overrides[get_db] = lambda: mock_db

    transport = ASGITransport(app=app)
    async with AsyncClient(transport=transport, base_url="http://test") as client:
        res = await client.post(
            "/api/v1/auth/login",
            json={
                "email": "parent@kiddora.com",
                "password": "WrongPassword!"
            }
        )

        assert res.status_code == 401

    app.dependency_overrides.clear()


@pytest.mark.asyncio
async def test_create_kid_profile():
    """Test tạo hồ sơ bé với token phụ huynh"""
    mock_db = AsyncMock()
    mock_db.add = MagicMock()
    user_id = uuid.uuid4()

    # Giả lập chưa có profile
    mock_result = MagicMock()
    mock_result.scalars.return_value.first.return_value = None
    mock_db.execute.return_value = mock_result

    app.dependency_overrides[get_db] = lambda: mock_db
    app.dependency_overrides[get_current_user_id] = lambda: str(user_id)

    transport = ASGITransport(app=app)
    async with AsyncClient(transport=transport, base_url="http://test") as client:
        res = await client.post(
            "/api/v1/auth/kid-profile",
            json={
                "nickname": "Keil",
                "age": 8,
                "mascot_id": "zodiac_dragon"
            },
            headers={"Authorization": "Bearer mock_token"}
        )

        assert res.status_code == 200
        data = res.json()
        assert data["nickname"] == "Keil"
        assert data["age"] == 8
        assert data["mascot_id"] == "zodiac_dragon"
        assert data["star_points"] == 10
        assert data["streak_days"] == 1

    app.dependency_overrides.clear()
