# Thiết Kế Kỹ Thuật (Tech Spec) — Fullstack E2E Auth, Onboarding & User Sync (Sprint 4)

- **Mã Tài Liệu**: `SPEC-20261023-AUTH-ONBOARDING`
- **Tác giả / Thẩm định**: Sub-Agent Tech Lead & System Architect
- **Phê duyệt**: Sub-Agent Product Owner (PO), Sub-Agent Project Manager (PM), User
- **Ngày ban hành**: 2026-10-23
- **Trạng thái**: `APPROVED & IN PROGRESS`

---

## 1. Bối Cảnh & Mục Tiêu

### 1.1. Hiện Trạng Hệ Thống
- Sprints 1, 2, 3 và Hardening đã hoàn thành giao diện (Frontend Flutter UI): Onboarding 3 slide, Kid Profile Setup v2, Login Screen, Register Screen, Home Screen.
- Tuy nhiên toàn bộ dữ liệu người dùng đang chạy Mock qua `SharedPreferences` cục bộ hoặc `Future.delayed`.
- Backend FastAPI đã có khung skeleton (`/auth/register`, `/auth/login`, `/auth/me`), nhưng chưa có cấu hình Alembic migration, chưa có endpoint tạo KidProfile độc lập cho phụ huynh, và mã linh vật (mascot ID) bị lệch so với Flutter.

### 1.2. Mục Tiêu Sprint 4
- Hiện thực hóa luồng Fullstack End-to-End từ Client Flutter tới REST API FastAPI và PostgreSQL 16 DB.
- Cấu hình trọn vẹn Alembic database migration cho bảng `users` và `kid_profiles`.
- Tách bạch 2 bước: Đăng ký tài khoản Phụ huynh (`POST /api/v1/auth/register`) và Thiết lập hồ sơ bé (`POST /api/v1/auth/kid-profile`).
- Hỗ trợ chế độ Hybrid: Trải nghiệm thử (Guest mode) không chặn người dùng, cho phép chuyển đổi sang tài khoản chính thức (Guest-to-User conversion) mà không làm mất dữ liệu local.
- Bảo mật: Lưu JWT Token trên thiết bị bằng `FlutterSecureStorage`, Access Token 7 ngày.

---

## 2. Kiến Trúc Dữ Liệu & Database Migration

### 2.1. Bảng `users` (PostgreSQL 16)
| Tên Cột | Kiểu Dữ Liệu | Ràng Buộc | Ghi Chú |
| :--- | :--- | :--- | :--- |
| `id` | `UUID` | `PRIMARY KEY, DEFAULT gen_random_uuid()` | Khóa chính |
| `email` | `VARCHAR(255)` | `UNIQUE, NOT NULL, INDEX` | Email phụ huynh |
| `hashed_password` | `VARCHAR(255)` | `NOT NULL` | Hash bằng `bcrypt` |
| `full_name` | `VARCHAR(100)` | `NULLABLE` | Họ tên phụ huynh |
| `role` | `VARCHAR(20)` | `DEFAULT 'parent', NOT NULL` | `parent`, `student`, `coach` |
| `is_active` | `BOOLEAN` | `DEFAULT TRUE, NOT NULL` | Trạng thái kích hoạt |
| `parent_id` | `UUID` | `FOREIGN KEY (users.id), NULLABLE` | Hỗ trợ phân cấp tài khoản COPPA |
| `created_at` | `TIMESTAMPTZ` | `DEFAULT CURRENT_TIMESTAMP, NOT NULL` | Thời gian tạo (UTC) |
| `updated_at` | `TIMESTAMPTZ` | `DEFAULT CURRENT_TIMESTAMP, NOT NULL` | Thời gian cập nhật (UTC) |

