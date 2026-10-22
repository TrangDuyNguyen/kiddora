# Kịch Bản BDD User Stories: Trang Chủ Học Sinh (FEAT-04)

- **Feature**: `FEAT-04` — Student Home Dashboard
- **Tác giả**: Sub-Agent BA — *"The Pedantic Logician"*

---

## User Story US-05: Khám Phá Trang Chủ Học Sinh

**Là một** học sinh nhỏ tuổi đăng nhập vào Kiddora,  
**Tôi muốn** nhìn thấy ngay lộ trình học tập, bài học đang dở và buổi học Live tiếp theo,  
**Để** tiếp tục học tập ngay mà không bị bỡ ngỡ.

### Kịch Bản 1: Xem tóm tắt tiến độ và mở mục tiêu hàng ngày
- **Given** người dùng đang ở `HomeScreen`.
- **When** người dùng chạm vào thẻ *"My Progress"*.
- **Then** màn hình chuyển hướng sang `TodayLearningGoalScreen` để xem chi tiết 5 nhiệm vụ hàng ngày.

### Kịch Bản 2: Tiếp tục khóa học đang học (Continue Learning)
- **Given** thẻ *"Amazing Animals"* hiển thị tiến độ 60%.
- **When** người dùng chạm vào nút [Continue] hoặc thân thẻ.
- **Then** ứng dụng mở trực tiếp bài học kế tiếp trong khóa học.

### Kịch Bản 3: Tham gia lớp học trực tiếp sắp diễn ra
- **Given** thẻ *"Upcoming Live Class"* hiển thị lớp cùng Coach Sarah.
- **When** người dùng chạm vào nút [Join].
- **Then** ứng dụng chuyển hướng đến phòng chờ hoặc phòng học trực tuyến Live Classroom.
