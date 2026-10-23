# Từ Điển Dữ Liệu Thực Thể (Data Dictionary) — Kiddora

Tài liệu này chuẩn hóa toàn bộ các cấu trúc dữ liệu, kiểu dữ liệu, ràng buộc và định nghĩa trường của các thực thể cốt lõi trong hệ thống Kiddora Mobile App.

---

## 1. Thực Thể `KidProfile` (Hồ Sơ Bé & Nhận Diện)
Lưu trữ thông tin cá nhân hóa của trẻ, lưu cục bộ trong `SharedPreferences` hoặc đồng bộ đám mây.

| Tên trường | Kiểu dữ liệu | Bắt buộc | Mô tả & Ràng buộc giá trị |
| :--- | :--- | :---: | :--- |
| `id` | String | Có | Mã định danh hồ sơ bé (UUID v4) |
| `nickname` | String | Có | Biệt danh của bé (VD: "Leo", "Milo"), độ dài 2-20 ký tự, không chứa ký tự đặc biệt |
| `age` | int | Có | Tuổi của bé, giá trị hợp lệ từ $6$ đến $12$ |
| `grade_level` | String | Có | Cấp học tương ứng (VD: "Grade 1", "Grade 3") |
| `mascot_id` | String | Có | Mã định danh 1 trong 12 con giáp (VD: "mascot_dragon", "mascot_cat") |
| `star_points` | int | Có | Tổng số sao vàng tích lũy được (mặc định $0$) |
| `streak_days` | int | Có | Chuỗi số ngày hoàn thành mục tiêu liên tiếp (mặc định $0$) |
| `created_at` | DateTime | Có | Thời điểm khởi tạo hồ sơ |

---

## 2. Thực Thể `Course` (Khóa Học)
Đại diện cho một khóa học hoàn chỉnh trong hệ thống Kiddora.

| Tên trường | Kiểu dữ liệu | Bắt buộc | Mô tả & Ràng buộc giá trị |
| :--- | :--- | :---: | :--- |
| `id` | String | Có | Mã định danh khóa học (VD: "course_amazing_animals") |
| `title` | String | Có | Tiêu đề khóa học (VD: "Amazing Animals") |
| `description` | String | Có | Đoạn mô tả nội dung khóa học |
| `category` | String | Có | Phân loại môn học: `"science"`, `"math"`, `"arts"`, `"language"` |
| `min_age` | int | Có | Độ tuổi tối thiểu khuyến nghị (VD: 7) |
| `max_age` | int | Có | Độ tuổi tối đa khuyến nghị (VD: 10) |
| `total_lessons`| int | Có | Tổng số bài giảng trong khóa học |
| `rating` | double | Có | Điểm đánh giá trung bình (VD: 4.8) |
| `review_count` | int | Có | Số lượng đánh giá từ phụ huynh (VD: 320) |
| `thumbnail_url`| String | Có | Đường dẫn ảnh minh họa 3D đại diện |
| `is_featured` | bool | Có | Đánh dấu hiển thị tại mục Popular Courses trên Home |

---

## 3. Thực Thể `Lesson` (Bài Giảng)
Chi tiết từng bài học con thuộc một khóa học cụ thể.

| Tên trường | Kiểu dữ liệu | Bắt buộc | Mô tả & Ràng buộc giá trị |
| :--- | :--- | :---: | :--- |
| `id` | String | Có | Mã định danh bài giảng (VD: "lesson_anim_01") |
| `course_id` | String | Có | Mã khóa học trực thuộc |
| `order_index` | int | Có | Thứ tự bài giảng trong khóa (1, 2, 3...) |
| `title` | String | Có | Tên bài học (VD: "Meet the Animals") |
| `duration_mins`| int | Có | Thời lượng ước tính tính bằng phút (VD: 10) |
| `is_unlocked` | bool | Có | Trạng thái mở khóa bài học |
| `is_completed`| bool | Có | Đã học xong hay chưa |

---

