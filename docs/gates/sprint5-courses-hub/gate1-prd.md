# Gate 1: Đặc Tả Yêu Cầu Nghiệp Vụ (PRD Sign-off)
## Sprint 5 — Phân Hệ Khám Phá Khóa Học & Chi Tiết Giáo Trình (`v0.5.0-courses-hub`)

- **Sub-Agent Lập PRD**: Sub-Agent Business Analyst (BA) — *"The Pedantic Logician"*
- **Sub-Agent Phê Duyệt**: Sub-Agent Product Owner (PO) — *"The Strategic Tyrant"* & Sub-Agent Tech Lead
- **Ngày**: 2026-10-30
- **Trạng thái**: 🟢 **APPROVED (GATE 1 PASSED)**

---

## 1. Mục Tiêu & Phạm Vi Bàn Giao (23 SP — Phương Án A)
Hiện thực hóa 6 màn hình chuẩn đối sánh 1:1 Design References Dribbble:
1. `04_courses_01`: Courses Hub (`CoursesHubBody` trong `HomeScreen`)
2. `04_courses_02`: Search Results (`CourseSearchScreen`)
3. `04_courses_03`: Multi-Criteria Filter (`CourseFilterScreen`)
4. `04_courses_04`: All Courses Grid (`AllCoursesGridScreen`)
5. `05_course_detail_01`: Course Overview (`CourseDetailScreen`)
6. `05_course_detail_02`: Lessons Curriculum (`CourseCurriculumScreen`)

---

## 2. Tiêu Chí Nghiệm Thu BDD (Given-When-Then)

### US-16: Courses Hub & Grid View
- **Given**: Người dùng chọn tab Khóa học (`ClayNavTab.courses`).
- **When**: Giao diện được dựng.
- **Then**: Hiển thị tiêu đề "Khóa học", phụ đề "Khám phá, Học tập & Lớn khôn!", nút tìm kiếm tròn, Hero Banner "Tương lai tươi sáng bắt đầu từ đây!", 5 thẻ danh mục môn học (`All`, `Science`, `Math`, `Language`, `Arts`) và lưới 2 cột Khóa học nổi bật.

### US-17: Real-time Course Search Screen
- **Given**: Người dùng mở màn hình Tìm kiếm Khóa học.
- **When**: Nhập từ khóa tìm kiếm (VD: "Space").
- **Then**: Hệ thống debounce 300ms và hiển thị danh sách khóa học khớp với từ khóa kèm số lượng kết quả `Search Results (N)`.

### US-18: Multi-Criteria Filter Screen
- **Given**: Người dùng mở màn hình Bộ lọc.
- **When**: Chọn các chip lọc theo 4 chiều: Chủ đề (7 môn), Độ tuổi (7-8, 9-10, 11-12), Cấp độ (Beginner/Intermediate/Advanced), Thời lượng (Short/Medium/Long).
- **Then**: Bấm "Áp dụng bộ lọc" cập nhật danh sách hiển thị; bấm "Xóa bộ lọc" đưa tất cả về mặc định.

### US-19: Course Detail & Curriculum
- **Given**: Người dùng chọn một khóa học từ danh sách.
- **When**: Màn hình Chi tiết hiển thị.
- **Then**: Thấy ảnh bìa 3D, nút Back/Yêu thích, 3 chip thông số, đánh giá sao, 4 ô tính năng và nút "Bắt đầu học ngay". Khi bấm "Bắt đầu học ngay", chuyển sang màn Giáo trình gồm 3 tab (`Bài học`, `Giới thiệu`, `Đánh giá`), danh sách bài học có trạng thái và banner huy hiệu thưởng.

---

## 3. Chữ Ký Phê Duyệt Gate 1
- **Sub-Agent BA**: *"Đã đặc tả 100% chi tiết nghiệp vụ và BDD Given-When-Then, hoàn toàn loại bỏ sự mơ hồ."* — `[APPROVED]`
- **Sub-Agent PO**: *"Phê duyệt phạm vi 6 màn hình chuẩn 1:1, không scope creep."* — `[APPROVED]`
- **Sub-Agent Tech Lead**: *"Kiến trúc Feature-First Clean Architecture khả thi và đáp ứng ngân sách SLAs."* — `[APPROVED]`

