# ADR-004: Backend Architecture — Professional Self-Hosted Stack

- **Ngày ban hành**: 2026-10-22
- **Trạng thái**: APPROVED
- **Người ban hành**: Sub-Agent Tech Lead "The Pragmatic System Architect"
- **Phê duyệt PO**: Pending sign-off
- **Áp dụng từ**: Sprint 4 (v0.4.0) và toàn bộ roadmap đến v1.0.0

---

## 1. Bối Cảnh & Động Lực (Context)

Kiddora cần Backend phục vụ 3 personas (Student, Parent, Coach) qua 60 màn hình trên 14 domain.

**Mục tiêu kép**:
1. Xây dựng hệ thống production-grade cho sản phẩm thực tế
2. Học BE/DevOps từ đầu theo lộ trình bài bản, chuyên nghiệp

**Ràng buộc đã xác định**:
- Không dùng Firebase hay BaaS thứ ba
- Self-host hoàn toàn trên localhost (dev) → VPS (production)
- Người phát triển có background Flutter/Dart, chưa có kinh nghiệm BE
- Chi phí giai đoạn dev/test: $0

---

## 2. Quyết Định (Decision)

**Chọn: FastAPI (Python) + PostgreSQL + Redis + MinIO + LiveKit + Caddy + FCM Direct API**

---

## 3. Kiến Trúc Tổng Thể

```
┌──────────────────────────────────────────────────────────────┐
│                      FLUTTER APP                             │
└──────┬──────────────────┬────────────────────┬──────────────┘
       │ HTTPS REST API    │ WebSocket           │ WebRTC Video
       ▼                   ▼                     ▼
┌────────────┐     ┌────────────────┐    ┌─────────────┐
│  FastAPI   │     │ FastAPI WS     │    │   LiveKit   │
│  (Python)  │     │ (Realtime Chat)│    │  (WebRTC)   │
│  Port 8000 │     │                │    │  Port 7880  │
└─────┬──────┘     └────────────────┘    └─────────────┘
      │
┌─────┴──────────────────────────────────┐
│                                        │
▼                                        ▼
┌─────────────┐                 ┌─────────────────┐
│ PostgreSQL  │                 │      Redis       │
│ (Database)  │                 │ Cache + Session  │
│ Port 5432   │                 │ + Job Queue      │
└─────────────┘                 │ Port 6379        │
                                └─────────────────┘
┌─────────────┐   ┌─────────────┐   ┌──────────────────┐
│    MinIO    │   │    Caddy    │   │  FCM HTTP API    │
│  (Storage)  │   │ (Proxy+SSL) │   │  (Push Notif)    │
│  Port 9000  │   │  Port 443   │   │  Google Server   │
└─────────────┘   └─────────────┘   └──────────────────┘

Tất cả chạy qua: docker compose up -d  (1 lệnh)
```

---

## 4. Bóc Tách Từng Service

### 4.1. FastAPI (Python) — API Server

**Vai trò**: Xử lý toàn bộ business logic — Auth, CRUD, grading, badge engine, realtime WS.

**Tại sao FastAPI**:
- Syntax đơn giản, gần với pseudocode — dễ học nhất trong các BE framework
- Async/await native — hiệu năng cao, phù hợp realtime
- Tự động sinh Swagger UI docs tại `/docs`
- Ecosystem AI/ML mạnh nhất (Python) — chuẩn bị cho tích hợp Gemini AI
- Được Netflix, Microsoft, Uber dùng trong production

**Thư viện chính**:
```
fastapi          → Framework chính
uvicorn          → ASGI server chạy FastAPI
sqlalchemy       → ORM — làm việc với PostgreSQL bằng Python code
alembic          → Migration — quản lý thay đổi database schema
pydantic         → Validation dữ liệu đầu vào (built-in với FastAPI)
python-jose      → JWT token cho Auth
passlib[bcrypt]  → Hash password an toàn
redis[asyncio]   → Redis client async
celery           → Background job worker (grading, badge, email)
httpx            → HTTP client để gọi FCM API, LiveKit API
livekit-api      → Tạo LiveKit token cho video session
boto3            → S3/MinIO client để upload/download file
```

