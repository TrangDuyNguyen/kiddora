"""
Unit & Integration Tests for Module Courses (FastAPI)
"""
from unittest.mock import AsyncMock, MagicMock
import pytest
from httpx import ASGITransport, AsyncClient

from app.main import app
from app.core.deps import get_db
from app.modules.courses.models import Course, Lesson


def create_sample_courses():
    l1 = Lesson(
        id="lesson_anim_01",
        course_id="course_amazing_animals",
        order_index=1,
        title="Meet the Animals",
        duration_mins=10,
        thumbnail_url="assets/images/avatar_lion.png",
        video_url=None,
        is_unlocked=True,
        is_completed=True,
    )
    l2 = Lesson(
        id="lesson_anim_02",
        course_id="course_amazing_animals",
        order_index=2,
        title="Animals and Their Habitats",
        duration_mins=12,
        thumbnail_url="assets/images/avatar_bear.png",
        video_url=None,
        is_unlocked=True,
        is_completed=False,
    )
    c1 = Course(
        id="course_amazing_animals",
        title="Amazing Animals",
        subtitle="Discover the wonderful world of animals!",
        description="Join us on an exciting journey to learn about animals.",
        category="science",
        min_age=7,
        max_age=10,
        level="beginner",
        rating=4.8,
        review_count=320,
        thumbnail_url="assets/images/course_dino.png",
        is_featured=True,
    )
    c1.lessons = [l1, l2]

    c2 = Course(
        id="course_space_exploration",
        title="Space Exploration",
        subtitle="Blast off into outer space!",
        description="Explore planets, stars, rockets, and astronauts.",
        category="science",
        min_age=8,
        max_age=12,
        level="intermediate",
        rating=4.9,
        review_count=215,
        thumbnail_url="assets/images/mascot_star_goal.png",
        is_featured=True,
    )
    c2.lessons = [
        Lesson(id=f"l_space_{i}", course_id="course_space_exploration", order_index=i, title=f"Space {i}", duration_mins=10)
        for i in range(1, 7)
    ]

    return [c1, c2]


@pytest.mark.asyncio
async def test_list_courses():
    sample_courses = create_sample_courses()
    mock_db = AsyncMock()
    mock_result = MagicMock()
    mock_result.scalars.return_value.all.return_value = sample_courses
    mock_db.execute.return_value = mock_result

    app.dependency_overrides[get_db] = lambda: mock_db

    transport = ASGITransport(app=app)
    async with AsyncClient(transport=transport, base_url="http://test") as client:
        res = await client.get("/api/v1/courses")
        assert res.status_code == 200
        data = res.json()
        assert len(data) == 2
        assert data[0]["id"] == "course_amazing_animals"
        assert data[0]["title"] == "Amazing Animals"
        assert data[0]["category"] == "science"
        assert data[0]["total_lessons"] == 2
        assert data[0]["level"] == "beginner"

    app.dependency_overrides.clear()


@pytest.mark.asyncio
async def test_list_courses_with_query_params():
    sample_courses = create_sample_courses()
    mock_db = AsyncMock()
    mock_result = MagicMock()
    mock_result.scalars.return_value.all.return_value = [sample_courses[0]]
    mock_db.execute.return_value = mock_result

    app.dependency_overrides[get_db] = lambda: mock_db

    transport = ASGITransport(app=app)
    async with AsyncClient(transport=transport, base_url="http://test") as client:
        res = await client.get("/api/v1/courses?category=science&min_age=7&max_age=8&level=beginner&search=Animals")
        assert res.status_code == 200
        data = res.json()
        assert len(data) == 1
        assert data[0]["id"] == "course_amazing_animals"

    app.dependency_overrides.clear()


@pytest.mark.asyncio
async def test_get_course_detail_success():
    sample_courses = create_sample_courses()
    mock_db = AsyncMock()
    mock_result = MagicMock()
    mock_result.scalars.return_value.first.return_value = sample_courses[0]
    mock_db.execute.return_value = mock_result

    app.dependency_overrides[get_db] = lambda: mock_db

    transport = ASGITransport(app=app)
    async with AsyncClient(transport=transport, base_url="http://test") as client:
        res = await client.get("/api/v1/courses/course_amazing_animals")
        assert res.status_code == 200
        data = res.json()
        assert data["id"] == "course_amazing_animals"
        assert data["title"] == "Amazing Animals"
        assert data["subtitle"] == "Discover the wonderful world of animals!"
        assert len(data["lessons"]) == 2
        assert data["lessons"][0]["title"] == "Meet the Animals"
        assert data["lessons"][0]["is_completed"] is True
        assert data["lessons"][0]["is_unlocked"] is True
        assert data["lessons"][1]["is_completed"] is False
        assert data["lessons"][1]["is_unlocked"] is True

    app.dependency_overrides.clear()


@pytest.mark.asyncio
async def test_get_course_detail_not_found():
    mock_db = AsyncMock()
    mock_result = MagicMock()
    mock_result.scalars.return_value.first.return_value = None
    mock_db.execute.return_value = mock_result

    app.dependency_overrides[get_db] = lambda: mock_db

    transport = ASGITransport(app=app)
    async with AsyncClient(transport=transport, base_url="http://test") as client:
        res = await client.get("/api/v1/courses/course_non_existent")
        assert res.status_code == 404
        data = res.json()
        assert data["detail"] == "Khóa học không tồn tại"

    app.dependency_overrides.clear()

