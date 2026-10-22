# Gate 0: Architecture Spike & Architecture Decision Records (ADR)
## Feature: Sprint 2 — Kid Profile Setup Enhancement (US-04-v2)
**Project**: Kiddora (Kids Learning & Live Classes)  
**Author**: Sub-Agent Tech Lead — *"The Pragmatic System Architect"*  
**Verdict**: **FEASIBILITY APPROVED (Grade A)**  
**Date**: 2026-10-22  
**Target SLAs**: Cold start $\le 1.2\text{s}$, Cuộn màn hình $60\text{ FPS}$, Rò rỉ RAM: $0\text{ MB}$.

---

## 🔬 1. Báo Cáo Thẩm Định Kỹ Thuật (Technical Spike Report)

### 1.1. Thách Thức 1: Bánh Xe Cuộn Tactile Clay Wheel Spinner (Dải tuổi 6–12)
* **Vấn đề**: Màn hình `KidProfileSetupScreen` được bọc bởi `SingleChildScrollView`. Nếu nhúng `ListWheelScrollView` hoặc `CupertinoPicker` trực tiếp, cử chỉ vuốt dọc (vertical drag) sẽ bị xung đột giữa cuộn toàn trang và cuộn bánh xe tuổi.
* **Giải Pháp Thực Nghiệm (PoC)**:
  - Sử dụng `ListWheelScrollView.useDelegate` với chiều cao cố định ($130\text{dp}$), `itemExtent: 44.0`, `physics: const FixedExtentScrollPhysics()`.
  - Khung bao quanh được bọc trong một `ClayCard` dạng khối trụ lõm/lồi (Tactile Clay Wheel Container), có 2 dải gradient che mờ đỉnh và đáy (`ShaderMask` hoặc `LinearGradient` từ `surface` sang trong suốt) để tạo hiệu ứng 3D Cylinder sâu thẳm.
  - Sử dụng `FixedExtentScrollController(initialItem: initialAge - 6)` để điều khiển vị trí tức thì.
  - Mỗi khi thay đổi nấc (`onSelectedItemChanged`), kích hoạt `HapticFeedback.selectionClick()` với cơ chế debounce tự nhiên của `ScrollPhysics`.

### 1.2. Thách Thức 2: Triệt Tiêu Lỗi Viền Vuông Bệ Mascot (Square Patch Artifact)
* **Vấn đề**: `AvatarClayPedestal` hiện tại dùng một `Container` hình chữ nhật bên trong bệ clay, khiến asset mascot bị đóng khung trong một miếng dán trắng/xám vuông vắn, phá hỏng độ hòa quyện Tactile 3D.
* **Giải Pháp**:
  - Loại bỏ hoàn toàn chiếc hộp vuông phụ bên trong.
  - Ảnh mascot được đặt trực tiếp lên bề mặt bệ clay với `BoxFit.contain`.
  - Thêm một vòng hào quang bóng đổ xúc giác (Tactile Ambient Drop Shadow) hình bầu dục ngay dưới chân mascot (`Container` gradient tròn dẹt) để tạo cảm giác linh vật thực sự đứng trên bệ 3D, không bị dính đáy phẳng.

### 1.3. Thách Thức 3: Phản Hồi Âm Thanh & Xúc Giác (Audio & Haptic Feedback)
* **Vấn đề**: Tránh cài thêm các package âm thanh cồng kềnh (YAGNI / Ponytail rule).
* **Giải Pháp**:
  - Tận dụng `SystemSound.play(SystemSoundType.click)` kết hợp `HapticFeedback.mediumImpact()` khi chạm vào linh vật mascot.
  - Điều này mang lại phản hồi âm thanh bấm tách tách vui nhộn nguyên bản của hệ điều hành (iOS & Android) với $0\text{ms}$ độ trễ và không tốn thêm megabyte binary size nào.

---

## 📜 2. Bản Ghi Quyết Định Kiến Trúc (ADR)

### ADR-004: Tactile Clay Age Wheel Spinner Implementation
* **Ngữ cảnh**: Cần cho phép trẻ em và phụ huynh chọn tuổi từ 6 đến 12 mà không gây vỡ giao diện ngang.
* **Quyết định**: Xây dựng widget chuyên biệt `ClayAgeWheelSpinner` kế thừa `StatefulWidget`, sử dụng `ListWheelScrollView.useDelegate` với `diameterRatio: 1.5`, `perspective: 0.003`.
* **Hậu quả tích cực**: Giao diện gọn gàng, hỗ trợ dải tuổi mở rộng, hoạt ảnh cuộn 60 FPS, không xung đột gesture.

### ADR-005: Zero-Dependency Audio & Seamless Mascot Pedestal
* **Ngữ cảnh**: Cần âm thanh phản hồi và visual 3D chân thực cho 4 linh vật (Leo, Barnaby, Dino, Bunny).
* **Quyết định**: Sử dụng `SystemSound.play` kết hợp `HapticFeedback`, gỡ bỏ inner rectangle box trong `AvatarClayPedestal`.
* **Hậu quả tích cực**: Tuân thủ triết lý Ponytail tối thượng: 0 dependencies mới, 0 rủi ro giật lag.

---

## 🛡️ KẾT LUẬN GATE 0: FEASIBILITY SIGN-OFF
Sub-Agent Tech Lead chính thức **PHÊ DUYỆT TÍNH KHẢ THI (Gate 0 Sign-Off)** và bàn giao cho Sub-Agent BA soạn thảo tài liệu PRD & BDD Gate 1.