## 4. Thực Thể `DailyTask` (Nhiệm Vụ Hàng Ngày)
Đại diện cho 1 trong 5 nhiệm vụ trong mục tiêu ngày của bé.

| Tên trường | Kiểu dữ liệu | Bắt buộc | Mô tả & Ràng buộc giá trị |
| :--- | :--- | :---: | :--- |
| `id` | String | Có | Mã nhiệm vụ (VD: "task_watch_lesson_01") |
| `title` | String | Có | Nội dung nhiệm vụ (VD: "Watch 1 Video Lesson") |
| `reward_stars`| int | Có | Số sao thưởng khi hoàn thành (5 hoặc 10) |
| `is_completed`| bool | Có | Đã đánh dấu hoàn thành hay chưa |
| `task_type` | String | Có | Loại nhiệm vụ: `"lesson"`, `"quiz"`, `"live"`, `"story"`, `"score"` |

---

## 5. Thực Thể `LiveSession` (Buổi Học Trực Tiếp)
Đại diện cho buổi học thời gian thực cùng giáo viên.

| Tên trường | Kiểu dữ liệu | Bắt buộc | Mô tả & Ràng buộc giá trị |
| :--- | :--- | :---: | :--- |
| `id` | String | Có | Mã buổi học trực tiếp (VD: "live_space_exp") |
| `title` | String | Có | Tiêu đề buổi học (VD: "Space Exploration for Kids") |
| `coach_name` | String | Có | Tên giáo viên giảng dạy (VD: "Coach Sarah") |
| `coach_avatar`| String | Có | Ảnh đại diện của giáo viên |
| `scheduled_at`| DateTime | Có | Thời gian bắt đầu buổi học |
| `duration_mins`| int | Có | Thời lượng buổi học tính theo phút (VD: 45) |
| `participant_count` | int | Có | Số lượng học sinh đang tham gia (VD: 812) |
| `status` | String | Có | `"upcoming"`, `"live_now"`, `"completed"` |

---

## 6. Ánh Xạ Thực Thể Sang Cơ Sở Dữ Liệu Quan Hệ (PostgreSQL Schema Mapping)
*Theo quyết định kiến trúc tại [ADR-004](file:///Users/nguyenduytrang/flutter_project/kiddora/docs/04-specifications/adr/adr-004-backend-architecture.md) & [CR-005](file:///Users/nguyenduytrang/flutter_project/kiddora/docs/05-change-management/change-request-log.md)*

| Thực Thể Domain | Bảng PostgreSQL Tương Ứng | Khóa Chính (PK) | Quan Hệ Khóa Ngoại (FK) | Ghi Chú Kỹ Thuật |
| :--- | :--- | :--- | :--- | :--- |
| **User / Auth** | `users` | `id (UUID)` | `parent_id -> users(id)` | Hashed password bcrypt, role enum (kid/parent/coach) |
| **KidProfile** | `kid_profiles` | `id (UUID)` | `user_id -> users(id)` | Lưu nickname, mascot_id, age, grade |
| **Course** | `courses` | `id (VARCHAR)` | `coach_id -> users(id)` | Indexed theo category, min_age, max_age |
| **Lesson** | `lessons` | `id (VARCHAR)` | `course_id -> courses(id)` | Video stream URL trỏ tới MinIO storage |
| **UserProgress** | `user_progress`| `id (UUID)` | `user_id`, `lesson_id` | Unique `(user_id, lesson_id)`, tracking % hoàn thành |
| **DailyTask** | `daily_tasks` | `id (VARCHAR)` | `user_id -> users(id)` | Reset theo ngày (cron/worker Celery) |
| **LiveSession** | `live_sessions` | `id (VARCHAR)` | `coach_id -> users(id)` | Liên kết `livekit_channel` để học sinh join WebRTC |
| **Participant** | `session_participants`| `id (UUID)` | `session_id`, `user_id`| Theo dõi hiện diện real-time |
| **Badge / Reward** | `badges`, `user_badges`| `id (VARCHAR)` | `user_id`, `badge_id` | Tự động trao thưởng qua Celery queue |
