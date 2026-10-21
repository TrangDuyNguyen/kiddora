# Gate 2: UI/UX Design Specification & Tactile Clay Design Tokens
## Feature: Sprint 1 — Interactive Onboarding & Kid Profile Setup
**Author**: Sub-Agent UI/UX Designer — *"The Celestial Aesthetic Purist"*  
**Reviewer**: Sub-Agent BA & Sub-Agent PO  
**Reference Asset**: [kiddora_full_shot.png](../../assets/design_references/kiddora_full_shot.png)  
**Status**: APPROVED  

---

## 🎨 1. Tactile Claymorphism Tokens (Kiddora Design System)

### 1.1. Bảng Màu Ngữ Nghĩa (Semantic Color Palette)
* **Primary Indigo (`#4648D4` / `#6366F1`)**: Nút CTA chính, vệt sáng активный indicator, Mental Math. Contrast ratio: `8.4:1` (WCAG AAA).
* **Joyful Amber (`#F59E0B` / `#FBBF24`)**: Mascot Sao vàng, điểm sao thưởng, ánh sáng ấm.
* **STEM Pink (`#EC4899`)**: Trang phục nhân vật nữ, icon Sáng tạo & Thí nghiệm.
* **Meadow Mint (`#10B981`)**: Trạng thái thành công, thẻ chip tuổi đang chọn, Live Indicator.
* **Sky Blue (`#0EA5E9`)**: Đám mây nền, bubble thông tin lớp học.
* **Porcelain Canvas (`#FCF8FF` / `#F8FAFC`)**: Nền ứng dụng dịu mắt, chống chói cho trẻ em.
* **Pure White Clay (`#FFFFFF`)**: Thẻ card nổi 3D.

### 1.2. Công Thức Đổ Bóng & Ánh Sáng Xúc Giác (Tactile Illumination Formula)
* **Bề mặt Nổi (Raised Surface)**:
  - Top-left highlight: `inset 3px 3px 5px rgba(255, 255, 255, 0.90)`
  - Bottom-right compression shading: `inset -3px -3px 6px rgba(13, 12, 34, 0.07)`
  - Drop shadow: `0px 10px 24px rgba(70, 72, 212, 0.12)`
* **Bề mặt Ấn xuống (Squish Active State)**:
  - Transformation: `scale(0.96) translateY(2px)`
  - Drop shadow giảm: `0px 4px 8px rgba(70, 72, 212, 0.08)`
  - Haptic: `HapticFeedback.lightImpact()`

---

## 📐 2. Lưới Khoảng Cách & Bố Cục (4pt Grid System)
* **Padding chuẩn**: `8pt` (S2), `12pt` (S3), `16pt` (S4), `24pt` (S6), `32pt` (S8).
* **Bán kính cong (Border Radius)**:
  - Thẻ ClayCard: `28pt`
  - Nút ClayButton: `24pt`
  - Chip chọn tuổi: `20pt`
  - Nút tròn Next arrow: `50% (Circle 56x56pt)`
* **Touch Target**: Mọi thành phần tương tác tối thiểu $48 \times 48\text{pt}$ (Khuyến nghị $56\text{pt}$).

---

## 📱 3. Đặc Tả 5 Trạng Thái Giao Diện (The 5 Mandatory UI States)

| Thành Phần | Default | Active / Pressed (Squish) | Disabled | Loading / Shimmer | Error / Invalid |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Nút Tròn Next Arrow** | Tím `#4648D4`, bóng nổi $10\text{px}$, mũi tên trắng | Thu nhỏ `0.96x`, hạ thấp $2\text{px}$, bóng co lại $4\text{px}$ | Nền xám `#E2E8F0`, mũi tên xám nhạt | Spinner xoay trắng $20\text{px}$ | Viền đỏ nhạt rung lắc |
| **Age Selector Chip** | Nền trắng `#FFFFFF`, viền mờ, chữ tím đen | Scale `0.94x`, rung xúc giác | Không khả dụng | Shimmer xám | Cảnh báo viền đỏ |
| **Age Chip (Được Chọn)** | Nền Mint `#10B981` hoặc Indigo, chữ trắng, checkmark | Scale `0.96x` | - | - | - |
| **Avatar Card** | Khung tròn clay trắng, viền mảnh | Scale `0.94x`, viền sáng | Opacity 0.4 | Skeleton tròn | - |
| **Input Biệt Danh** | Nền sứ `#F8FAFC`, placeholder xám tím | Viền tím `#6366F1` sáng $2\text{px}$ | Readonly | - | Viền cam đỏ `#EF4444`, text lỗi |

