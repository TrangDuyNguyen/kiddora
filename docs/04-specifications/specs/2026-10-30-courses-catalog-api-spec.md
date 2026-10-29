# Đặc Tả Hợp Đồng REST API: Danh Mục Khóa Học & Chi Tiết Giáo Trình
## Kiddora Mobile App — Feature-First API Contract Spec

- **Mã tài liệu**: `SPEC-20261030-COURSES-API`
- **Tác giả phối hợp**: Sub-Agent Tech Lead & Sub-Agent Backend Developer (`backend-dev`)
- **Đối tượng thụ hưởng**: Sub-Agent Flutter Core Developer (`flutter-core-dev`) & QA Tester
- **Ánh xạ kiến trúc**: [ADR-004](file:///Users/nguyenduytrang/flutter_project/kiddora/docs/04-specifications/adr/adr-004-backend-architecture.md) & [CR-005](file:///Users/nguyenduytrang/flutter_project/kiddora/docs/05-change-management/change-request-log.md)
- **Base URL**: `/api/v1`
- **Trạng thái**: 🟢 **APPROVED FOR SPRINT 5 IMPLEMENTATION**

---

## 🌐 1. Nguyên Tắc Thiết Kế API & Chuẩn Đồng Bộ
1. **Kiến trúc Modular Monolith**: Module `backend/app/modules/courses/` chịu trách nhiệm toàn bộ logic dữ liệu khóa học.
2. **Khớp kiểu 1:1 với Flutter Freezed**: Các trường `snake_case` ở JSON payload tương thích trực tiếp với `@freezed` models trên client Dart.
3. **Nguyên tắc "Backend là nguồn lỗi duy nhất" (CR-010)**: Mọi lỗi trả về theo định dạng chuẩn FastAPI:
   ```json
   {
     "detail": "Khóa học không tồn tại hoặc đã bị ẩn"
   }
   ```
4. **Hiệu năng & Caching**: Cache Redis danh sách khóa học phổ biến với TTL = 60 giây; thời gian phản hồi API $\le 80\text{ms}$.

---

## 📡 2. Danh Sách Endpoints Chi Tiết

### 2.1. `GET /api/v1/subjects` — Danh Sách Môn Học / Danh Mục
Lấy danh sách các môn học để hiển thị lên dải chip `ClayFilterBar`.

- **Quyền truy cập**: Public (Không bắt buộc Bearer token).
- **Response 200 OK**:
```json
[
  {
    "id": "all",
    "name": "Tất cả",
    "code": "all",
    "color_hex": "#4648D4",
    "icon_name": "sparkles"
  },
  {
    "id": "science",
    "name": "Khoa học STEM",
    "code": "science",
    "color_hex": "#EC4899",
    "icon_name": "atom"
  },
  {
    "id": "math",
    "name": "Toán tư duy",
    "code": "math",
    "color_hex": "#6366F1",
    "icon_name": "calculator"
  },
  {
    "id": "language",
    "name": "Ngôn ngữ",
    "code": "language",
    "color_hex": "#0EA5E9",
    "icon_name": "book_open"
  },
  {
    "id": "arts",
    "name": "Nghệ thuật & Sáng tạo",
    "code": "arts",
    "color_hex": "#F59E0B",
    "icon_name": "palette"
  }
]
```

---

### 2.2. `GET /api/v1/courses` — Tìm Kiếm & Lọc Danh Sách Khóa Học
Lấy danh sách khóa học theo bộ lọc đa tiêu chí (dùng cho Courses Hub, Search Screen, Filter Sheet).

- **Quyền truy cập**: Public.
- **Query Parameters**:
  - `category` (optional, string): `"science"`, `"math"`, `"language"`, `"arts"`. Nếu rỗng hoặc `"all"` thì lấy tất cả.
  - `age` (optional, int): Lọc khóa học phù hợp với tuổi cụ thể (ví dụ: `8`).
  - `min_age` (optional, int): Độ tuổi tối thiểu (ví dụ: `6`, `9`, `11`).
  - `max_age` (optional, int): Độ tuổi tối đa (ví dụ: `8`, `10`, `12`).
  - `level` (optional, string): `"beginner"`, `"intermediate"`, `"advanced"`.
  - `search` (optional, string): Từ khóa tìm kiếm theo tên hoặc mô tả (ví dụ: `"Space"`, `"Animals"`).
  - `is_featured` (optional, bool): Lọc các khóa học nổi bật hiển thị trên Home / Popular.
  - `page` (optional, int, default `1`): Số trang.
  - `page_size` (optional, int, default `20`): Số khóa học mỗi trang.

- **Response 200 OK**:
```json
{
  "total": 12,
  "page": 1,
  "page_size": 20,
  "items": [
    {
      "id": "course_amazing_animals",
      "title": "Amazing Animals",
      "description": "Khám phá thế giới động vật hoang dã kỳ thú, môi trường sống và tập tính của muôn loài.",
      "category": "science",
      "min_age": 7,
      "max_age": 10,
      "level": "beginner",
      "total_lessons": 5,
      "total_duration_mins": 75,
      "rating": 4.8,
      "review_count": 320,
      "thumbnail_url": "assets/images/course_dino.png",
      "is_featured": true,
      "badge_reward_name": "Animal Friend Badge"
    },
    {
      "id": "course_math_fun_numbers",
      "title": "Math Fun with Numbers",
      "description": "Làm quen với các con số qua hình vẽ sinh động, phép đếm vui nhộn và câu đố toán học.",
      "category": "math",
      "min_age": 6,
      "max_age": 8,
      "level": "beginner",
      "total_lessons": 8,
      "total_duration_mins": 90,
      "rating": 4.9,
      "review_count": 450,
      "thumbnail_url": "assets/images/course_dino.png",
      "is_featured": true,
      "badge_reward_name": "Math Wizard Badge"
    },
    {
      "id": "course_space_exploration",
      "title": "Space Exploration for Kids",
      "description": "Hành trình thám hiểm vũ trụ, các hành tinh trong Hệ Mặt Trời và tên lửa không gian.",
      "category": "science",
      "min_age": 8,
      "max_age": 12,
      "level": "intermediate",
      "total_lessons": 6,
      "total_duration_mins": 80,
      "rating": 4.7,
      "review_count": 210,
      "thumbnail_url": "assets/images/course_dino.png",
      "is_featured": true,
      "badge_reward_name": "Cosmic Explorer Badge"
    },
    {
      "id": "course_creative_drawing",
      "title": "Creative Drawing & Colors",
      "description": "Rèn luyện khả năng vẽ hình học, phối màu sắc tươi sáng và khơi nguồn sáng tạo nghệ thuật.",
      "category": "arts",
      "min_age": 6,
      "max_age": 10,
      "level": "beginner",
      "total_lessons": 4,
      "total_duration_mins": 60,
      "rating": 4.6,
      "review_count": 180,
      "thumbnail_url": "assets/images/course_dino.png",
      "is_featured": false,
      "badge_reward_name": "Little Artist Badge"
    }
  ]
}
```

---

### 2.3. `GET /api/v1/courses/{course_id}` — Chi Tiết Khóa Học & Giáo Trình Bài Giảng
Lấy toàn bộ thông tin chi tiết một khóa học, bao gồm danh sách bài giảng (Curriculum) và thông tin giảng viên.

- **Quyền truy cập**: Public (Nếu có Bearer token thì trả về trạng thái tiến độ cá nhân của học sinh: `is_unlocked`, `is_completed`).
- **Response 200 OK**:
```json
{
  "id": "course_amazing_animals",
  "title": "Amazing Animals",
  "description": "Khám phá thế giới động vật hoang dã kỳ thú, môi trường sống và tập tính của muôn loài qua các video 3D sinh động.",
  "category": "science",
  "min_age": 7,
  "max_age": 10,
  "level": "beginner",
  "total_lessons": 5,
  "total_duration_mins": 75,
  "rating": 4.8,
  "review_count": 320,
  "thumbnail_url": "assets/images/course_dino.png",
  "is_featured": true,
  "badge_reward_name": "Animal Friend Badge",
  "coach": {
    "id": "coach_sarah_01",
    "name": "Coach Sarah",
    "title": "Chuyên gia Giáo dục STEM & Tự nhiên",
    "avatar_url": "assets/images/avatar_coach_sarah.png",
    "rating": 4.9,
    "students_count": 1420
  },
  "features": [
    {"icon": "video", "title": "Fun Videos", "description": "Bài giảng hoạt hình ngắn"},
    {"icon": "quiz", "title": "Interactive Quizzes", "description": "Câu hỏi tương tác vui nhộn"},
    {"icon": "sheet", "title": "Activity Sheets", "description": "Phiếu bài tập thực hành"},
    {"icon": "badge", "title": "Earn Badges", "description": "Mở khóa huy hiệu độc quyền"}
  ],
  "learning_outcomes": [
    "Nhận biết hơn 30 loài động vật đặc trưng trên toàn cầu",
    "Phân biệt môi trường sống: rừng rậm, sa mạc, đại dương và vùng cực",
    "Hiểu về chuỗi thức ăn tự nhiên và tập tính săn mồi thân thiện",
    "Hình thành tình yêu thiên nhiên và ý thức bảo vệ môi trường"
  ],
  "lessons": [
    {
      "id": "lesson_anim_01",
      "course_id": "course_amazing_animals",
      "order_index": 1,
      "title": "Meet the Animals",
      "description": "Làm quen với các bạn thú rừng nhiệt đới đáng yêu",
      "duration_mins": 10,
      "is_unlocked": true,
      "is_completed": true,
      "video_url": "https://media.kiddora.com/lessons/anim_01.mp4"
    },
    {
      "id": "lesson_anim_02",
      "course_id": "course_amazing_animals",
      "order_index": 2,
      "title": "Animals & Their Habitats",
      "description": "Mỗi bạn thú sống ở đâu và ngôi nhà tự nhiên thế nào",
      "duration_mins": 15,
      "is_unlocked": true,
      "is_completed": false,
      "video_url": "https://media.kiddora.com/lessons/anim_02.mp4"
    },
    {
      "id": "lesson_anim_03",
      "course_id": "course_amazing_animals",
      "order_index": 3,
      "title": "What Animals Eat (Diet)",
      "description": "Khám phá món ăn yêu thích của từng loài động vật",
      "duration_mins": 15,
      "is_unlocked": false,
      "is_completed": false,
      "video_url": null
    },
    {
      "id": "lesson_anim_04",
      "course_id": "course_amazing_animals",
      "order_index": 4,
      "title": "Animal Families & Babies",
      "description": "Các bạn thú chăm sóc con nhỏ như thế nào",
      "duration_mins": 20,
      "is_unlocked": false,
      "is_completed": false,
      "video_url": null
    },
    {
      "id": "lesson_anim_05",
      "course_id": "course_amazing_animals",
      "order_index": 5,
      "title": "Amazing Animal Facts Quiz",
      "description": "Đố vui tổng kết và nhận huy hiệu thưởng",
      "duration_mins": 15,
      "is_unlocked": false,
      "is_completed": false,
      "video_url": null
    }
  ]
}
```

- **Response 404 Not Found**:
```json
{
  "detail": "Khóa học không tồn tại hoặc đã bị ẩn"
}
```

---

## 🗄️ 3. Mô Hình Dữ Liệu Khớp Với Freezed Client Dart

```dart
// lib/features/exploration/domain/entities/course.dart
@freezed
class Course with _$Course {
  const factory Course({
    required String id,
    required String title,
    required String description,
    required String category,
    required int minAge,
    required int maxAge,
    required String level,
    required int totalLessons,
    required int totalDurationMins,
    required double rating,
    required int reviewCount,
    required String thumbnailUrl,
    required bool isFeatured,
    String? badgeRewardName,
    List<Lesson>? lessons,
    CoachInfo? coach,
  }) = _Course;

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
}
```

---

## 🔒 4. Tiêu Chuẩn Bảo Mật & Quy Định COPPA
- Không lưu bất kỳ thông tin nhận dạng cá nhân (PII) của trẻ trong dữ liệu khóa học.
- Đánh giá khóa học (Reviews) chỉ cho phép phụ huynh đã xác thực tài khoản gửi nhận xét.
