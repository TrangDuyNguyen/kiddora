# Đặc Tả Tính Năng (PRD): Mục Tiêu Học Tập Hàng Ngày (FEAT-05)

- **Mã tính năng**: `FEAT-05`
- **Tên tính năng**: Today's Learning Goal & Daily Gamified Progress
- **Module**: `features/home/presentation/today_learning_goal_screen.dart`
- **Sub-Agent Quản trị**: Sub-Agent BA & Sub-Agent PO
- **Trạng thái**: 🟢 **Completed & Released** (`v0.3.0`)
- **Tài sản đối sánh Dribbble**: `assets/design_references/screens/03_home_02_todays_learning_goals.png`

---

## 1. Bối Cảnh & Mục Tiêu Nghiệp Vụ

### 1.1. Bối Cảnh
Trẻ em cần những cột mốc trực quan và ngắn hạn để không cảm thấy việc học là gánh nặng. Màn hình Mục tiêu Học tập hàng ngày sử dụng cơ chế Trò chơi hóa (Gamification) với vòng tròn tiến độ 3D *"3 of 5 Tasks Completed"*, danh sách nhiệm vụ có checkbox xúc giác và linh vật động viên giơ ngón tay cái khích lệ.

### 1.2. Chỉ Số Đo Lường (KPIs)
- **Task Interaction Response**: Chạm vào checkbox phản hồi rung Haptic squish tức thì $\le 16\text{ms}$.
- **Goal Completion Rate**: Đạt $\ge 60\%$ học sinh hoàn thành ít nhất 3/5 nhiệm vụ hàng ngày.
- **Engagement Duration**: Trẻ dành trung bình $15 - 25\text{ phút}$ học tập trên app mỗi ngày.

---

## 2. Phạm Vi Tính Năng (Feature Scope)
1. **3D Progress Circle Indicator**: Vòng tròn đo tiến độ 3D viền dày đất sét, hiển thị tỷ lệ hoàn thành (VD: 60%) và số lượng nhiệm vụ đạt được (3/5).
2. **Interactive Tasks Checklist**: 5 thẻ nhiệm vụ hàng ngày có checkbox đất sét bo cong, tự động gạch ngang và đổi màu xanh khi hoàn thành.
3. **Motivational Mascot Banner**: Bé trai linh vật đất sét giơ ngón cái cùng lời khen tặng (*"Awesome job, Keil! Keep it up!"*).
4. **Header Navigation**: Nút quay lại (`<`) trở về Trang chủ và tiêu đề trang rõ ràng.
