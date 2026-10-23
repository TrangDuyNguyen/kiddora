"""
Kiddora Backend — FastAPI Entry Point (Feature-First Clean Architecture)
"""
from contextlib import asynccontextmanager
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.core.database import engine, Base
from app.modules.auth.router import router as auth_router
from app.modules.courses.router import router as courses_router
from app.modules.classroom.router import router as classroom_router
from app.modules.gamification.router import router as gamification_router
from app.modules.storage.router import router as storage_router


@asynccontextmanager
async def lifespan(app: FastAPI):
    # Khởi tạo các bảng DB nếu chưa có (trong môi trường dev)
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)
    yield
    # Cleanup khi shutdown server
    await engine.dispose()


app = FastAPI(
    title="Kiddora API",
    description="Backend API cho ứng dụng học tập tương tác Kiddora (Feature-First Architecture)",
    version="0.4.0",
    docs_url="/docs",       # Swagger UI interactive documentation
    redoc_url="/redoc",     # ReDoc documentation
    lifespan=lifespan,
)

# CORS Middleware (Cho phép Flutter Web & Mobile gọi API cục bộ)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/health", tags=["Health"])
async def health_check():
    """Health check endpoint cho container orchestrator & uptime monitoring"""
    return {
        "status": "healthy",
        "service": "kiddora-api",
        "version": "0.4.0",
        "architecture": "Feature-First Modular Monolith",
    }


# ── Mount Feature Modules (API v1) ──────────────────────────
API_V1_PREFIX = "/api/v1"

app.include_router(auth_router, prefix=API_V1_PREFIX)
app.include_router(courses_router, prefix=API_V1_PREFIX)
app.include_router(classroom_router, prefix=API_V1_PREFIX)
app.include_router(gamification_router, prefix=API_V1_PREFIX)
app.include_router(storage_router, prefix=API_V1_PREFIX)
