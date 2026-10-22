# Kịch Bản BDD User Stories: Onboarding (FEAT-01)

- **Feature**: `FEAT-01` — Interactive Onboarding & Brand Introduction
- **Tác giả**: Sub-Agent BA — *"The Pedantic Logician"*
- **Tiêu chuẩn**: Gherkin BDD (Given-When-Then)

---

## User Story US-01: Xem Các Slide Giới Thiệu Onboarding

**Là một** phụ huynh hoặc học sinh lần đầu mở ứng dụng Kiddora,  
**Tôi muốn** xem các slide giới thiệu sinh động kèm hình ảnh linh vật đất sét 3D,  
**Để** hiểu được những lợi ích giáo dục cốt lõi mà ứng dụng mang lại.

### Kịch Bản 1: Vuốt qua các slide (Swipe Navigation)
- **Given** người dùng đang ở `OnboardingScreen` tại Slide 1 (*"Fun Learning for a Brighter Tomorrow"*).
- **When** người dùng thực hiện cử chỉ vuốt ngang sang trái (Swipe Left).
- **Then** màn hình chuyển mượt mà sang Slide 2 (*"Discover & Learn"*), thanh chỉ báo tròn (Smooth Page Indicator) cập nhật vị trí tương ứng.

### Kịch Bản 2: Nhấn nút tròn chuyển tiếp (Next FAB Action)
- **Given** người dùng đang ở Slide 1 hoặc Slide 2.
- **When** người dùng nhấn vào nút tròn chuyển tiếp mũi tên (`->`).
- **Then** trang tự động cuộn sang slide kế tiếp kèm hiệu ứng nảy xúc giác (Haptic Squish).

### Kịch Bản 3: Hoàn thành Onboarding tại Slide 3
- **Given** người dùng đang ở Slide 3 (*"Learn with Live Coaches"*).
- **When** người dùng nhấn nút bắt đầu hoặc nút mũi tên cuối cùng.
- **Then** hệ thống đánh dấu trạng thái `hasCompletedOnboarding = true` trong bộ nhớ và chuyển hướng sang màn hình thiết lập hồ sơ `KidProfileSetupScreen`.