**Cấu trúc thư mục (Feature-First Modular Monolith)**:
```
backend/
├── app/
│   ├── main.py               # Entry point FastAPI, mount routers, lifespan, CORS
│   ├── core/                 # Cross-Cutting Concerns (dùng chung toàn hệ thống)
│   │   ├── config.py         # Đọc .env bằng Pydantic Settings
│   │   ├── database.py       # Async SQLAlchemy engine & session maker
│   │   ├── security.py       # Passlib hash & JWT encode/decode
│   │   └── deps.py           # Dependency Injections (get_db, get_current_user)
│   ├── modules/              # FEATURE MODULES (Tương đồng 1:1 với Flutter features/)
│   │   ├── auth/             # Xác thực & tài khoản (Login, Register, Profile)
│   │   │   ├── models.py     # User, KidProfile
│   │   │   ├── schemas.py    # DTOs
│   │   │   ├── service.py    # Logic auth & JWT
│   │   │   └── router.py     # Endpoints /api/v1/auth
│   │   ├── courses/          # Khóa học & bài giảng (Sprint 4)
│   │   │   ├── models.py     # Course, Lesson, UserProgress
│   │   │   ├── schemas.py    # DTOs
│   │   │   ├── repository.py # Query DB
│   │   │   ├── service.py    # Logic lọc, tìm kiếm
│   │   │   └── router.py     # Endpoints /api/v1/courses
│   │   ├── classroom/        # Phòng học tương tác WebRTC (Sprint 5)
│   │   │   ├── models.py     # LiveSession
│   │   │   ├── schemas.py    # DTOs
│   │   │   ├── service.py    # LiveKit Token generation
│   │   │   └── router.py     # Endpoints /api/v1/classroom
│   │   ├── gamification/     # Huy hiệu & chuỗi học Streak (Sprint 7)
│   │   │   ├── models.py     # Badge, UserBadge
│   │   │   ├── schemas.py    # DTOs
│   │   │   └── router.py     # Endpoints /api/v1/gamification
│   │   └── storage/          # MinIO S3 media & video bài giảng
│   │       ├── service.py    # Boto3 client & presigned URLs
│   │       └── router.py     # Endpoints /api/v1/storage
│   └── workers/              # Celery background tasks & queue
│       └── celery_app.py     # Celery app instance
├── alembic/                  # Database migrations
├── tests/                    # Pytest unit + integration tests
├── .env                      # File biến môi trường local (đã gitignore)
├── .env.example              # File mẫu biến môi trường
├── Dockerfile                # Docker build cho FastAPI
└── requirements.txt          # Danh sách thư viện Python
```

---

### 4.2. PostgreSQL — Database Chính

**Vai trò**: Lưu toàn bộ dữ liệu có cấu trúc của hệ thống.

**Tại sao PostgreSQL**:
- Chuẩn công nghiệp — 90% startup chọn Postgres
- Hỗ trợ query phức tạp (JOIN, aggregation) cho analytics
- ACID compliant — không mất data
- Free, open source, mature 30+ năm

**Database Schema**:
```sql
-- Core entities (được định nghĩa bằng SQLAlchemy, không viết SQL thủ công)

users               → id, name, email, hashed_password, role, age, avatar_id, parent_id
courses             → id, title, subject, level, age_range, thumbnail_url, coach_id
lessons             → id, course_id, title, video_url, duration_sec, order_index
user_progress       → user_id, course_id, lesson_id, completed_at, overall_percent
live_sessions       → id, title, coach_id, scheduled_at, livekit_channel, status
session_participants → session_id, user_id, joined_at
quizzes             → id, course_id, title, duration_min, level
questions           → id, quiz_id, text, options (JSONB), correct_index
quiz_attempts       → id, user_id, quiz_id, answers (JSONB), score, completed_at
badges              → id, name, description, image_url, trigger_type, trigger_value
user_badges         → user_id, badge_id, earned_at
user_points         → user_id, total_points, updated_at
rewards             → id, title, category, points_cost, stock
notifications       → id, user_id, type, title, body, deep_link, read, created_at
```

