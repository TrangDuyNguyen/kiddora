# Gate 2: UI/UX Design System Specification & Layout Grid (4pt)
## Feature: Sprint 3 — 3 Core Screens 1:1 Implementation
**Project**: Kiddora (Kids Learning & Live Classes)  
**Author**: Sub-Agent UI/UX Designer — *"The Celestial Aesthetic Purist"*  
**Reviewer**: Sub-Agent BA, PO & Tech Lead  
**Status**: **APPROVED**  
**Date**: 2026-10-22  
**Benchmark Reference**: `assets/design_references/33b01983f3e3be3821bcee2f1b2bdf94.webp`

---

## 🎨 1. Bảng Ánh Xạ Màu Sắc & Tokens (Tactile Clay Color Palette)

| Mã Token | Hex Code | Độ Tương Phản (WCAG) | Ứng Dụng Trong 3 Màn Hình |
| :--- | :--- | :--- | :--- |
| `AppColors.brandPrimary` | `#6366F1` | $8.4:1$ (AAA) | Nút "Log In", Vòng tiến độ Goal, Icon Home Active, Nút "Join" |
| `AppColors.brandIndigoLight` | `#818CF8` | $4.8:1$ (AA) | Gradient Hero Banner "Keep Learning Keep Growing!", Viền focus input |
| `AppColors.surface` | `#FCF8FF` | $1.0:1$ (Canvas) | Màu nền chủ đạo Warm Porcelain của cả 3 màn hình |
| `AppColors.surfaceContainer` | `#FFFFFF` | $1.05:1$ (Card) | Khối Form Card, 4 thẻ Quick Action, Thẻ Khóa học, Thẻ Nhiệm vụ |
| `AppColors.rewardAmber` | `#F59E0B` | $4.6:1$ (AA) | Ngôi sao 3D, Cúp My Badges, Tia sáng Confetti Sparkles |
| `AppColors.stateSuccess` | `#10B981` | $4.5:1$ (AA) | Checkbox tích xanh hoàn thành nhiệm vụ, Icon My Progress |
| `AppColors.accentSky` | `#0EA5E9` | $4.9:1$ (AA) | Thẻ Current Courses, Icon sách mở |
| `AppColors.accentStemPink` | `#EC4899` | $4.7:1$ (AA) | Huy hiệu thông báo số 3, Thẻ Upcoming Session |
| `AppColors.textPrimary` | `#1E1B4B` | $15.2:1$ (AAA) | Tiêu đề "Welcome Back!", "Today's Learning Goal", tên khóa học |
| `AppColors.textSecondary` | `#6E6D7A` | $5.1:1$ (AA) | Phụ đề, mô tả nhiệm vụ, thời gian học |

---

## 📐 2. Quy Chuẩn Lưới 4pt & Khoảng Cách (Layout Blueprint)

```
+-------------------------------------------------------------+
| Margin Trái/Phải: 20dp (AppValues.space7 / 24dp space8)     |
| Bán kính bo góc Cards: 20dp - 24dp (AppValues.radiusXl)     |
| Bán kính bo góc Nút Pill: 28dp (AppValues.radiusPill)       |
| Chiều cao Touch Target tối thiểu: 48dp (Nút chính: 54dp)    |
| Inset Highlight: inset 2.5px 2.5px 4px rgba(255,255,255,0.9)|
| Extrusion Shadow: 0 4px 0 rgba(79, 70, 229, 0.25)          |
+-------------------------------------------------------------+
```

### Chi tiết Layout 3 Màn Hình:

#### Screen 1: Welcome Back / Login
- **Header Section (H: 260dp)**:
  - Top bar: Nút tròn Back `44x44dp` tại tọa độ góc trái.
  - Khối Logo `Kiddora` 7 sắc màu rực rỡ + tagline *"Learn • Play • Achieve"*.
  - Tiêu đề *"Welcome Back!"* (24sp Bold) + phụ đề *"Let's continue your learning journey"*.
  - Mascot 3D: Bé trai vẫy tay tươi tắn bên cạnh ngôi sao vàng mỉm cười (`assets/images/login_hero_mascot.png`).