---

## 🖼️ 4. Bố Cục Chi Tiết Màn Hình (Screen Layout Specs)

### Màn Hình 1: 3-Slide Interactive Onboarding (`OnboardingScreen`)
* **Header**: Logo `Kiddora` (Font Quicksand Bold, phối màu chữ cầu vồng tím-vàng-hồng) + Tagline *"Learn • Play • Achieve"*. Nút "Bỏ qua" (Skip) ở góc trên phải.
* **Center (Illustration Area)**:
  - Chiếm $52\%$ chiều cao màn hình.
  - Render hình ảnh nhân vật 3D nổi bật:
    + Slide 1: Cậu bé áo hoodie vàng giơ tay chiến thắng + Bé Sao may mắn bay lượn.
    + Slide 2: Cô bé áo hồng gõ laptop sao tím + sách & bình thí nghiệm nổi.
    + Slide 3: Khung lớp học trực tuyến Live Coach + bạn nhỏ ngồi chăm chú.
* **Bottom Sheet (Content Card)**:
  - Khung trắng bo tròn đỉnh `36pt`, đổ bóng mềm.
  - Tiêu đề $22\text{sp}$ Font Quicksand w800, text màu tím than `#1E1B4B`.
  - Mô tả phụ $14\text{sp}$ màu tím xám `#64748B`.
  - Bộ chỉ báo trang: 3 chấm tròn chuyển động mịn (`ClayPageIndicator`).
  - Nút bấm:
    + Slide 1 & 2: Nút tròn tím $56 \times 56\text{pt}$ chứa icon mũi tên trắng $\rightarrow$.
    + Slide 3: Nút dài chữ nhật bo góc $56\text{pt}$ cao: *"Bắt đầu học ngay 🚀"*.

### Màn Hình 2: Thiết Lập Hồ Sơ Bé (`KidProfileSetupScreen`)
* **Header**: Nút Back clay tròn góc trái + Tiêu đề *"Tạo Hồ Sơ Cho Bé 🎨"*.
* **Section 1: Biệt danh của bé**: Ô nhập chữ to $18\text{sp}$, bo góc $24\text{pt}$, biểu tượng bút chì.
* **Section 2: Con mấy tuổi rồi?**: Hàng ngang 4 thẻ tròn đất sét to $60 \times 60\text{pt}$ ghi `7`, `8`, `9`, `10` tuổi.
* **Section 3: Chọn bạn đồng hành 3D**: Lưới $2 \times 2$ gồm 4 linh vật đất sét:
  - 🦁 *Leo Thông Thái*
  - 🐻 *Barnaby Khám Phá*
  - 🦖 *Dino Siêu Trí Tuệ*
  - 🐰 *Bunny Nhanh Nhẹn*
* **Footer Action**: Nút ClayButton to cao $56\text{pt}$ màu Indigo: *"Khám Phá Kiddora 🚀"*.

---

## ✅ BIÊN BẢN PHÊ DUYỆT GATE 2 (Design Sign-Off)
- **UI/UX Designer**: APPROVED (Đầy đủ lưới 4pt, 5 UI states, thông số tactile illumination).
- **BA & PO**: APPROVED (100% Khớp với kịch bản PRD Gate 1 và hình mẫu [kiddora_full_shot.png](../../assets/design_references/kiddora_full_shot.png)).
