# Đặc Tả Tính Năng (PRD): Trang Chủ Học Sinh (FEAT-04)

- **Mã tính năng**: `FEAT-04`
- **Tên tính năng**: Student Home Dashboard & Daily Habit Loop
- **Module**: `features/home/presentation/home_screen.dart`
- **Sub-Agent Quản trị**: Sub-Agent BA & Sub-Agent PO
- **Trạng thái**: 🟢 **Completed & Released** (`v0.3.0`)
- **Tài sản đối sánh Dribbble**: `assets/design_references/screens/03_home_01_student_dashboard.png`

---

## 1. Bối Cảnh & Mục Tiêu Nghiệp Vụ

### 1.1. Bối Cảnh
Trang Chủ là trung tâm điều khiển (Cockpit) hàng ngày của bé. Khi mở ứng dụng, bé nhìn thấy ngay lời chào cá nhân hóa, tóm tắt tiến độ học tập, bài học đang dở dang để học tiếp không bị ngắt quãng, và lịch buổi học trực tuyến Live Class sắp diễn ra.

### 1.2. Chỉ Số Đo Lường (KPIs)
- **Time to First Action**: Trẻ chạm vào bài học hoặc live class trong vòng $\le 5\text{ giây}$ sau khi vào app.
- **Daily Revisit Rate (D1/D7 Retention)**: Đạt $\ge 45\%$.
- **Navigation Fluidity**: Chuyển đổi tab trên Bottom Navigation đạt mượt mà $60\text{ FPS}$.

---

## 2. Phạm Vi Tính Năng (Feature Scope)
1. **Personalized Welcome Banner**: Lời chào thân mật kèm vương miện đất sét (*"Hi, Keil! Great to see you again!"*).
2. **Quick Progress Summary Row**: 3 thẻ tóm tắt nhanh về Tiến độ học tập tổng thể, Số khóa học đang theo học, và Buổi học sắp tới.
3. **Continue Learning Card**: Thẻ khóa học nổi bật (*Amazing Animals*), thanh tiến độ phần trăm ($60\%$), và nút tiếp tục học.
4. **Upcoming Live Class Card**: Thẻ thông tin buổi học trực tiếp cùng Coach Sarah, đếm ngược giờ và nút `ClayButton.compact` (`[Join]`).
5. **Tactile Clay Bottom Navigation**: Thanh điều hướng đáy 5 mục chuẩn `shared/ui_kit/navigation/clay_bottom_nav.dart` (*Home, Courses, Sessions, Tests, Profile*), mỗi tab đảm bảo vùng chạm $\ge 48 \times 48\text{ dp}$.
6. **Tactile Clay Modal Interactions (`ClayDialog`)**: Hộp thoại xác nhận đăng xuất (*"Đăng xuất?"* kèm xóa sạch `TokenStorage`) và hộp thoại trạng thái trống khi chưa có buổi học (*"Chưa có buổi học!"* điều hướng sang tab *Courses*).
