"""Courses and lessons tables and seed data

Revision ID: 0002
Revises: 0001
Create Date: 2026-10-30 10:00:00.000000

"""
from typing import Sequence, Union
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql

revision: str = '0002'
down_revision: Union[str, None] = '0001'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    # 1. Bảng courses
    courses_table = op.create_table(
        'courses',
        sa.Column('id', sa.String(length=50), primary_key=True),
        sa.Column('title', sa.String(length=200), nullable=False),
        sa.Column('subtitle', sa.String(length=300), nullable=True),
        sa.Column('description', sa.Text(), nullable=True),
        sa.Column('category', sa.String(length=50), nullable=False),
        sa.Column('min_age', sa.Integer(), server_default='6', nullable=False),
        sa.Column('max_age', sa.Integer(), server_default='12', nullable=False),
        sa.Column('level', sa.String(length=30), server_default='beginner', nullable=False),
        sa.Column('rating', sa.Float(), server_default='5.0', nullable=False),
        sa.Column('review_count', sa.Integer(), server_default='0', nullable=False),
        sa.Column('thumbnail_url', sa.String(length=500), nullable=True),
        sa.Column('is_featured', sa.Boolean(), server_default='false', nullable=False),
        sa.Column('coach_id', postgresql.UUID(as_uuid=True), sa.ForeignKey('users.id'), nullable=True),
        sa.Column('created_at', sa.DateTime(timezone=True), server_default=sa.text('CURRENT_TIMESTAMP'), nullable=False),
    )
    op.create_index(op.f('ix_courses_category'), 'courses', ['category'], unique=False)
    op.create_index(op.f('ix_courses_id'), 'courses', ['id'], unique=False)

    # 2. Bảng lessons
    lessons_table = op.create_table(
        'lessons',
        sa.Column('id', sa.String(length=50), primary_key=True),
        sa.Column('course_id', sa.String(length=50), sa.ForeignKey('courses.id', ondelete='CASCADE'), nullable=False),
        sa.Column('order_index', sa.Integer(), server_default='1', nullable=False),
        sa.Column('title', sa.String(length=200), nullable=False),
        sa.Column('duration_mins', sa.Integer(), server_default='10', nullable=False),
        sa.Column('thumbnail_url', sa.String(length=500), nullable=True),
        sa.Column('video_url', sa.String(length=500), nullable=True),
        sa.Column('is_unlocked', sa.Boolean(), server_default='false', nullable=False),
        sa.Column('is_completed', sa.Boolean(), server_default='false', nullable=False),
        sa.Column('created_at', sa.DateTime(timezone=True), server_default=sa.text('CURRENT_TIMESTAMP'), nullable=False),
    )
    op.create_index(op.f('ix_lessons_course_id'), 'lessons', ['course_id'], unique=False)
    op.create_index(op.f('ix_lessons_id'), 'lessons', ['id'], unique=False)

    # 3. Seed 6 Benchmark Courses
    op.bulk_insert(
        courses_table,
        [
            {
                "id": "course_amazing_animals",
                "title": "Amazing Animals",
                "subtitle": "Discover the wonderful world of animals and their habitats!",
                "description": "Join us on an exciting journey to learn about different animals, their habitats, and how they live in our amazing world. This course is designed to be fun, interactive, and easy to understand!",
                "category": "science",
                "min_age": 7,
                "max_age": 10,
                "level": "beginner",
                "rating": 4.8,
                "review_count": 320,
                "thumbnail_url": "assets/images/course_dino.png",
                "is_featured": True,
            },
            {
                "id": "course_space_exploration",
                "title": "Space Exploration",
                "subtitle": "Blast off into outer space to explore planets, stars, rockets, and astronauts!",
                "description": "Blast off into outer space to explore planets, stars, rockets, and astronauts in our solar system!",
                "category": "science",
                "min_age": 8,
                "max_age": 12,
                "level": "intermediate",
                "rating": 4.9,
                "review_count": 215,
                "thumbnail_url": "assets/images/mascot_star_goal.png",
                "is_featured": True,
            },
            {
                "id": "course_math_fun_numbers",
                "title": "Math Fun with Numbers",
                "subtitle": "Master mental math and playful number puzzles!",
                "description": "Master mental math, addition, subtraction, and fun number puzzles through interactive games!",
                "category": "math",
                "min_age": 7,
                "max_age": 10,
                "level": "beginner",
                "rating": 4.7,
                "review_count": 180,
                "thumbnail_url": "assets/images/mascot_boy_crown.png",
                "is_featured": True,
            },
            {
                "id": "course_creative_drawing",
                "title": "Creative Drawing",
                "subtitle": "Unleash your imagination with shapes, colors, and characters!",
                "description": "Unleash your imagination with shapes, colors, and step-by-step character drawing lessons!",
                "category": "arts",
                "min_age": 7,
                "max_age": 12,
                "level": "beginner",
                "rating": 4.8,
                "review_count": 145,
                "thumbnail_url": "assets/images/avatar_bunny.png",
                "is_featured": True,
            },
            {
                "id": "course_our_planet",
                "title": "Our Planet",
                "subtitle": "Discover oceans, continents, weather, and protect Earth!",
                "description": "Discover oceans, continents, weather, and how we can protect our beautiful Earth!",
                "category": "science",
                "min_age": 8,
                "max_age": 12,
                "level": "intermediate",
                "rating": 4.6,
                "review_count": 98,
                "thumbnail_url": "assets/images/zodiac_dragon.png",
                "is_featured": False,
            },
            {
                "id": "course_intro_technology",
                "title": "Intro to Technology",
                "subtitle": "Learn how computers, robots, and smart inventions work!",
                "description": "Learn how computers, robots, and smart inventions work in our daily lives!",
                "category": "technology",
                "min_age": 9,
                "max_age": 12,
                "level": "advanced",
                "rating": 4.9,
                "review_count": 260,
                "thumbnail_url": "assets/images/zodiac_monkey.png",
                "is_featured": False,
            },
        ],
    )

    # 4. Seed 5 Lessons cho course_amazing_animals
    op.bulk_insert(
        lessons_table,
        [
            {
                "id": "lesson_anim_01",
                "course_id": "course_amazing_animals",
                "order_index": 1,
                "title": "Meet the Animals",
                "duration_mins": 10,
                "thumbnail_url": "assets/images/avatar_lion.png",
                "is_unlocked": True,
                "is_completed": True,
            },
            {
                "id": "lesson_anim_02",
                "course_id": "course_amazing_animals",
                "order_index": 2,
                "title": "Animals and Their Habitats",
                "duration_mins": 12,
                "thumbnail_url": "assets/images/avatar_bear.png",
                "is_unlocked": True,
                "is_completed": False,
            },
            {
                "id": "lesson_anim_03",
                "course_id": "course_amazing_animals",
                "order_index": 3,
                "title": "Food and Eating Habits",
                "duration_mins": 10,
                "thumbnail_url": "assets/images/avatar_dino.png",
                "is_unlocked": False,
                "is_completed": False,
            },
            {
                "id": "lesson_anim_04",
                "course_id": "course_amazing_animals",
                "order_index": 4,
                "title": "Animal Life Cycles",
                "duration_mins": 15,
                "thumbnail_url": "assets/images/zodiac_dragon.png",
                "is_unlocked": False,
                "is_completed": False,
            },
            {
                "id": "lesson_anim_05",
                "course_id": "course_amazing_animals",
                "order_index": 5,
                "title": "How We Can Help",
                "duration_mins": 10,
                "thumbnail_url": "assets/images/avatar_bunny.png",
                "is_unlocked": False,
                "is_completed": False,
            },
        ],
    )


def downgrade() -> None:
    op.drop_table('lessons')
    op.drop_table('courses')

