# Đặc Tả Giao Diện UI/UX Specs: Trang Chủ Học Sinh (FEAT-04)

- **Feature**: `FEAT-04`
- **Sub-Agent**: Sub-Agent UI/UX Designer
- **Asset đối sánh Dribbble**: `assets/design_references/screens/03_home_01_student_dashboard.png`

---

## 🎨 1. Bố Cục Lưới 4pt & Tokens Thành Phần

- **Top Bar (`HomeHeader`)**: Avatar bé tròn đường kính $48\text{ dp}$ (nhấn để chuyển sang Tab 4 Profile), huy hiệu sao tích lũy `StarCounterBadge` ($140\text{ Stars}$), chuông thông báo có chấm đỏ và nút đăng xuất.
- **3-Slide Tactile Clay Hero Carousel (`HomeHeroBanner`)**: Chiều cao `AppValues.sizeHomeHeroH` ($166\text{ dp}$), bo góc `AppValues.radiusXl` ($24\text{ dp}$), bố cục `Row` tỷ lệ `6:4` (trái: Tiêu đề + Mô tả + Nút tròn trắng + Pill Dots chỉ báo trang; phải: Nhân vật 3D đất nặn RGBA 32-bit trong suốt `BoxFit.contain`):
  - **Slide 1 (Daily Goal)**: Gradient tím Lavender (`heroGradientStart/Mid/End`), nhân vật `mascot_boy_crown.png` không viền hộp, mở `TodayLearningGoalRoute`.
  - **Slide 2 (Mini-Game Playground)**: Gradient xanh Indigo-Cyan (`heroGameGradStart/Mid/End`), icon `icon_test_bag_3d.png`, gộp trực tiếp `HomeMiniGameBanner` vào carousel giúp tiết kiệm $90\text{ dp}$ chiều dọc, mở `MiniGamePlaygroundRoute`.
  - **Slide 3 (Science Quest)**: Gradient xanh Emerald-Teal (`heroQuestGradStart/Mid/End`), mascot `avatar_dino.png`, mở trực tiếp `LessonPlayerRoute`.
- **Quick Stats 2x2 Grid (`HomeQuickStatsGrid`)**: 4 thẻ `ClayCard` tương tác xúc giác (`My Progress` -> `TodayLearningGoalRoute`, `Current Courses` -> Tab 1, `Upcoming Session` -> Tab 2, `My Badges` -> Tab 4).
- **Continue Learning Card (`HomeContinueLearningCard`)**: Bọc `ClayCard`, ảnh `course_dino.png` RGBA sạch không dính chữ cắt cụt, thanh tiến độ `ClayProgressBar`, nhấn mở `LessonPlayerRoute`.
- **Upcoming Session Card (`HomeUpcomingSessionCard`)**: Bọc `ClayCard`, avatar giáo viên 3D `avatar_coach_sarah.png` RGBA sạch, nhấn mở Tab 2 (`Sessions`).
- **Bottom Navigation Bar**: Chiều cao $72\text{ dp}$, nền trắng, bóng đổ ngược phía trên, 5 tab chính (`Home`, `Courses`, `Sessions`, `Tests`, `Profile`).

---

## 📱 2. Danh Sách 5 Trạng Thái Màn Hình
1. **Default**: Toàn bộ dữ liệu hiển thị phong phú, cuộn êm mượt 60 FPS.
2. **Loading / Shimmer**: Hiển thị khung xương xám nhạt bóng mờ trong lúc tải dữ liệu.
3. **Empty Learning / Empty Sessions**: Khi chưa có buổi học sắp diễn ra, hiển thị `ClayDialog` Level 3 (*"Chưa có buổi học!"*, `modal_empty_sessions.png`) với CTA chính *"Khám phá khóa học"* và CTA phụ *"Để sau nhé"*.
4. **Error / Disconnected**: Hỗ trợ hiển thị `ClayDialog.showNetworkError` (*"Mất kết nối rồi!"*, `modal_error_offline.png`) kèm nút *"Thử lại"* có icon xoay và nút phụ *"Học chế độ ngoại tuyến"*.
5. **Offline**: Hiển thị biểu tượng đám mây 3D báo hiệu các bài học đã tải về máy có thể học tiếp ngoại tuyến.
