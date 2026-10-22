# Kịch Bản BDD User Stories: Mục Tiêu Hàng Ngày (FEAT-05)

- **Feature**: `FEAT-05` — Today's Learning Goal & Daily Gamified Progress
- **Tác giả**: Sub-Agent BA — *"The Pedantic Logician"*

---

## User Story US-06: Hoàn Thành Nhiệm Vụ Mục Tiêu Hàng Ngày

**Là một** học sinh nhỏ tuổi muốn chinh phục thử thách ngày,  
**Tôi muốn** xem các nhiệm vụ cần làm và đánh dấu khi hoàn thành,  
**Để** tăng tiến độ vòng tròn và nhận lời khen từ linh vật.

### Kịch Bản 1: Đánh dấu hoàn thành nhiệm vụ
- **Given** người dùng đang ở `TodayLearningGoalScreen` với tiến độ hiện tại là 3/5 nhiệm vụ.
- **When** người dùng chạm vào ô checkbox của nhiệm vụ thứ 4 (*"Read 1 Story"*).
- **Then** checkbox chuyển sang màu xanh mint kèm dấu tick trắng, vòng tròn tiến độ nhảy mượt mà từ 3/5 lên 4/5, thiết bị rung nhẹ xúc giác.

### Kịch Bản 2: Hoàn thành toàn bộ 5/5 nhiệm vụ trong ngày
- **Given** người dùng đã hoàn thành 4/5 nhiệm vụ.
- **When** người dùng tích chọn nhiệm vụ cuối cùng.
- **Then** vòng tròn tiến độ chuyển sang 100%, xuất hiện hiệu ứng pháo giấy chúc mừng và cộng điểm sao thưởng.

### Kịch Bản 3: Trở về Trang chủ
- **Given** người dùng đang ở `TodayLearningGoalScreen`.
- **When** người dùng chạm vào nút Back (`<`) ở góc trên bên trái.
- **Then** màn hình đóng lại và đưa người dùng trở về `HomeScreen`.
