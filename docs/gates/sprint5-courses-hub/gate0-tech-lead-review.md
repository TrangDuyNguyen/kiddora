# Gate 0: Biên Bản Thẩm Định Kiến Trúc & Rà Soát Kỹ Thuật (Tech Lead Review)
## Sprint 5 — Phân Hệ Khám Phá Khóa Học & Chi Tiết Giáo Trình (`v0.5.0-courses-hub`)

- **Người thẩm định**: Sub-Agent Tech Lead & System Architect — *"The Pragmatic System Architect"*
- **Ngày thẩm định**: 29/10/2026
- **Phạm vi rà soát**:
  1. Đối chiếu trực tiếp 6 ảnh thiết kế gốc (`04_courses_01` $\rightarrow$ `05_course_detail_02`) với PRD, UI Specs và BDD Gherkin.
  2. Rà soát mã nguồn Backend hiện hữu tại `backend/app/modules/courses/` và Alembic migrations.
  3. Rà soát kiến trúc điều hướng Flutter (`HomeScreen`, `ClayBottomNav`, `AppRouter`) và `lib/shared/ui_kit/`.
- **Kết luận thẩm định**: 🟡 **APPROVED WITH 7 MANDATORY ARCHITECTURAL CORRECTIONS** *(Đã cập nhật trực tiếp vào Specs & Plan trước khi bàn giao cho Dev)*.

---

## 🔍 1. Bảy (07) Phát Hiện Kỹ Thuật & Hiệu Chỉnh Bắt Buộc Trước Khi Code

Qua quá trình đối sánh từng pixel trên 6 file ảnh chuẩn Dribbble và kiểm tra mã nguồn hiện tại trong repo, Tech Lead phát hiện **7 điểm lệch (Spec Drift)** cần chấn chỉnh ngay để chặn đứng nguy cơ Dev làm sai hoặc over-engineering:

### 🛠️ Phát hiện 1: Cấu trúc `04_courses_01` (Courses Hub) — Nút Search Tròn & Hero Banner
- **Sai lệch trong PRD cũ**: Mô tả `04_courses_01` có thanh tìm kiếm trải ngang và nút Filter ngay tại Hub.
- **Thực tế trên ảnh chuẩn `04_courses_01_explore_and_categories.png`**:
  1. **Top Header**: Bên trái là tiêu đề lớn `"Courses"` + phụ đề `"Explore, Learn and Grow!"`; bên phải là **nút tròn `ClayIconButton` hình kính lúp (`🔍`)** kích thước chuẩn $\ge 48\times48\text{dp}$. Khi bấm nút kính lúp mới chuyển sang màn hình `CourseSearchScreen` (`04_courses_02`).
  2. **Hero Banner**: Ngay dưới Header là thẻ Hero Banner tím pastel `"A Brighter Future Starts Here!"` kèm linh vật bé trai đeo cặp sách vẫy tay và ngôi sao vàng.
  3. **Dải Danh Mục Môn Học (5 Ô Vuông Dọc)**: `All`, `Science`, `Math`, `Language`, `Arts` hiển thị dạng thẻ vuông bo góc có **Icon màu phía trên + Nhãn chữ phía dưới** (khác với dải chip ngang ở màn `04_courses_04`).
  4. **Section `"Popular Courses"`**: Có nút `"See All"` bên phải (bấm vào mở màn `AllCoursesGridScreen` — `04_courses_04`). Mỗi thẻ khóa học có nút mũi tên tròn màu tím `>` ở góc dưới phải.

### 🛠️ Phát hiện 2: Màn hình `04_courses_03` (Filter Courses) Có 4 Chiều Lọc (Không Phải 3)
- **Sai lệch trong Spec cũ**: Chỉ liệt kê 3 nhóm lọc (Program, Age 6-8, Level) và thiếu nhóm Thời lượng khóa học.
- **Thực tế trên ảnh chuẩn `04_courses_03_filter_courses_sheet.png`**:
  - Header gồm: Nút tròn Back (`<-`), tiêu đề `"Filter Courses"`, nút chữ `"Clear All"` bên phải.
  - **4 Nhóm tiêu chí lọc đầy đủ**:
    1. **Program / Category**: `All`, `Science`, `Mathematics`, `Language`, `Arts & Creativity`, `Technology`, `Life Skills`.
    2. **Age Group**: `All`, `7 – 8`, `9 – 10`, `11 – 12`.
    3. **Difficulty Level**: `All`, `Beginner`, `Intermediate`, `Advanced` (kèm icon cột sóng mức độ).
    4. **Course Duration**: `All`, `Short (1–3 lessons)`, `Medium (4–6 lessons)`, `Long (7+ lessons)`.
  - Nút đáy: `ClayButton` full-width màu Indigo kèm icon filter sliders `"Apply Filters"`.

