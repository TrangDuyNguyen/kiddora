"""Lesson blueprint JSON and user progress tracking

Revision ID: 0003
Revises: 0002
Create Date: 2026-11-03 14:00:00.000000

"""
from typing import Sequence, Union
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql

revision: str = '0003'
down_revision: Union[str, None] = '0002'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    # 1. Thêm cột blueprint_json vào bảng lessons
    op.add_column(
        'lessons',
        sa.Column('blueprint_json', sa.JSON(), nullable=True),
    )

    # 2. Tạo bảng user_lesson_progress
    op.create_table(
        'user_lesson_progress',
        sa.Column('id', sa.Integer(), primary_key=True, autoincrement=True),
        sa.Column('user_id', postgresql.UUID(as_uuid=True), sa.ForeignKey('users.id', ondelete='CASCADE'), nullable=False),
        sa.Column('lesson_id', sa.String(length=50), sa.ForeignKey('lessons.id', ondelete='CASCADE'), nullable=False),
        sa.Column('is_completed', sa.Boolean(), server_default='false', nullable=False),
        sa.Column('score', sa.Integer(), server_default='0', nullable=False),
        sa.Column('stars_earned', sa.Integer(), server_default='0', nullable=False),
        sa.Column('completed_at', sa.DateTime(timezone=True), server_default=sa.text('CURRENT_TIMESTAMP'), nullable=False),
    )
    op.create_index(op.f('ix_user_lesson_progress_user_id'), 'user_lesson_progress', ['user_id'], unique=False)
    op.create_index(op.f('ix_user_lesson_progress_lesson_id'), 'user_lesson_progress', ['lesson_id'], unique=False)


def downgrade() -> None:
    op.drop_index(op.f('ix_user_lesson_progress_lesson_id'), table_name='user_lesson_progress')
    op.drop_index(op.f('ix_user_lesson_progress_user_id'), table_name='user_lesson_progress')
    op.drop_table('user_lesson_progress')
    op.drop_column('lessons', 'blueprint_json')

