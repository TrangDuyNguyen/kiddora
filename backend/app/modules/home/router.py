"""
Module Home — Router Endpoints
"""
from typing import Optional
from fastapi import APIRouter, Depends
from fastapi.security import HTTPAuthorizationCredentials, HTTPBearer
from jose import JWTError, jwt
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.config import settings
from app.core.deps import get_db, security_scheme
from app.modules.home.schemas import HomeDashboardSummaryResponse
from app.modules.home.service import HomeService

router = APIRouter(prefix="/home", tags=["Home"])


async def get_optional_user_id(
    credentials: Optional[HTTPAuthorizationCredentials] = Depends(security_scheme),
) -> Optional[str]:
    """Trích xuất user_id nếu có token hợp lệ, nếu không trả về None (cho phép Guest)"""
    if not credentials:
        return None
    try:
        payload = jwt.decode(
            credentials.credentials, settings.JWT_SECRET_KEY, algorithms=[settings.JWT_ALGORITHM]
        )
        return payload.get("sub")
    except JWTError:
        return None


@router.get("/summary", response_model=HomeDashboardSummaryResponse)
async def get_home_summary(
    user_id: Optional[str] = Depends(get_optional_user_id),
    db: AsyncSession = Depends(get_db),
):
    """Lấy dữ liệu tổng hợp cho màn hình Student Home Dashboard (Cold start < 50ms)"""
    service = HomeService(db)
    return await service.get_home_summary(user_id_str=user_id)