### 🛠️ Phát hiện 3: Màn hình `04_courses_04` (All Courses Grid) Có Nút Yêu Thích (`❤️`) & 6 Khóa Học
- **Thực tế trên ảnh chuẩn `04_courses_04_all_courses_grid.png`**:
  - Header: `"All Courses"` + phụ đề `"Explore and find your favorite courses!"` + nút kính lúp tròn bên phải.
  - Dải chip lọc ngang có icon: `All`, `Science`, `Math`, `Arts`.
  - Lưới 2 cột gồm **6 khóa học**: *Amazing Animals*, *Space Exploration*, *Math Fun with Numbers*, *Creative Drawing*, *Our Planet* (Social Studies), *Intro to Technology* (Technology).
  - Trên góc phải của ảnh bìa mỗi thẻ khóa học có **nút tròn trắng chứa icon Trái tim đỏ (`❤️`)** để đánh dấu yêu thích (Favorite toggle).

### 🛠️ Phát hiện 4: Tách Bạch 2 Trạng Thái/Màn Hình `05_course_detail_01` (Overview) & `05_course_detail_02` (Curriculum)
- **Thực tế trên 2 ảnh chuẩn Domain 05**:
  - **`05_course_detail_01_overview_about.png` (Course Overview)**:
    - Ảnh bìa 3D tràn viền trên (`course_dino.png`) với nút Back tròn (trái) và nút Trái tim yêu thích tròn (phải).
    - Khung nội dung trắng bo góc trên (`ClayWaveSheet` / `ClayCard` lớn): Tiêu đề `"Amazing Animals"`, mô tả ngắn, **3 chip thông số** (`Science`, `Ages 7–10`, `5 Lessons`), dòng sao `4.8 (320 reviews)`, mục `"About This Course"`, **4 ô vuông tính năng** (`Fun Videos`, `Interactive Quizzes`, `Activity Sheets`, `Earn Badges`), và nút CTA đáy `"Start Learning"`.
  - **`05_course_detail_02_curriculum_lessons.png` (Course Curriculum & Tabs)**:
    - Khi bấm `"Start Learning"` từ màn Overview (hoặc mở danh sách bài học), giao diện hiển thị Header thu gọn (Nút Back + Thumbnail nhỏ `64×64dp` + `"Amazing Animals"` + `"5 Lessons • Science"`).
    - Thanh 3 Tabs dạng Pill: **`Lessons`** (active Indigo) | **`About`** | **`Reviews`**.
    - Danh sách 5 bài học của *Amazing Animals* với đúng tên và thời lượng:
      1. `Meet the Animals` (`10 min`) — Đã hoàn thành (Nút tròn xanh lá có dấu tick `✓`).
      2. `Animals and Their Habitats` (`12 min`) — Đang mở khóa (Nút tròn tím có mũi tên `>`).
      3. `Food and Eating Habits` (`10 min`) — Đang khóa (Nút tròn xám có ổ khóa `🔒`).
      4. `Animal Life Cycles` (`15 min`) — Đang khóa (`🔒`).
      5. `How We Can Help` (`10 min`) — Đang khóa (`🔒`).
    - Cuối danh sách là Banner thưởng màu kem vàng: Icon Cúp vàng 3D + `"Complete all lessons to earn a special badge!"` + Huy hiệu Khủng long.