### 2.2. Bảng `kid_profiles` (PostgreSQL 16)
| Tên Cột | Kiểu Dữ Liệu | Ràng Buộc | Ghi Chú |
| :--- | :--- | :--- | :--- |
| `id` | `UUID` | `PRIMARY KEY, DEFAULT gen_random_uuid()` | Khóa chính |
| `user_id` | `UUID` | `FOREIGN KEY (users.id) ON DELETE CASCADE, UNIQUE, NOT NULL` | Khóa ngoại 1-1 với Phụ huynh |
| `nickname` | `VARCHAR(50)` | `NOT NULL` | Biệt danh của bé (2-20 ký tự) |
| `age` | `INTEGER` | `CHECK (age >= 6 AND age <= 12), NOT NULL` | Giới hạn độ tuổi theo COPPA |
| `grade_level` | `VARCHAR(50)` | `NULLABLE` | Cấp lớp (VD: "Lớp 3") |
| `mascot_id` | `VARCHAR(50)` | `DEFAULT 'zodiac_dragon', NOT NULL` | Khớp 100% với `AvatarPresets` |
| `star_points` | `INTEGER` | `DEFAULT 10, NOT NULL` | Tặng 10 sao khởi điểm |
| `streak_days` | `INTEGER` | `DEFAULT 1, NOT NULL` | Chuỗi 1 ngày ban đầu |
| `created_at` | `TIMESTAMPTZ` | `DEFAULT CURRENT_TIMESTAMP, NOT NULL` | Thời gian tạo (UTC) |
| `updated_at` | `TIMESTAMPTZ` | `DEFAULT CURRENT_TIMESTAMP, NOT NULL` | Thời gian cập nhật (UTC) |

### 2.3. Danh Sách Mascot ID Hợp Lệ
`['lion', 'bear', 'dino', 'bunny', 'zodiac_mouse', 'zodiac_buffalo', 'zodiac_tiger', 'zodiac_cat', 'zodiac_dragon', 'zodiac_snake', 'zodiac_horse', 'zodiac_goat', 'zodiac_monkey', 'zodiac_rooster', 'zodiac_dog', 'zodiac_pig']`

---

## 3. Đặc Tả REST API (FastAPI Backend)

### 3.1. `POST /api/v1/auth/register`
* **Mục đích**: Đăng ký tài khoản Phụ huynh
* **Request Body**:
  ```json
  {
    "email": "parent@example.com",
    "password": "Password123!",
    "full_name": "Nguyen Van A"
  }
  ```
* **Response 201 Created**:
  ```json
  {
    "access_token": "eyJ...",
    "refresh_token": "eyJ...",
    "token_type": "bearer",
    "user": {
      "id": "c62b53e8-5fc9-478a-9860-24eb14d03923",
      "email": "parent@example.com",
      "full_name": "Nguyen Van A",
      "role": "parent"
    }
  }
  ```

### 3.2. `POST /api/v1/auth/kid-profile`
* **Mục đích**: Tạo hoặc cập nhật hồ sơ bé gắn với tài khoản phụ huynh hiện tại
* **Header**: `Authorization: Bearer <access_token>`
* **Request Body**:
  ```json
  {
    "nickname": "Leo",
    "age": 8,
    "mascot_id": "zodiac_dragon"
  }
  ```
* **Response 200 OK**:
  ```json
  {
    "id": "e45b17a1-2fc9-478a-9860-12ab34d05912",
    "user_id": "c62b53e8-5fc9-478a-9860-24eb14d03923",
    "nickname": "Leo",
    "age": 8,
    "grade_level": "Grade 3",
    "mascot_id": "zodiac_dragon",
    "star_points": 10,
    "streak_days": 1
  }
  ```

### 3.3. `POST /api/v1/auth/login`
* **Request Body**: `{ "email": "parent@example.com", "password": "Password123!" }`
* **Response 200 OK**:
  ```json
  {
    "access_token": "eyJ...",
    "refresh_token": "eyJ...",
    "token_type": "bearer",
    "user": { ... },
    "kid_profile": { ... }
  }
  ```

### 3.4. `GET /api/v1/auth/me`
* **Header**: `Authorization: Bearer <access_token>`
* **Response 200 OK**: Trả về chi tiết `user` và `kid_profile`.

---

## 4. Tầng Mạng Flutter & State Management

### 4.1. Core Network Layer
- `lib/core/network/token_storage.dart`: Wrapper `FlutterSecureStorage` lưu trữ `access_token`, `refresh_token`, `guest_flag`.
- `lib/core/network/api_client.dart`: Cấu hình Dio, Interceptor tự động gán `Bearer token`, cấu hình BaseURL động (Android Emulator `10.0.2.2:8000`, iOS / Web `127.0.0.1:8000`).

### 4.2. Riverpod Auth Architecture
- `authControllerProvider`: Quản lý `AuthState`
  - `status`: `unauthenticated`, `authenticated`, `guest`, `loading`, `error`
  - `user`: Thông tin phụ huynh
  - `kidProfile`: Thông tin bé
  - Phương thức: `login()`, `register()`, `saveKidProfile()`, `continueAsGuest()`, `logout()`, `restoreSession()`.
