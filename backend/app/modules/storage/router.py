"""
Module Storage — MinIO / S3 Client Service & Router
"""
from pathlib import PurePath
import json
import boto3
from botocore.client import Config
from botocore.exceptions import ClientError
from fastapi import APIRouter, HTTPException, Query, Request, status
from pydantic import BaseModel

from app.core.config import settings

ALLOWED_FOLDERS = {"lessons", "thumbnails", "avatars", "badges", "rewards"}


class PresignedUrlResponse(BaseModel):
    upload_url: str
    file_key: str
    download_url: str


class StorageService:
    @staticmethod
    def _scheme() -> str:
        return "https" if settings.MINIO_USE_SSL else "http"

    @classmethod
    def resolve_public_endpoint(cls, request_host: str | None = None) -> str:
        if settings.MINIO_PUBLIC_ENDPOINT.strip():
            return settings.MINIO_PUBLIC_ENDPOINT.strip()
        if request_host and request_host not in ("test", "minio"):
            port = settings.MINIO_ENDPOINT.split(":")[-1] if ":" in settings.MINIO_ENDPOINT else "9000"
            return f"{request_host}:{port}"
        return settings.MINIO_ENDPOINT

    @classmethod
    def get_s3_client(cls, endpoint: str | None = None):
        target = endpoint or settings.MINIO_ENDPOINT
        return boto3.client(
            "s3",
            endpoint_url=f"{cls._scheme()}://{target}",
            aws_access_key_id=settings.MINIO_ACCESS_KEY,
            aws_secret_access_key=settings.MINIO_SECRET_KEY,
            config=Config(signature_version="s3v4"),
            region_name="us-east-1",
        )

    @classmethod
    def ensure_bucket_exists(cls) -> None:
        """Khởi tạo bucket mặc định trên MinIO và cấp quyền đọc file tĩnh cho bài học/avatar"""
        s3 = cls.get_s3_client(settings.MINIO_ENDPOINT)
        bucket = settings.MINIO_BUCKET_NAME
        try:
            s3.head_bucket(Bucket=bucket)
        except ClientError:
            s3.create_bucket(Bucket=bucket)
            policy = {
                "Version": "2012-10-17",
                "Statement": [
                    {
                        "Effect": "Allow",
                        "Principal": {"AWS": ["*"]},
                        "Action": ["s3:GetObject"],
                        "Resource": [f"arn:aws:s3:::{bucket}/*"],
                    }
                ],
            }
            s3.put_bucket_policy(Bucket=bucket, Policy=json.dumps(policy))

    @classmethod
    def generate_presigned_upload_url(
        cls,
        folder: str,
        filename: str,
        request_host: str | None = None,
    ) -> PresignedUrlResponse:
        """Tạo URL tạm thời ký chuẩn S3v4 theo đúng IP/Domain máy chủ mà Client đang gọi tới"""
        public_endpoint = cls.resolve_public_endpoint(request_host)
        s3 = cls.get_s3_client(public_endpoint)
        file_key = f"{folder}/{filename}"
        url = s3.generate_presigned_url(
            ClientMethod="put_object",
            Params={"Bucket": settings.MINIO_BUCKET_NAME, "Key": file_key},
            ExpiresIn=3600,
        )
        download_url = f"{cls._scheme()}://{public_endpoint}/{settings.MINIO_BUCKET_NAME}/{file_key}"
        return PresignedUrlResponse(
            upload_url=url,
            file_key=file_key,
            download_url=download_url,
        )


router = APIRouter(prefix="/storage", tags=["Storage"])


@router.post("/presigned-upload", response_model=PresignedUrlResponse)
async def get_presigned_upload_url(
    request: Request,
    folder: str = Query("lessons", description="Thư mục: lessons, thumbnails, avatars"),
    filename: str = Query(..., description="Tên file upload kèm đuôi"),
):
    """Cấp presigned URL để tải file trực tiếp lên MinIO S3 mà không làm nghẽn API"""
    clean_folder = folder.strip().lower()
    if clean_folder not in ALLOWED_FOLDERS:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=f"Thư mục không hợp lệ. Chỉ cho phép: {', '.join(sorted(ALLOWED_FOLDERS))}",
        )
    clean_filename = PurePath(filename).name
    if not clean_filename or clean_filename.startswith("."):
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Tên tệp không hợp lệ",
        )
    return StorageService.generate_presigned_upload_url(
        folder=clean_folder,
        filename=clean_filename,
        request_host=request.url.hostname,
    )