### 🛠️ Phát hiện 5: Backend Đã Có Sẵn Skeleton Tại `backend/app/modules/courses/` — Cấm Đập Đi Xây Lại (Ponytail Rule)
- **Hiện trạng Codebase**: Trong `backend/app/modules/courses/` đã có sẵn 5 file (`models.py`, `schemas.py`, `router.py`, `service.py`, `repository.py`) được mount vào `/api/v1/courses` tại `main.py`!
- **Chỉ thị của Tech Lead (YAGNI / Ponytail)**:
  1. **Giữ nguyên cấu trúc trả về `List[CourseCardResponse]`** của `GET /api/v1/courses` (không bọc thêm lớp `{total, page, items}` rườm rà và không tạo endpoint `/api/v1/subjects` thừa thãi vì danh sách môn học là cố định trên UI).
  2. **Mở rộng nhẹ trên code sẵn có**:
     - Bổ sung cột `level` (`beginner`, `intermediate`, `advanced`) vào model `Course` và schema `CourseCardResponse`.
     - Bổ sung tham số lọc `min_age`, `max_age`, `level`, `duration` (`short`, `medium`, `long`) vào `GET /api/v1/courses`.
     - Bổ sung trường `is_unlocked: bool` vào `LessonItemResponse` (mặc định bài 1 & 2 mở khóa hoặc tính theo tiến độ).
  3. **Alembic Migration `0002`**: Vì migration `0001` mới chỉ tạo bảng `users` và `kid_profiles`, Dev BE bắt buộc tạo file `backend/alembic/versions/0002_courses_and_lessons.py` để tạo bảng `courses`, `lessons`, `user_progress` và seed sẵn 6 khóa học + 5 bài giảng chuẩn benchmark.

### 🛠️ Phát hiện 6: Kiến Trúc Điều Hướng Tab `Courses` Trên `HomeScreen` (`IndexedStack`)
- **Hiện trạng Codebase**: Tại `lib/features/home/presentation/home_screen.dart` (dòng 53), khi người dùng chọn `"Khám phá khóa học"` từ hộp thoại Empty Sessions, code đang gọi:
  ```dart
  setState(() => _currentNavIndex = ClayNavTab.courses.index);
  ```
- **Chỉ thị của Tech Lead**:
  - Không tách `CoursesHubScreen` thành route độc lập đẩy đè lên `HomeScreen` khi bấm Bottom Nav (vì sẽ gây nhân đôi thanh `ClayBottomNav` và mất trạng thái cuộn).
  - Sử dụng `IndexedStack` (hoặc body switcher) ngay trong `HomeScreen`:
    - `_currentNavIndex == 0`: Hiển thị `HomeDashboardBody`.
    - `_currentNavIndex == 1`: Hiển thị `CoursesHubBody` (`04_courses_01`).
  - Các màn hình con (`CourseSearchScreen` `04_courses_02`, `CourseFilterScreen` `04_courses_03`, `AllCoursesGridScreen` `04_courses_04`, `CourseDetailScreen` `05_course_detail_01 & 02`) được khai báo trong `AppRouter` và điều hướng bằng `context.router.push(...)`.

### 🛠️ Phát hiện 7: Chiến Lược Tài Nguyên Ảnh 3D Cục Bộ (Zero Broken Images)
- Để đảm bảo tốc độ dựng hình **60 FPS** và **100% widget tests chạy offline không phụ thuộc mạng**:
  - Dev FE ánh xạ các ảnh 3D cục bộ sẵn có trong `assets/images/` (`course_dino.png`, `mascot_boy_waving.png`, `mascot_star_goal.png`, `avatar_lion.png`, `zodiac_dragon.png`, `zodiac_monkey.png`, `zodiac_tiger.png`, v.v.) hoặc trích xuất thumbnail từ `assets/design_references/` vào `AppAssets`.
  - Tuyệt đối không dùng URL mạng giả (`https://...`) trong widget UI gây lỗi `NetworkImageLoadException` khi chạy `flutter test`.

---

## ✅ 2. Hồ Sơ Phê Duyệt Khả Thi Kỹ Thuật (Technical Feasibility Sign-Off)

```markdown
## ✅ PHÊ DUYỆT KHẢ THI KỸ THUẬT (Technical Feasibility Sign-Off)
- **Tech Lead**: Sub-Agent Tech Lead — "The Pragmatic System Architect"
- **Trạng thái**: APPROVED FOR SPRINT 5 EXECUTION
- **Phương án kiến trúc**: 
  - FE: Feature-First Clean Architecture tại `lib/features/exploration/`, tích hợp Tab 1 vào `HomeScreen` qua `IndexedStack`, tuân thủ 100% Ponytail (< 200 dòng/file).
  - BE: Mở rộng trực tiếp module `backend/app/modules/courses/` hiện hữu + Alembic Migration `0002` seed 6 khóa học benchmark.
- **Cam kết SLAs**: 
  - Chuyển tab Home <-> Courses: <= 16ms (1 frame).
  - Lọc & tìm kiếm khóa học: <= 50ms.
  - Khung hình cuộn lưới 2 cột: 60 FPS (bắt buộc bọc `RepaintBoundary` cho từng `CourseClayCard`).
  - 0 RenderFlex overflow trên màn 360x640 với textScaler 1.5x.
```


---