---

### 4.3. Redis — Cache, Session & Queue

**Vai trò**: 3 việc song song:

```
Cache layer:
  key: "courses:list"  → value: JSON danh sách courses (TTL 5 phút)
  → Flutter nhận response nhanh, không đọc DB mỗi lần

Session store:
  key: "blacklist:jwt:{token}"  → khi user logout, token bị vô hiệu hóa
  key: "session:{userId}"       → thông tin session hiện tại

Job queue (via Celery):
  quiz_submitted  → worker grade → award badge → gửi push notification
  lesson_complete → worker update streak → check badge triggers
```

---

### 4.4. MinIO — File Storage (S3 Self-Hosted)

**Vai trò**: Lưu và serve tất cả binary files — video, ảnh, avatar.

**Tại sao MinIO**:
- Tương thích 100% với AWS S3 API → sau này migrate lên S3 thật dễ dàng
- File được serve qua URL riêng — Flutter stream video trực tiếp từ MinIO, không qua FastAPI
- Free, open source

**Bucket structure**:
```
kiddora-storage/
├── lessons/          → video bài giảng (MP4, HLS segments)
├── thumbnails/       → ảnh thumbnail khóa học, bài học
├── avatars/          → ảnh avatar user, mascot 3D
├── badges/           → ảnh badge PNG
└── rewards/          → ảnh phần thưởng
```

---

### 4.5. LiveKit — Live Video Classroom

**Vai trò**: WebRTC server xử lý live video stream cho Domain 07.

**Luồng hoạt động**:
```
Student mở session
  → Flutter gọi POST /sessions/{id}/join (FastAPI)
  → FastAPI gọi LiveKit API → sinh JWT token (expire 1h)
  → Flutter nhận token → livekit_client.connect(url, token)
  → Video Coach stream vào Flutter qua LiveKit server
  → Chat/Q&A qua LiveKit DataChannel (không cần Agora RTM)
```

**Tại sao LiveKit**:
- Open source, self-host hoàn toàn
- Được viết bằng Go → hiệu năng cao, RAM thấp
- Flutter SDK `livekit_client` chính thức và được maintain tốt
- Hỗ trợ SFU (Selective Forwarding Unit) — scale tốt

---

### 4.6. Caddy — Reverse Proxy & SSL

**Vai trò**: Nhận toàn bộ traffic từ ngoài, phân phối đúng service, tự động HTTPS.

**Cấu hình** (Caddyfile — đơn giản hơn Nginx 10 lần):
```
kiddora.yourdomain.com {
    route /api/* {
        reverse_proxy api:8000
    }
    route /storage/* {
        reverse_proxy minio:9000
    }
    route /livekit/* {
        reverse_proxy livekit:7880
    }
}
```

---

### 4.7. FCM Direct HTTP API — Push Notifications

**Vai trò**: Gửi push notification đến iOS/Android — không cần Firebase SDK, chỉ gọi HTTP.

```python
# push_service.py
async def send_push(device_token: str, title: str, body: str):
    google_token = await get_google_access_token()  # OAuth2
    async with httpx.AsyncClient() as client:
        await client.post(
            f"https://fcm.googleapis.com/v1/projects/{PROJECT_ID}/messages:send",
            headers={"Authorization": f"Bearer {google_token}"},
            json={
                "message": {
                    "token": device_token,
                    "notification": {"title": title, "body": body},
                    "data": {"deep_link": "/sessions/123"}
                }
            }
        )
```

