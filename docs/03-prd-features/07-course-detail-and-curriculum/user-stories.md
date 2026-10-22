# Kịch Bản BDD User Stories: Chi Tiết Khóa Học (FEAT-07)

- **Feature**: `FEAT-07` — Course Detail & Lessons Curriculum
- **Tác giả**: Sub-Agent BA — *"The Pedantic Logician"*

---

## User Story US-08: Xem Lộ Trình Bài Học & Bắt Đầu Học

**Là một** học sinh vừa chọn một khóa học ưng ý,  
**Tôi muốn** xem danh sách các bài giảng trong khóa và bấm bắt đầu học,  
**Để** tiến vào trình phát bài học và chinh phục kiến thức mới.

### Kịch Bản 1: Chuyển đổi giữa các tab Lessons, About, Reviews
- **Given** người dùng đang ở `CourseDetailScreen` tại tab *"Lessons"*.
- **When** người dùng chạm vào tab *"About"*.
- **Then** nội dung danh sách bài giảng chuyển sang đoạn giới thiệu tóm tắt và mục tiêu khóa học.

### Kịch Bản 2: Nhấn nút bắt đầu học (Start Learning CTA)
- **Given** người dùng đang xem chi tiết khóa học *"Amazing Animals"*.
- **When** người dùng chạm vào nút [Start Learning] ở thanh đáy.
- **Then** ứng dụng mở bài học đầu tiên (*"Meet the Animals"*) trong trình phát bài giảng `LessonPlayerScreen`.

### Kịch Bản 3: Chọn bài học cụ thể trong danh sách
- **Given** danh sách các bài giảng hiển thị với trạng thái đã mở khóa.
- **When** người dùng chạm vào bài học thứ 2 (*"Animals & Habitats"*).
- **Then** bài học được chọn kích hoạt và bắt đầu phát nội dung tương tác.
