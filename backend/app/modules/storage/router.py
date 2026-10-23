"""
Module Storage — MinIO / S3 Client Service & Router
"""
import boto3
from botocore.client import Config
from fastapi import APIRouter, Query
from pydantic import BaseModel

from app.core.config import settings


class PresignedUrlResponse(BaseModel):
    upload_url: str
    file_key: str
    download_url: str


class StorageService:
    @staticmethod
    def get_s3_client():
        return boto3.client(
            "s3",
            endpoint_url=f"http://{settings.MINIO_ENDPOINT}",
            aws_access_key_id=settings.MINIO_ACCESS_KEY,
            aws_secret_access_key=settings.MINIO_SECRET_KEY,
            config=Config(signature_version="s3v4"),
            region_name="us-east-1",
        )

    @classmethod
    def generate_presigned_upload_url(cls, folder: str, filename: str) -> PresignedUrlResponse:
        """Tạo URL tạm thời để client (Coach/Admin) upload video hoặc ảnh trực tiếp lên MinIO"""
        s3 = cls.get_s3_client()
        file_key = f"{folder}/{filename}"
        url = s3.generate_presigned_url(
            ClientMethod="put_object",
            Params={"Bucket": settings.MINIO_BUCKET_NAME, "Key": file_key},
            ExpiresIn=3600,
        )
        download_url = f"http://{settings.MINIO_ENDPOINT}/{settings.MINIO_BUCKET_NAME}/{file_key}"
        return PresignedUrlResponse(
            upload_url=url,
            file_key=file_key,
            download_url=download_url,
        )


router = APIRouter(prefix="/storage", tags=["Storage"])


@router.post("/presigned-upload", response_model=PresignedUrlResponse)
async def get_presigned_upload_url(
    folder: str = Query("lessons", description="Thư mục: lessons, thumbnails, avatars"),
    filename: str = Query(..., description="Tên file upload kèm đuôi"),
):
    """Cấp presigned URL để tải file trực tiếp lên MinIO S3 mà không làm nghẽn API"""
    return StorageService.generate_presigned_upload_url(folder, filename)
