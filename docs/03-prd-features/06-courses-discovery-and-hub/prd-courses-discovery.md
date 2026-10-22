# Đặc Tả Tính Năng (PRD): Khám Phá & Lưới Khóa Học (FEAT-06)

- **Mã tính năng**: `FEAT-06`
- **Tên tính năng**: Courses Discovery Hub, Categories & Filter Sheet
- **Module**: `features/exploration`
- **Sub-Agent Quản trị**: Sub-Agent BA & Sub-Agent PO
- **Trạng thái**: 🟡 **Planned for Sprint 4** (`v0.4.0`)
- **Tài sản đối sánh Dribbble**: `assets/design_references/screens/04_courses_01_explore_and_categories.png` đến `04_courses_04_all_courses_grid.png`

---

## 1. Bối Cảnh & Mục Tiêu Nghiệp Vụ

### 1.1. Bối Cảnh
Khám phá khóa học là động cơ cốt lõi (Core Engine) của ứng dụng giáo dục. Trẻ cần một không gian tìm kiếm kích thích thị giác, dễ dàng lọc các môn học yêu thích (Toán học, STEM, Nghệ thuật, Ngôn ngữ) và chọn bài học phù hợp với lứa tuổi của mình.

### 1.2. Chỉ Số Đo Lường (KPIs)
- **Course Discovery Rate**: $\ge 70\%$ học sinh tìm thấy và mở chi tiết ít nhất 1 khóa học trong vòng 3 phút.
- **Search Latency**: Thời gian lọc tìm kiếm cục bộ $\le 100\text{ms}$.
- **Filter Friction**: Bộ lọc Bottom Sheet giải quyết được nhu cầu lọc theo độ tuổi (6-8, 9-10, 11-12) với $\le 2$ lần chạm.

---

## 2. Phạm Vi Tính Năng (Feature Scope)
1. **Explore Header & Clay Search Bar**: Thanh tìm kiếm bo cong mềm mại với icon kính lúp, hỗ trợ tìm kiếm theo tên khóa học hoặc từ khóa (*"Space"*, *"Animals"*, *"Math"*).
2. **Subject Category Chips**: Dải chip môn học nằm ngang (*All, Science, Math, Language, Arts*) với hiệu ứng chọn đổi màu và nảy bóng.
3. **2-Column Courses Grid**: Lưới 2 cột hiển thị các thẻ khóa học dạng đất sét 3D nổi bật: Hình ảnh minh họa 3D, tên khóa học, số bài học, độ tuổi phù hợp và số sao đánh giá.
4. **Filter Bottom Sheet**: Bảng lọc đa tiêu chí dạng chip đất sét: Lọc theo độ tuổi (Ages 6-8, 9-10, 11-12), Cấp độ (Beginner, Intermediate, Advanced), Nút [Clear All] và [Apply Filters].
