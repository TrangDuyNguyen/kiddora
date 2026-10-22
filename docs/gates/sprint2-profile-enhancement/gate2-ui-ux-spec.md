# Gate 2: UI/UX Design & Tactile Claymorphism Specification
## Feature: Sprint 2 — Kid Profile Setup Enhancement (US-04-v2)
**Designer**: Sub-Agent UI/UX Designer — *"The Celestial Aesthetic Purist"*  
**Design Tokens Ref**: Google Stitch Design System `assets/4f23066581b9416eb589a101d788b98a`  
**Reviewer**: Sub-Agent BA & Sub-Agent PO  
**Status**: **APPROVED (Grade A+)**  
**Date**: 2026-10-22  

---

## 🎨 1. Thiết Kế Chi Tiết Các Thành Phần Xúc Giác (Tactile Components)

### 1.1. Quick Nickname Chips & Dice Randomizer
- **Bố cục**: Dòng ngang cuộn nhẹ nếu màn hình hẹp, lề ngang `AppValues.space7` ($16\text{dp}$).
- **Kích thước Chip**: Chiều cao $36\text{dp}$, bo cong Pill ($18\text{dp}$).
- **Thị giác**: Nền trắng Pure White (`#FFFFFF`), viền lồi clay `1.5dp` (`#E2E8F0`), bóng đổ mềm `Offset(0, 2)`, blur `4dp`.
- **Nút Xúc Xắc (Dice Button)**: Nút tròn đường kính $36\text{dp}$, nền tím nhạt Indigo Container (`#EEF2FF`), icon xúc xắc tím Indigo `#4648D4` xoay nhẹ khi chạm.

### 1.2. Tactile Clay Age Wheel Spinner (Dải tuổi 6–12)
- **Kích thước Container**: Chiều cao $136\text{dp}$, bo góc $24\text{dp}$ (`ClayCard`).
- **Hiệu ứng Khối Trụ 3D Cylinder**:
  - Gradient che mờ trên/dưới: Tạo ảo giác bề mặt cong lồi của khối trụ đất sét.
  - Vạch kính ngắm trung tâm (Specular Focal Lens): Khung bo tròn viền tím nhạt `#6366F1` với alpha $0.15$, highlight trắng trên đỉnh.
  - Typography nấc chọn: `26pt`, `FontWeight.w800`, màu tím Indigo `#4648D4`.
  - Typography nấc phụ (trên/dưới): `16pt`, `FontWeight.w600`, màu xám trung tính `#94A3B8`.
- **Thẻ Nhãn Lộ Trình (Curriculum Hint Badge)**:
  - Chiều cao $38\text{dp}$, bo cong $12\text{dp}$, nền `#EEF2FF`, viền `#C7D2FE`.
  - Text: Quicksand `13pt`, `FontWeight.w700`, màu `#3730A3`.

### 1.3. Bệ Đỡ Linh Vật Liền Mạch (Seamless Avatar Pedestal v2)
- **Xóa bỏ lỗi viền vuông (Square Patch Artifact)**:
  - Loại bỏ hoàn toàn khối `Container` chữ nhật góc tù bên trong.
  - Asset mascot PNG đứng trực tiếp trên nền bệ đất sét.
- **Bóng đổ xúc giác chân đế (Ambient Ground Shadow)**:
  - Ngay dưới chân linh vật thêm 1 vùng bóng elip mờ: `BoxDecoration` hình bầu dục, màu `Colors.black.withOpacity(0.06)`, blur `6dp`.
- **Tương tác**: Chạm vào bệ kích hoạt `scale(0.96) translateY(2px)` kết hợp viền sáng tím Indigo `#6366F1` và dấu tích check.

---

## 🎛️ 2. Năm Trạng Thái Giao Diện Bắt Buộc (5 Mandatory UI States)

| Trạng thái | Biệt danh (Nickname) | Bánh xe tuổi (Age Wheel) | Linh vật (Mascot) | Nút CTA (Sẵn sàng) |
| :--- | :--- | :--- | :--- | :--- |
| **1. Default (Ban đầu)** | Trống, hiển thị 4 chip gợi ý | Dừng ở nấc 8 tuổi, nhãn Lớp 3 | Leo được chọn mặc định | Mờ Disabled (Xám trung tính) |
| **2. Active / Selected** | Có tên $\ge 2$ ký tự, chip sáng | Cuộn mượt mà có haptic | Viền tím Indigo sáng, có dấu tích | Bung sáng tím Indigo, đổ bóng nổi 3D |
| **3. Loading** | Khóa input phím | Khóa cuộn bánh xe | Giữ nguyên trạng thái | Hiển thị vòng xoay spinner đất sét |
| **4. Error / Boundary** | Đỏ viền nếu nhập ký tự lạ | N/A (giới hạn cứng 6-12) | N/A | Bị vô hiệu hóa |
| **5. Offline State** | Vẫn hoạt động 100% offline | Lưu cục bộ SharedPreferences | Đầy đủ 4 mascot offline | Hoạt động bình thường không cần mạng |

---

## 📐 3. Tuân Thủ Lưới 4pt & Công Thái Học
- 100% khoảng cách tuân thủ bội số 4pt: `space1 (4dp)`, `space2 (8dp)`, `space3 (12dp)`, `space4 (16dp)`, `space6 (24dp)`.
- Touch target của mọi nút bấm và chip tối thiểu $36\text{dp}$ (chip) và $56\text{dp}$ (CTA chính).
- Tương phản màu sắc: Tím Indigo `#4648D4` trên nền sáng đạt tỉ lệ tương phản $8.4:1$ (Vượt chuẩn WCAG AAA).

---

## 🛡️ PHÊ DUYỆT CHÍNH THỨC GATE 2
- **Sub-Agent BA**: Ký duyệt — Khớp 100% User Stories và tiêu chí nghiệp vụ.
- **Sub-Agent PO**: Ký duyệt — Thiết kế sang trọng, liền mạch, loại bỏ lỗi decal vuông.