---

## 5. Docker Compose — Chạy Toàn Bộ Bằng 1 Lệnh

```yaml
# docker-compose.yml
version: "3.9"

services:

  # ── FastAPI Backend ──────────────────────────────────────
  api:
    build: ./backend
    ports:
      - "8000:8000"
    environment:
      DATABASE_URL: postgresql+asyncpg://kiddora:secret@db:5432/kiddora
      REDIS_URL: redis://redis:6379/0
      MINIO_ENDPOINT: minio:9000
      MINIO_ACCESS_KEY: minioadmin
      MINIO_SECRET_KEY: minioadmin
      LIVEKIT_URL: http://livekit:7880
      LIVEKIT_API_KEY: devkey
      LIVEKIT_API_SECRET: devsecret
      JWT_SECRET: your-super-secret-key-change-in-production
    depends_on:
      - db
      - redis
      - minio
    volumes:
      - ./backend:/app
    command: uvicorn app.main:app --reload --host 0.0.0.0 --port 8000

  # ── Celery Worker (Background Jobs) ─────────────────────
  worker:
    build: ./backend
    environment:
      DATABASE_URL: postgresql+asyncpg://kiddora:secret@db:5432/kiddora
      REDIS_URL: redis://redis:6379/0
    depends_on:
      - db
      - redis
    command: celery -A app.workers.celery_app worker --loglevel=info

  # ── PostgreSQL ───────────────────────────────────────────
  db:
    image: postgres:16-alpine
    ports:
      - "5432:5432"
    environment:
      POSTGRES_DB: kiddora
      POSTGRES_USER: kiddora
      POSTGRES_PASSWORD: secret
    volumes:
      - postgres_data:/var/lib/postgresql/data

  # ── Redis ────────────────────────────────────────────────
  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
    volumes:
      - redis_data:/data

  # ── MinIO (File Storage) ─────────────────────────────────
  minio:
    image: minio/minio:latest
    ports:
      - "9000:9000"   # API
      - "9001:9001"   # Admin UI → http://localhost:9001
    environment:
      MINIO_ROOT_USER: minioadmin
      MINIO_ROOT_PASSWORD: minioadmin
    volumes:
      - minio_data:/data
    command: server /data --console-address ":9001"

  # ── LiveKit (WebRTC Video) ───────────────────────────────
  livekit:
    image: livekit/livekit-server:latest
    ports:
      - "7880:7880"
      - "7881:7881"
      - "7882:7882/udp"
    command: --dev --bind 0.0.0.0

  # ── Caddy (Reverse Proxy) ────────────────────────────────
  # Chỉ cần trong production (khi deploy lên VPS)
  # caddy:
  #   image: caddy:2-alpine
  #   ports:
  #     - "80:80"
  #     - "443:443"
  #   volumes:
  #     - ./Caddyfile:/etc/caddy/Caddyfile

volumes:
  postgres_data:
  redis_data:
  minio_data:
```

**Khởi động toàn bộ hệ thống**:
```bash
docker compose up -d

# Kiểm tra:
# API docs   → http://localhost:8000/docs
# MinIO UI   → http://localhost:9001  (minioadmin/minioadmin)
# PostgreSQL → localhost:5432
# Redis      → localhost:6379
# LiveKit    → localhost:7880
```

---

### 5.1. Mô Hình Hybrid Dev: Dedicated Windows Host Server + macOS Client (`CR-008`)