## 3. Phụ Lục Rà Soát Vòng 2 (Backend, Rủi Ro & Điểm Mở)

### 3.1. Khoảng trống Backend phải xử lý ở WBS-S5-01 / S5-06
| # | Hiện trạng trong repo | Hành động bắt buộc |
| :---: | :--- | :--- |
| 1 | `models.py`: `Course` thiếu `level`, `subtitle`; `Lesson` thiếu `thumbnail_url`, `is_unlocked`, `is_completed` | Bổ sung cột + schema tương ứng, giữ nguyên cấu trúc module |
| 2 | `schemas.py`: `CourseFilterParams` đang là class chết, router không dùng | Xóa hoặc dùng thật; không để dead code (Ponytail) |
| 3 | `service.py` hardcode `is_completed=False` | Đọc từ cột seed (Sprint 5), không giả lập trong service |
| 4 | `main.py` chạy `Base.metadata.create_all` trong `lifespan`, song song với Alembic | Bảng `courses`/`lessons` PHẢI vào migration `0002`; không dựa vào `create_all` để tạo bảng ở môi trường chung |
| 5 | `models.py` có `UserProgress` nhưng migration chưa có và Sprint 5 không dùng | Không đưa vào `0002` (YAGNI), dời Sprint 6 |
| 6 | Router chưa có tham số `min_age`, `max_age`, `level`, `duration` | Bổ sung; `duration` quy đổi từ `total_lessons` ở tầng repository |

### 3.2. Rủi ro kỹ thuật
| Mã | Mô tả | Giảm thiểu |
| :---: | :--- | :--- |
| `RSK-011` | `HomeScreen` hiện là `StatefulWidget` 130 dòng; thêm tab Courses dễ vượt giới hạn 200 dòng | Tách `HomeDashboardBody` ra widget riêng trước khi thêm `CoursesHubBody` |
| `RSK-012` | Ảnh 3D benchmark (khủng long, phi hành gia, robot, trái đất...) **chưa có asset runtime**; `assets/images` chỉ có `course_dino.png` làm ảnh khóa học | Cần UI/UX tạo/tách asset trước khi Dev FE hoàn thiện 1:1; tạm dùng asset sẵn có nhưng đánh dấu rõ là placeholder, KHÔNG gán nhầm mascot làm ảnh khóa học rồi báo hoàn thành |
| `RSK-013` | Tab `About`/`Reviews` không có benchmark | Chờ PO chốt (PRD FEAT-07 mục 3) |
| `RSK-014` | `HomeScreen` đang điều hướng tab `Tests` sang `TodayLearningGoalRoute`; thêm tab Courses không được làm vỡ hành vi này | Test hồi quy bắt buộc |

### 3.3. Ước lượng cần PO/SM xác nhận
- Màn Filter thực tế là **một màn đầy đủ 4 nhóm / 20+ chip**, không phải sheet nhỏ; cộng thêm refactor `HomeScreen` (RSK-011) và tạo asset (RSK-012).
- Tech Lead đánh giá **US-16 (4 SP) và US-18 (3 SP) có nguy cơ thiếu**; đề nghị tối thiểu +1 SP cho US-16 và có phương án cắt `Course Duration` nếu trễ. Quyết định ngân sách SP thuộc PO và đội, Tech Lead chỉ cảnh báo.

### 3.4. Đính chính
Bản Gherkin, `AppStrings` và API spec soạn ở vòng trước **chưa đối chiếu ảnh benchmark** (sai: filter chỉ 3 nhóm, thiếu nút tim, search/filter đặt sai chỗ). Toàn bộ đã được viết lại ở vòng review này; các bản cũ không còn hiệu lực.

### 3.5. Cập Nhật Sau Quyết Định Của PO (29/10)
- Bài học và asset ở mức **demo**; sản xuất nội dung/asset thật dời sang các Sprint sau.
- `RSK-012` hạ từ blocker xuống **ACCEPTED**: dùng asset sẵn có làm placeholder.
- `RSK-013` **RESOLVED**; 3 câu hỏi mở ở PRD FEAT-07 đã chốt theo đề xuất Tech Lead.
- Tech Lead đề nghị mở một Epic riêng "Lesson Content & Asset Production" trong backlog để chi phí này hiện rõ và không bị che trong Sprint 6 trở đi.
- **Trạng thái Gate 0: APPROVED để giao Dev**, còn lại cảnh báo ước lượng US-16/US-18 (mục 3.3) và `RSK-011`, `RSK-014`.
