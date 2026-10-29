# Đặc Tả Tính Năng (PRD): Khám Phá & Lưới Khóa Học (FEAT-06)

- **Mã tính năng**: `FEAT-06`
- **Tên tính năng**: Courses Hub, Search, Filter Courses & All Courses Grid
- **Module**: `features/exploration`
- **Sub-Agent Quản trị**: Sub-Agent BA & Sub-Agent PO
- **Trạng thái**: 🟡 **Sprint 5** (`v0.5.0-courses-hub`) — Đã qua Gate 0 Tech Lead Review ([gate0-tech-lead-review.md](file:///Users/nguyenduytrang/flutter_project/kiddora/docs/gates/sprint5-courses-hub/gate0-tech-lead-review.md))
- **Tài sản đối sánh Dribbble (1:1)**:
  - `04_courses_01_explore_and_categories.png` (Courses Hub)
  - `04_courses_02_search_courses.png` (Search Courses)
  - `04_courses_03_filter_courses_sheet.png` (Filter Courses)
  - `04_courses_04_all_courses_grid.png` (All Courses Grid)

---

## 1. Bối Cảnh & Mục Tiêu Nghiệp Vụ

### 1.1. Bối Cảnh
Khám phá khóa học là động cơ cốt lõi của ứng dụng. Trẻ cần một không gian kích thích thị giác để tìm môn học yêu thích và chọn bài học phù hợp lứa tuổi.

### 1.2. Chỉ Số Đo Lường (KPIs)
- **Course Discovery Rate**: $\ge 70\%$ học sinh mở chi tiết ít nhất 1 khóa học trong 3 phút.
- **Search/Filter Latency**: lọc cục bộ $\le 50\text{ms}$.
- **Filter Friction**: chọn nhóm tuổi và áp dụng bộ lọc $\le 3$ lần chạm.

---

## 2. Phạm Vi Tính Năng (Theo Đúng Ảnh Benchmark)

### 2.1. Màn `CoursesHub` (`04_courses_01`) — Tab `Courses` của `ClayBottomNav`
1. **Header**: tiêu đề `Courses`, phụ đề `Explore, Learn and Grow!`, **nút tròn kính lúp** bên phải (mở màn Search).
2. **Hero Banner**: thẻ tím pastel `A Brighter Future Starts Here!` + linh vật bé trai vẫy tay + ngôi sao.
3. **Category Cards (5 ô)**: `All`, `Science`, `Math`, `Language`, `Arts` — icon phía trên, nhãn phía dưới, ô `All` active mặc định.
4. **Popular Courses**: tiêu đề + nút `See All`; lưới 2 cột 4 thẻ (`Amazing Animals`, `Space Exploration`, `Math Fun with Numbers`, `Creative Drawing`), mỗi thẻ có ảnh 3D, môn, số bài, độ tuổi, nút tròn tím `>`.

### 2.2. Màn `CourseSearch` (`04_courses_02`)
1. Nút Back tròn, tiêu đề `Search Courses`, phụ đề `Find the perfect course for you!`.
2. Ô tìm kiếm bo cong có icon kính lúp và nút xóa (`x`).
3. Tiêu đề `Search Results (N)`; danh sách thẻ ngang: ảnh trái, tên, môn, số bài, tuổi, chevron phải.

### 2.3. Màn `CourseFilter` (`04_courses_03`) — **4 chiều lọc**
1. Header: Back, `Filter Courses`, nút chữ `Clear All`.
2. `Program / Category`: All, Science, Mathematics, Language, Arts & Creativity, Technology, Life Skills.
3. `Age Group`: All, 7 – 8, 9 – 10, 11 – 12.
4. `Difficulty Level`: All, Beginner, Intermediate, Advanced.
5. `Course Duration`: All, Short (1–3 lessons), Medium (4–6 lessons), Long (7+ lessons).
6. Nút đáy `Apply Filters` full-width.

### 2.4. Màn `AllCoursesGrid` (`04_courses_04`)
1. Header `All Courses` + phụ đề `Explore and find your favorite courses!` + nút kính lúp tròn.
2. Dải chip ngang `All`, `Science`, `Math`, `Arts`.
3. Lưới 2 cột 6 khóa học (thêm `Our Planet`, `Intro to Technology`); mỗi thẻ có **nút tim yêu thích** góc phải ảnh.

---

## 3. Quyết Định Kỹ Thuật Đã Chốt (Gate 0)
- Tab `Courses` render **bên trong `HomeScreen`** (body switcher/`IndexedStack`), không đẩy route đè để tránh nhân đôi `ClayBottomNav`.
- Search, Filter, AllCoursesGrid là route `AutoRoute` riêng.
- Dữ liệu qua `GET /api/v1/courses` (xem [API spec](file:///Users/nguyenduytrang/flutter_project/kiddora/docs/04-specifications/specs/2026-10-30-courses-catalog-api-spec.md)).

## 4. Ngoài Phạm Vi Sprint 5
- Lưu yêu thích lên server (nút tim chỉ đổi trạng thái cục bộ trong phiên).
- Trình phát bài giảng (Domain 06 — Sprint 6).
