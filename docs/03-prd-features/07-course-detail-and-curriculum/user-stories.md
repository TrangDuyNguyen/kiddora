# Kịch Bản BDD User Stories: Chi Tiết Khóa Học (FEAT-07)

- **Feature**: `FEAT-07` — Course Overview & Lessons Curriculum
- **Tác giả**: Sub-Agent BA, rà soát bởi Tech Lead (Gate 0)

---

## US-08: Xem Tổng Quan & Lộ Trình Khóa Học

**Là một** học sinh vừa chọn khóa học, **tôi muốn** xem tổng quan và danh sách bài học, **để** biết mình sẽ học gì.

### Kịch Bản 1: Xem tổng quan khóa học
- **Given** người dùng chạm thẻ `Amazing Animals`.
- **Then** mở `CourseOverviewScreen` với ảnh bìa 3D, 3 pill (`Science`, `Ages 7–10`, `5 Lessons`), `4.8 (320 reviews)`, mục `About This Course`, 4 ô tính năng và nút `Start Learning`.

### Kịch Bản 2: Vào lộ trình bài học
- **Given** người dùng ở màn tổng quan.
- **When** chạm `Start Learning`.
- **Then** mở `CourseCurriculumScreen` với 3 tab, tab `Lessons` active và 5 bài học.
- *(Phụ thuộc quyết định #1 của PO tại PRD FEAT-07.)*

### Kịch Bản 3: Trạng thái từng bài học
- **Given** dữ liệu seed Sprint 5.
- **Then** bài 1 hiển thị tick xanh, bài 2 hiển thị chevron tím, bài 3–5 hiển thị ổ khóa.

### Kịch Bản 4: Chạm bài bị khóa
- **When** chạm bài 3.
- **Then** hiển thị `lessonLockedAlert`, vẫn ở màn hiện tại.

### Kịch Bản 5: Chuyển tab
- **When** chạm tab `About` rồi `Reviews`.
- **Then** nội dung đổi tương ứng, không rebuild lại toàn màn hình.

### Kịch Bản 6: Khóa học không tồn tại
- **Given** API trả 404.
- **Then** hiển thị đúng chuỗi `detail` từ Backend.
