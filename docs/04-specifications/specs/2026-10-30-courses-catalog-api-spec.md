# Đặc Tả Hợp Đồng REST API: Danh Mục Khóa Học & Chi Tiết Giáo Trình (Tech Lead Revised)
## Kiddora Mobile App — Feature-First API Contract Spec

- **Mã tài liệu**: `SPEC-20261030-COURSES-API`
- **Tác giả phối hợp**: Sub-Agent Tech Lead & Sub-Agent Backend Developer (`backend-dev`)
- **Đối tượng thụ hưởng**: Sub-Agent Flutter Core Developer (`flutter-core-dev`) & QA Tester
- **Ánh xạ kiến trúc**: [Gate 0 Tech Lead Review](file:///Users/nguyenduytrang/flutter_project/kiddora/docs/gates/sprint5-courses-hub/gate0-tech-lead-review.md), [ADR-004](file:///Users/nguyenduytrang/flutter_project/kiddora/docs/04-specifications/adr/adr-004-backend-architecture.md)
- **Base URL**: `/api/v1`
- **Trạng thái**: 🟢 **APPROVED BY TECH LEAD (PONYTAIL ZERO-BLOAT)**

---

## 🌐 1. Nguyên Tắc Thiết Kế API & Chuẩn Đồng Bộ Ponytail
1. **Tận dụng tối đa module `backend/app/modules/courses/` sẵn có**: Không đập đi xây lại, không bọc thêm pagination envelope rườm rà khi danh mục khóa học trẻ em gọn nhẹ, không sinh thêm endpoint `/subjects` thừa thãi (danh sách môn học cố định trên UI).
2. **Khớp kiểu 1:1 với Flutter Freezed**: Các trường `snake_case` ở JSON payload tương thích trực tiếp với `@freezed` models trên client Dart.
3. **Nguyên tắc "Backend là nguồn lỗi duy nhất" (CR-010)**: Mọi lỗi trả về theo định dạng chuẩn FastAPI:
   ```json
   {
     "detail": "Khóa học không tồn tại"
   }
   ```
4. **Tài nguyên ảnh 3D cục bộ**: `thumbnail_url` trả về mã asset cục bộ trong `assets/images/...` để đảm bảo 60 FPS và hoạt động 100% trong môi trường offline / widget test.

---

## 📡 2. Danh Sách Endpoints Chi Tiết

### 2.1. `GET /api/v1/courses` — Tìm Kiếm & Lọc Danh Sách Khóa Học (4 Chiều Lọc)
Lấy danh sách khóa học phục vụ cho cả 4 màn hình Domain 04 (`04_courses_01` $\rightarrow$ `04_courses_04`).

- **Quyền truy cập**: Public.
- **Query Parameters**:
  - `category` (optional, string): `"science"`, `"math"`, `"language"`, `"arts"`, `"technology"`, `"life_skills"`, `"social_studies"`. Nếu rỗng hoặc `"all"` thì lấy tất cả.
  - `age` (optional, int): Lọc khóa học chứa độ tuổi cụ thể (`min_age <= age <= max_age`).
  - `min_age` (optional, int): Độ tuổi tối thiểu của nhóm tuổi lọc (VD: `7`, `9`, `11` từ `04_courses_03`).
  - `max_age` (optional, int): Độ tuổi tối đa của nhóm tuổi lọc (VD: `8`, `10`, `12` từ `04_courses_03`).
  - `level` (optional, string): `"beginner"`, `"intermediate"`, `"advanced"`.
  - `duration` (optional, string): `"short"` (1–3 bài), `"medium"` (4–6 bài), `"long"` (7+ bài).
  - `search` (optional, string): Từ khóa tìm kiếm theo tiêu đề khóa học (VD: `"Space"`).

- **Response 200 OK (`List[CourseCardResponse]`)**:
```json
[
  {
    "id": "course_amazing_animals",
    "title": "Amazing Animals",
    "description": "Join us on an exciting journey to learn about different animals, their habitats, and how they live in our amazing world. This course is designed to be fun, interactive, and easy to understand!",
    "category": "science",
    "min_age": 7,
    "max_age": 10,
    "level": "beginner",
    "total_lessons": 5,
    "rating": 4.8,
    "review_count": 320,
    "thumbnail_url": "assets/images/course_dino.png",
    "is_featured": true
  },
  {
    "id": "course_space_exploration",
    "title": "Space Exploration",
    "description": "Blast off into outer space to explore planets, stars, rockets, and astronauts in our solar system!",
    "category": "science",
    "min_age": 8,
    "max_age": 12,
    "level": "intermediate",
    "total_lessons": 6,
    "rating": 4.9,
    "review_count": 215,
    "thumbnail_url": "assets/images/mascot_star_goal.png",
    "is_featured": true
  },
  {
    "id": "course_math_fun_numbers",
    "title": "Math Fun with Numbers",
    "description": "Master mental math, addition, subtraction, and fun number puzzles through interactive games!",
    "category": "math",
    "min_age": 7,
    "max_age": 10,
    "level": "beginner",
    "total_lessons": 5,
    "rating": 4.7,
    "review_count": 180,
    "thumbnail_url": "assets/images/mascot_boy_crown.png",
    "is_featured": true
  },
  {
    "id": "course_creative_drawing",
    "title": "Creative Drawing",
    "description": "Unleash your imagination with shapes, colors, and step-by-step character drawing lessons!",
    "category": "arts",
    "min_age": 7,
    "max_age": 12,
    "level": "beginner",
    "total_lessons": 8,
    "rating": 4.8,
    "review_count": 145,
    "thumbnail_url": "assets/images/avatar_bunny.png",
    "is_featured": true
  },
  {
    "id": "course_our_planet",
    "title": "Our Planet",
    "description": "Discover oceans, continents, weather, and how we can protect our beautiful Earth!",
    "category": "science",
    "min_age": 8,
    "max_age": 12,
    "level": "intermediate",
    "total_lessons": 6,
    "rating": 4.6,
    "review_count": 98,
    "thumbnail_url": "assets/images/zodiac_dragon.png",
    "is_featured": false
  },
  {
    "id": "course_intro_technology",
    "title": "Intro to Technology",
    "description": "Learn how computers, robots, and smart inventions work in our daily lives!",
    "category": "technology",
    "min_age": 9,
    "max_age": 12,
    "level": "advanced",
    "total_lessons": 5,
    "rating": 4.9,
    "review_count": 260,
    "thumbnail_url": "assets/images/zodiac_monkey.png",
    "is_featured": false
  }
]
```

---

### 2.2. `GET /api/v1/courses/{course_id}` — Chi Tiết Khóa Học & Giáo Trình 5 Bài Giảng
Lấy thông tin chi tiết một khóa học kèm danh sách bài giảng chuẩn đối sánh `05_course_detail_01_overview_about.png` và `05_course_detail_02_curriculum_lessons.png`.

- **Quyền truy cập**: Public.
- **Response 200 OK (`CourseDetailResponse`)**:
```json
{
  "id": "course_amazing_animals",
  "title": "Amazing Animals",
  "subtitle": "Discover the wonderful world of animals and their habitats!",
  "description": "Join us on an exciting journey to learn about different animals, their habitats, and how they live in our amazing world. This course is designed to be fun, interactive, and easy to understand!",
  "category": "science",
  "min_age": 7,
  "max_age": 10,
  "level": "beginner",
  "total_lessons": 5,
  "rating": 4.8,
  "review_count": 320,
  "thumbnail_url": "assets/images/course_dino.png",
  "is_featured": true,
  "lessons": [
    {
      "id": "lesson_anim_01",
      "order_index": 1,
      "title": "Meet the Animals",
      "duration_mins": 10,
      "thumbnail_url": "assets/images/avatar_lion.png",
      "video_url": null,
      "is_completed": true,
      "is_unlocked": true
    },
    {
      "id": "lesson_anim_02",
      "order_index": 2,
      "title": "Animals and Their Habitats",
      "duration_mins": 12,
      "thumbnail_url": "assets/images/avatar_bear.png",
      "video_url": null,
      "is_completed": false,
      "is_unlocked": true
    },
    {
      "id": "lesson_anim_03",
      "order_index": 3,
      "title": "Food and Eating Habits",
      "duration_mins": 10,
      "thumbnail_url": "assets/images/avatar_dino.png",
      "video_url": null,
      "is_completed": false,
      "is_unlocked": false
    },
    {
      "id": "lesson_anim_04",
      "order_index": 4,
      "title": "Animal Life Cycles",
      "duration_mins": 15,
      "thumbnail_url": "assets/images/zodiac_dragon.png",
      "video_url": null,
      "is_completed": false,
      "is_unlocked": false
    },
    {
      "id": "lesson_anim_05",
      "order_index": 5,
      "title": "How We Can Help",
      "duration_mins": 10,
      "thumbnail_url": "assets/images/avatar_bunny.png",
      "video_url": null,
      "is_completed": false,
      "is_unlocked": false
    }
  ]
}
```

- **Response 404 Not Found**:
```json
{
  "detail": "Khóa học không tồn tại"
}
```
