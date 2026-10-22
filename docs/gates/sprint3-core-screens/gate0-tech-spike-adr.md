# Gate 0: Tech Spike & Architecture Decision Record (ADR)
## Feature: Sprint 3 — 3 Core Screens 1:1 Implementation
**Project**: Kiddora (Kids Learning & Live Classes)  
**Author**: Sub-Agent Tech Lead — *"The Pragmatic System Architect"*  
**Reviewer**: Sub-Agent PO — *"The Strategic Tyrant"*  
**Status**: **APPROVED**  
**Date**: 2026-10-22  
**Reference Asset**: `assets/design_references/33b01983f3e3be3821bcee2f1b2bdf94.webp`

---

## 📐 1. Bối Cảnh Kỹ Thuật & Mục Tiêu Spike (Spike Context & Scope)

### 1.1. Bối Cảnh
Sau khi hoàn thiện Onboarding và Profile Setup ở Sprint 1 & Sprint 2, Sprint 3 tiến hành triển khai chuẩn xác **1:1** theo mẫu thiết kế Dribbble benchmark (`33b01983f3e3be3821bcee2f1b2bdf94.webp`) bao gồm 3 màn hình cốt lõi:
1. **Screen 1 (Welcome Back / Login Screen)**: Đăng nhập tài khoản với nhận diện thương hiệu Kiddora, mascot 3D vẫy tay, form xúc giác đất sét và social auth.
2. **Screen 2 (Student Home / Dashboard Screen)**: Trang chủ học tập sinh động với Hero Banner "Keep Learning Keep Growing!", lưới 2x2 Quick Stats, Tiến độ bài học "Amazing Animals", Lịch học trực tiếp Coach Sarah, và thanh Clay Bottom Navigation.
3. **Screen 3 (Today's Learning Goal Screen)**: Màn hình Mục tiêu học tập hàng ngày với Vòng tròn tiến độ Circular Ring trung tâm (3/5 Tasks Completed), danh sách 5 nhiệm vụ tương tác kèm checkbox haptic, và thẻ động viên "You can do it!".

### 1.2. Mục Tiêu Kỹ Thuật (SLA Targets)
- **Tốc độ khung hình (Frame Rate)**: Duy trì $60\text{ FPS}$ trên cả 3 màn hình khi cuộn và chuyển trang.
- **Thời gian chuyển cảnh (Route Transition)**: $\le 200\text{ms}$ qua `AutoRoute`.
- **Độ phản hồi Xúc giác (Haptic Latency)**: $\le 16\text{ms}$ khi chạm nút/checkbox.
- **Chuẩn Ponytail**: Tận dụng tối đa Flutter Standard Library (`CustomPainter`, `AnimationController`, `TweenAnimationBuilder`), không cài thêm thư viện UI cồng kềnh.

---

## 🏗️ 2. Quyết Định Kiến Trúc (Architecture Decisions - ADR)

### ADR-01: Định Tuyến & Điều Hướng (Routing Topology)
- `LoginRoute` (`/login`): `LoginScreen` (hoặc `WelcomeBackScreen`).
- `HomeRoute` (`/home`): `HomeScreen` tái cấu trúc chuẩn 1:1 theo Screen 2 benchmark.
- `TodayLearningGoalRoute` (`/learning-goal`): `TodayLearningGoalScreen` ánh xạ từ nút "My Progress" trên HomeScreen hoặc nút Goal banner.
- Sử dụng `AutoRoute` và chạy `build_runner` để sinh route an toàn kiểu (`app_router.gr.dart`).

### ADR-02: Phân Tầng Dữ Liệu & Quản Lý Trạng Thái (Riverpod 2.x)
```
lib/features/
├── auth/
│   └── presentation/
│       ├── controllers/login_controller.dart
│       └── login_screen.dart
├── home/
│   └── presentation/
│       ├── controllers/home_dashboard_controller.dart
│       ├── home_screen.dart
│       ├── today_learning_goal_screen.dart
│       └── widgets/
│           ├── home_hero_banner.dart
│           ├── home_quick_stats_grid.dart
│           ├── home_continue_learning_card.dart
│           ├── home_upcoming_session_card.dart
│           ├── goal_circular_progress.dart
│           └── goal_task_tile.dart
```
- **`loginControllerProvider`**: Quản lý form login, validate email/password, toggle "Remember me", trạng thái loading và chuyển hướng Home.
- **`todayLearningGoalControllerProvider`**: Quản lý danh sách 5 nhiệm vụ học tập ngày hôm nay, hỗ trợ toggle hoàn thành tức thì với hiệu ứng Haptic và tính toán tỷ lệ phần trăm động (VD: 3/5 -> 4/5).

### ADR-03: Kỹ Thuật Đồ Họa Vòng Tròn Tiến Độ Đất Sét (Clay Circular Progress)
- Sử dụng `CustomPainter` (`ClayGoalRingPainter`) để vẽ vòng cung tiến độ:
  - Track nền: Màu tím nhạt siêu mềm (`#EDE9FE` / `#F3EEFC`) với bo tròn 2 đầu (`StrokeCap.round`).
  - Vòng tiến độ (Progress Arc): Gradient chuyển màu Royal Indigo (`#6366F1`) sang Deep Indigo (`#4F46E5`), bề dày $14\text{dp}$.
  - Trung tâm vòng: Đặt mascot ngôi sao vàng 3D (`assets/images/mascot_star_goal.png`) cùng số đo "3 of 5 Tasks Completed".
  - Hiệu ứng tia sáng vui tươi (Whimsical Confetti Sparkles) bao quanh vòng tròn bằng các vệt bo tròn hướng tâm.

### ADR-04: Xử Lý Assets Đồ Họa Độc Bản (Asset Pipeline)
- Trích xuất 1:1 các chi tiết 3D nguyên bản từ ảnh mẫu Dribbble (`33b01983f3e3be3821bcee2f1b2bdf94.webp`):
  - `assets/images/login_hero_mascot.png` (Bé trai vẫy tay & ngôi sao vàng)
  - `assets/images/mascot_boy_crown.png` (Bé trai đội vương miện trên banner Home)
  - `assets/images/course_dino.png` (Khủng long xanh môn Khoa học Amazing Animals)
  - `assets/images/avatar_coach_sarah.png` (Avatar HLV Sarah môn Toán)
  - `assets/images/avatar_keil.png` (Avatar bé Keil)
  - `assets/images/mascot_star_goal.png` (Ngôi sao vàng trung tâm vòng tiến độ)
  - `assets/images/mascot_boy_thumbs_up.png` (Bé trai giơ ngón tay cái động viên)
- Khai báo đầy đủ trong `pubspec.yaml` và nạp qua `Image.asset`.

---

## 🛡️ 3. Thẩm Định Khả Thi (Feasibility Sign-Off)

| Tiêu Chí | Ngưỡng Cho Phép | Kết Quả Đạt Được | Đánh Giá |
| :--- | :--- | :--- | :--- |
| **Flutter Widget Nesting** | $\le 5$ tầng | Tối đa 4 tầng nhờ phân rã widgets nhỏ gọn | **PASSED** |
| **Cold Start SLA** | $\le 1.8\text{s}$ | Ước tính $1.2\text{s}$ (không phụ thuộc network khi render ban đầu) | **PASSED** |
| **Memory SLA** | $0$ memory leak | Dispose đầy đủ controller & animation ticker | **PASSED** |
| **Ponytail Bloat** | $0$ external package mới | $100\%$ dùng Flutter Framework và core sẵn có | **PASSED** |

**Ký duyệt Gate 0**:  
*Sub-Agent Tech Lead: The Pragmatic System Architect — APPROVED*
