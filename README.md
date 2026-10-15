# Kiddora — Kids Learning & Live Classes Mobile App

> **Product**: Kiddora Mobile App & Live Studio  
> **Target Audience**: Trẻ em 7–10 tuổi (Tiểu học: Toán tư duy, Khoa học STEM, Câu đố logic) & Phụ huynh  
> **Design Aesthetic**: Tactile Claymorphism 3D × Duolingo Playful Gamification × WCAG 2.2 AA  
> **Google Stitch Project ID**: `11612036710163643589`  
> **Stitch Design System Asset**: `assets/9652051346587888941` (`Tactile Clay Learning (Kiddora)`)

---

## 📌 1. Tổng Quan Dự Án

**Kiddora** là ứng dụng di động giáo dục tương tác cao cấp dành riêng cho học sinh tiểu học (7–10 tuổi), kết hợp giữa **lộ trình tự học theo nhiệm vụ (Gamified Quests)** và **lớp học trực tuyến tương tác thời gian thực (Live Classes)** với giáo viên chuyên môn.

### Trọng Tâm Học Tập (Pillars)
1. 🧮 **Toán Tư Duy (Mental Math)**: Chuỗi bài toán tính nhẩm siêu tốc, sơ đồ tư duy trực quan, bài toán đố vui theo cấp độ.
2. 🔬 **Khoa Học STEM (STEM Explorers)**: Khám phá vũ trụ, thế giới tự nhiên, thí nghiệm ảo mô phỏng vật lý/hóa học tương tác.
3. 🧩 **Câu Đố Logic (Logic Riddles)**: Trò chơi ghép hình không gian, ma trận quy luật, rèn luyện tư duy phản biện.
4. 🎥 **Lớp Trực Tuyến Tương Tác (Live Studio)**: Phòng học ảo độ trễ thấp, chuông bấm trả lời câu hỏi trực tiếp (Buzzer), giơ tay ảo và thả reaction biểu cảm.
5. 🛡️ **Cổng Phụ Huynh (Parent Hub)**: Khóa PIN an toàn (bài toán thử thách người lớn), quản lý thời gian sử dụng màn hình, báo cáo tiến độ tuần và phản hồi từ giáo viên.

---

## 🎨 2. Hệ Thống Thiết Kế (Design System Base)

Toàn bộ quy chuẩn thiết kế, bảng mã màu ngữ nghĩa (Semantic Tokens), thang đo kiểu chữ (Typography), lưới khoảng cách (Spacing), bán kính cong (Radius), hiệu ứng đổ bóng xúc giác (Clay Elevation) và 7 trạng thái thành phần giao diện đã được chuẩn hóa tại:
👉 [`docs/kiddora/DESIGN.md`](./DESIGN.md)

### Tóm Tắt Design Tokens Cốt Lõi:
- **Primary Indigo (`#4648D4` / `#6366F1`)**: Điều hướng chính, bài tập Toán tư duy, nút bấm hành động nổi bật.
- **Joyful Amber (`#F59E0B` / `#FBBF24`)**: Bộ đếm Sao thưởng, chuỗi ngày học liên tục (Streaks), chuông bấm Live Buzzer.
- **STEM Bubblegum Pink (`#EC4899`)**: Chuyên đề Khoa học STEM, nút yêu thích, hoạt động sáng tạo.
- **Meadow Mint (`#10B981`)**: Hoàn thành bài học, câu trả lời chính xác, trạng thái Live đang phát.
- **Sky Blue (`#0EA5E9`)**: Thẻ thông tin bài giảng, danh sách bạn học đang online.
- **Nền sứ ấm (Warm Porcelain `#FCF8FF` / Thẻ trắng `#FFFFFF`)**: Chống lóa mắt, bảo vệ thị lực trẻ em khi học tập.

---

## 🚀 3. Lộ Trình Triển Khai (Roadmap)

- [x] **Bước 1**: Khởi tạo Stitch Project (`projects/11612036710163643589`) & Design System (`assets/9652051346587888941`).
- [x] **Bước 2**: Ban hành tài liệu quy chuẩn [`DESIGN.md`](./DESIGN.md) chuẩn Dribbble Reference & WCAG 2.2 AA.
- [ ] **Bước 3**: Sinh bộ màn hình Mockup UI trực quan trên Stitch (Onboarding Profile, Gamified Home Quest, Live Classroom, Parent Gate).
- [ ] **Bước 4**: Thẩm định Gate 1 (PRD BDD) & Gate 2 (Design Sign-Off) với hội đồng Sub-Agents.
- [ ] **Bước 5**: Thiết lập cấu trúc mã nguồn Flutter Mobile (Feature-First Clean Architecture, Riverpod 2.x, AutoRoute).
