from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    DATABASE_URL: str = "postgresql+asyncpg://kiddora:kiddora_secret@db:5432/kiddora"
    REDIS_URL: str = "redis://redis:6379/0"

    MINIO_ENDPOINT: str = "minio:9000"
    MINIO_PUBLIC_ENDPOINT: str = ""
    MINIO_ACCESS_KEY: str = "minioadmin"
    MINIO_SECRET_KEY: str = "minioadmin123"
    MINIO_BUCKET_NAME: str = "kiddora-storage"
    MINIO_USE_SSL: bool = False

    LIVEKIT_URL: str = "ws://livekit:7880"
    LIVEKIT_PUBLIC_URL: str = ""
    LIVEKIT_API_KEY: str = "devkey"
    LIVEKIT_API_SECRET: str = "devsecret"

    JWT_SECRET_KEY: str = "CHANGE_THIS_IN_PRODUCTION_VERY_LONG_RANDOM_STRING"
    JWT_ALGORITHM: str = "HS256"
    JWT_ACCESS_TOKEN_EXPIRE_MINUTES: int = 60 * 24 * 7  # 7 days for mobile session stability
    JWT_REFRESH_TOKEN_EXPIRE_DAYS: int = 30

    APP_ENV: str = "development"
    APP_HOST: str = "0.0.0.0"
    APP_PORT: int = 8000

    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding="utf-8",
        extra="ignore",
    )


settings = Settings()
