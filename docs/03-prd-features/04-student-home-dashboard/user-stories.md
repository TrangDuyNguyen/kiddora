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

### Kịch Bản 4: Xác nhận Đăng xuất qua Hộp thoại 3D Clay (`ClayDialog.showLogout`)
- **Given** người dùng đang ở `HomeScreen` và chạm vào nút tròn Đăng xuất trên `HomeHeader`.
- **When** hộp thoại *"Đăng xuất?"* xuất hiện với minh họa cửa 3D (`modal_logout_door.png`), nút *"Đồng ý đăng xuất"* và *"Hủy bỏ"*.
- **Then** nếu chọn *"Hủy bỏ"* hoặc nút đóng `×`, hộp thoại đóng lại và giữ nguyên phiên; nếu chọn *"Đồng ý đăng xuất"*, hệ thống xóa sạch token trong `TokenStorage`, tắt chế độ Guest và điều hướng về `LoginRoute`.

### Kịch Bản 5: Trạng thái trống Buổi học (`ClayDialog.showEmptySessions`)
- **Given** người dùng chạm vào tab *"Sessions"* trên `ClayBottomNav` khi chưa có lịch học sắp tới.
- **When** hộp thoại *"Chưa có buổi học!"* xuất hiện với minh họa lịch 3D (`modal_empty_sessions.png`).
- **Then** người dùng có thể chọn *"Khám phá khóa học"* để chuyển sang tab *"Courses"* hoặc *"Để sau nhé"* để đóng hộp thoại.