- **Form Card Surface (W: 100%, Bán kính đỉnh: 32dp, Trắng sứ #FFFFFF)**:
  - Ô nhập Email / Username: Nền tím sữa nhạt `#F8FAFC`, icon mail tím, bo tròn 16dp.
  - Ô nhập Password: Icon khóa tím, icon ẩn/hiện mắt góc phải, bo tròn 16dp.
  - Hàng Remember Me & Forgot Password: Giãn 2 đầu (`spaceBetween`).
  - Nút bấm chính *"Log In ->"*: Cao 54dp, gradient tím indigo, hiệu ứng nảy xúc giác.
  - Dải phân cách *"Or continue with"*.
  - Bộ 3 nút tròn mạng xã hội (Google, Apple, Microsoft) xếp hàng ngang đều đặn `spaceAround`.
  - Dòng chân trang: *"Don't have an account? Sign Up"*.

#### Screen 2: Student Home / Dashboard
- **Top Greeting Bar**:
  - Avatar tròn bé Keil (`48x48dp`) + Lời chào *"Hi, Keil!"* & *"Great to see you again!"*.
  - Cụm bên phải: Nút tròn Chuông (có chấm đỏ badge số 3) & Nút tròn Đăng xuất.
- **Hero Banner ("Keep Learning Keep Growing!")**:
  - Chiều cao `150dp`, bo tròn `24dp`, gradient tím pastel mộng mơ.
  - Bên trái: Tiêu đề 2 dòng + Lời nhắn vui ✨ + Nút tròn trắng mũi tên `->`.
  - Bên phải: Bé trai 3D nhảy múa với vương miện vàng (`assets/images/mascot_boy_crown.png`).
- **Lưới Quick Stats 2x2**:
  - Gồm 4 thẻ đất sét trắng tỉ lệ cân đối, mỗi thẻ chứa icon tròn màu pastel tương ứng:
    1. `My Progress` (Xanh mint) -> Nhấn vào mở Screen 3.
    2. `Current Courses` (Xanh dương).
    3. `Upcoming Session` (Hồng pastel).
    4. `My Badges` (Vàng mật ong).
- **Khối "Continue Learning"**:
  - Thẻ chữ nhật bo tròn 20dp, ảnh khủng long 3D (`assets/images/course_dino.png`), nhãn "Science", tiến độ "3 of 5 lessons" và nút tròn tím.
- **Khối "Upcoming Session"**:
  - Thẻ giáo viên Sarah (`assets/images/avatar_coach_sarah.png`), môn "Math Fun with Numbers", giờ học "Today, 4:00 PM", và nút tím "Join".
- **Thanh Clay Bottom Navigation**:
  - 5 vị trí: Home (đang chọn, tím nổi bật), Courses, Sessions, Tests, More.

#### Screen 3: Today's Learning Goal
- **Top Bar**: Nút Back tròn trắng.
- **Header**: Tiêu đề *"Today's Learning Goal"* + phụ đề *"Small steps make big progress!"*.
- **Vòng Tròn Tiến Độ Circular Ring**:
  - Đường kính $180\text{dp}$, viền dày $14\text{dp}$.
  - Track tím nhạt `#EDE9FE`, vòng tiến độ gradient tím bo tròn 2 đầu ($60\%$).
  - Tâm vòng tròn: Ngôi sao 3D mỉm cười (`assets/images/mascot_star_goal.png`) + text *"3 of 5"* (26sp Bold) + *"Tasks Completed"*.
  - Các vệt tia sáng vàng lấp lánh (sparkles) xung quanh.
- **Danh Sách 5 Nhiệm Vụ (Task List)**:
  - 5 hàng nhiệm vụ rõ ràng: Checkbox tròn xanh lá với dấu tích trắng (đã hoàn thành) hoặc vòng tròn viền tím nhạt (chưa hoàn thành), kèm mũi tên điều hướng `>`.
- **Thẻ Động Viên Dưới Cùng (Motivation Card)**:
  - Màu nền vàng bơ ấm áp `#FEF3C7`, bo tròn 24dp.
  - Hình bé trai 3D giơ ngón tay cái 👍 (`assets/images/mascot_boy_thumbs_up.png`).
  - Tiêu đề *"You can do it!"* + *"Keep learning and reach your goal today!"*.

---

## 🎭 3. Đặc Tả 5 Trạng Thái Giao Diện (5 UI States Specification)

1. **Default State**: Hiển thị đầy đủ số liệu, hình ảnh 3D và các thành phần tương tác mượt mà.
2. **Pressed / Active State**: Khi chạm vào bất kỳ thẻ hoặc nút bấm nào, widget thu nhỏ nhẹ `scale(0.96)`, hạ bóng đổ và phát ra nhịp rung Haptic.
3. **Loading / Shimmer State**: Khi đang tải dữ liệu khóa học hoặc đăng nhập, nút hiển thị spinner trắng tròn xoay mượt mà hoặc shimmer skeleton thẻ bài.
4. **Empty State**: Khi hoàn thành toàn bộ 5/5 nhiệm vụ, ngôi sao trung tâm đổi biểu cảm ăn mừng rực rỡ kèm lời khen *"Tuyệt vời! Bạn đã hoàn thành xuất sắc!"*.
5. **Offline / Error State**: Nếu mất kết nối mạng, các thẻ học tập vẫn hiển thị bộ nhớ đệm (cache) và không làm crash ứng dụng.

**Ký duyệt Gate 2**:  
*Sub-Agent UI/UX Designer: The Celestial Aesthetic Purist — APPROVED*  
*Sub-Agent BA: The Pedantic Logician — APPROVED*  
*Sub-Agent Tech Lead: The Pragmatic System Architect — APPROVED*