Để giải phóng RAM/CPU cho máy lập trình **macOS** (chạy Xcode & iOS Simulator) đồng thời tận dụng máy **Windows 11 Pro** làm Dedicated Host Server chạy 24/7:
- **Kết nối mạng kép (Option A)**: Kết hợp IP nội bộ LAN (`192.168.3.119`) và mạng riêng ảo **Tailscale Mesh VPN** (`100.64.0.0/10`), đi kèm tường lửa Zero-Trust (`scripts/setup-windows-server-admin.ps1`) và Windows OpenSSH Server (`:22`).
- **Cấu hình động trên Flutter (`ApiClient`)**: Nhận `--dart-define=API_BASE_URL=http://<SERVER_IP>:8000` (tích hợp sẵn trong `.vscode/launch.json`), tự động fallback về `localhost` / `10.0.2.2` nếu không truyền cờ.
- **Ký động S3v4 & WebRTC đa mạng**: `StorageService.resolve_public_endpoint` và `ClassroomService.resolve_public_url` tự động suy diễn host từ `request.url.hostname` khi `MINIO_PUBLIC_ENDPOINT` / `LIVEKIT_PUBLIC_URL` để trống, đảm bảo chữ ký S3v4 và WebSocket LiveKit hợp lệ trên cả LAN lẫn Tailscale.
- **Bền vững dữ liệu Redis**: Kích hoạt `redis-server --appendonly yes` (AOF) trong `docker-compose.yml` và cung cấp công cụ vận hành/backup `scripts/server-ctl.ps1`.
- **Tài liệu vận hành chi tiết**: Xem [`windows-server-macos-dev-guide.md`](../windows-server-macos-dev-guide.md).

---

## 6. Flutter Dependencies (BE-related)

```yaml
# pubspec.yaml — chỉ những package liên quan BE
dependencies:
  # HTTP client
  dio: ^5.7.0                    # HTTP requests đến FastAPI
  retrofit: ^4.4.1               # Type-safe API client generator

  # Auth
  flutter_secure_storage: ^9.2.2 # Lưu JWT token an toàn

  # Live Video
  livekit_client: ^2.3.0         # LiveKit WebRTC

  # Push Notifications
  firebase_messaging: ^15.1.3    # Chỉ dùng FCM token, không dùng Firestore/Auth
  flutter_local_notifications: ^17.2.4

  # File
  dio: ^5.7.0                    # Upload file lên MinIO qua HTTP
```

---

## 7. Mapping Domain → Service

| Domain | REST Endpoint | Data | Storage | Realtime | Push |
|--------|--------------|------|---------|---------|------|
| Auth (02) | `/auth/*` | PostgreSQL | - | - | - |
| Courses (04) | `/courses/*` | PostgreSQL | MinIO (thumbnail) | - | - |
| Lessons (05-06) | `/lessons/*` | PostgreSQL | MinIO (video) | - | - |
| Live Classroom (07) | `/sessions/*` | PostgreSQL | - | LiveKit | FCM |
| Tests (08) | `/quizzes/*` | PostgreSQL | - | - | FCM |
| Gamification (09) | `/badges/*` | PostgreSQL | MinIO (badge img) | - | FCM |
| Chat DM (10) | `/chat/*` WS | PostgreSQL | - | FastAPI WS | FCM |
| Notifications (11) | `/notifications/*` | PostgreSQL | - | - | FCM |
| Profile (12) | `/users/*` | PostgreSQL | MinIO (avatar) | - | - |
| Analytics (14) | `/analytics/*` | PostgreSQL aggregate | - | - | - |
| Parent Hub | `/parent/*` | PostgreSQL | - | - | FCM |

---

## 8. Lộ Trình Học BE Song Song Với Sprint

> **Cập nhật 29/10/2026**: số sprint bên dưới là bản gốc. Sau re-baseline roadmap (+1 sprint, Sprint 4 dành cho Auth), `/courses` làm ở Sprint 5, LiveKit ở Sprint 7, Redis + Celery ở Sprint 8.

```
Sprint 4 → Học FastAPI + PostgreSQL
  Tuần 1: Cài Python, Docker Desktop. Đọc FastAPI tutorial chính thức.
  Tuần 2: Viết API /courses, /lessons với SQLAlchemy + PostgreSQL
  Tuần 3: Thêm Auth (JWT), kết nối Flutter với Dio

Sprint 5 → Học LiveKit
  Tuần 1: Chạy LiveKit Docker. Test video call 2 tab trình duyệt.
  Tuần 2: Tích hợp livekit_client vào Flutter
  Tuần 3: FastAPI viết endpoint sinh LiveKit token

Sprint 6 → Học Redis + Celery
  Tuần 1: Redis cơ bản (get/set/expire). Cache API courses.
  Tuần 2: Celery worker: auto-grade quiz bằng background task

Sprint 7 → Học MinIO
  Tuần 1: MinIO UI, tạo bucket, upload file thủ công
  Tuần 2: FastAPI viết API upload video, Flutter gọi để upload lesson

Sprint 8 → Học WebSocket + FCM
  Tuần 1: FastAPI WebSocket cho realtime chat
  Tuần 2: FCM Direct API, gửi test notification đến thiết bị thật

Sprint 10 → Học deploy lên VPS
  Tuần 1: Thuê VPS Hetzner (~$5/tháng). Setup Docker trên server.
  Tuần 2: docker compose up trên VPS. Cấu hình Caddy + domain.
```

---

## 9. Chi Phí

### Giai Đoạn Dev/Test (Localhost)
| Service | Chi Phí |
|---------|:-------:|
| FastAPI + Python | $0 |
| PostgreSQL (Docker) | $0 |
| Redis (Docker) | $0 |
| MinIO (Docker) | $0 |
| LiveKit (Docker) | $0 |
| FCM HTTP API | $0 |
| **TỔNG** | **$0** |

### Giai Đoạn Production (VPS — sau Sprint 10)
| Service | Chi Phí |
|---------|:-------:|
| VPS Hetzner (4vCPU/8GB) | ~$15/tháng |
| Domain (.com) | ~$10/năm |
| SSL (Caddy tự cấp) | $0 |
| **TỔNG** | **~$15-20/tháng** |

---

## 10. Rủi Ro & Biện Pháp

| Rủi Ro | Mức Độ | Biện Pháp |
|--------|:------:|---------|
| Đường cong học BE dốc | Cao | Học tuần tự theo lộ trình, không nhảy cóc |
| LiveKit NAT traversal khi test trên wifi | Trung bình | Test trên cùng mạng LAN, hoặc dùng ngrok tunnel |
| PostgreSQL migration conflict | Thấp | Luôn dùng Alembic, không sửa DB tay |
| MinIO data loss khi restart Docker | Thấp | Mount volume trong docker-compose (đã có) |
| FCM token expired | Thấp | Refresh token logic trong Flutter |

---

## 11. Technical Feasibility Sign-Off

```
## TECHNICAL FEASIBILITY SIGN-OFF — ADR-004 (Revised)

- Tech Lead    : Sub-Agent "The Pragmatic System Architect"
- Trạng thái  : APPROVED — Stack chuyên nghiệp, self-hosted hoàn toàn
- Stack        : FastAPI + PostgreSQL + Redis + MinIO + LiveKit + Caddy + FCM Direct
- Dev Cost     : $0 (localhost) → ~$15/tháng (production VPS)
- Cam kết SLAs : Cold start <= 1.8s | 60 FPS UI | LiveKit latency < 400ms | 0 memory leak
- Học theo     : Sprint-by-sprint, mỗi sprint học 1 service mới
- Chỉ dẫn Dev : Bắt đầu Sprint 4 với FastAPI + PostgreSQL, chưa cần Redis/MinIO/LiveKit
- Cần PO ký duyệt trước khi PM phân rã WBS Sprint 4
```

---

*Ban hành: Sub-Agent Tech Lead · 2026-10-22 (Revised: Self-Hosted Professional Stack)*
*Lưu tại: `docs/04-specifications/adr/adr-004-backend-architecture.md`*
