# Bảng Thuật Ngữ Nghiệp Vụ & Kỹ Thuật (Glossary of Terms) — Kiddora

Tài liệu này chuẩn hóa các định nghĩa, thuật ngữ chuyên ngành EdTech, Design System và Quy trình phần mềm được sử dụng trong toàn bộ hệ thống tài liệu và mã nguồn Kiddora.

---

## 🎨 1. Thuật Ngữ Thiết Kế & Trải Nghiệm (Design & UX)

| Thuật Ngữ | Định Nghĩa Trong Kiddora |
| :--- | :--- |
| **Tactile Claymorphism** | Phong cách thiết kế giao diện mô phỏng đất sét 3D xúc giác, có bóng đổ kép (Upper-left specular highlight và Lower-right compression shading) tạo cảm giác mềm mại, ấm cúng và an toàn cho trẻ. |
| **Squish Effect** | Hiệu ứng phản hồi vật lý khi chạm nút: thu nhỏ tỷ lệ `scale(0.96)` kết hợp dịch chuyển trục dọc `translateY(3px)` kèm rung nhẹ Haptic. |
| **WCAG 2.2 AA** | Chuẩn tiếp cận giao diện web và di động quốc tế: Màu tương phản tối thiểu 4.5:1 với text thường và 3:1 với UI controls; màu Primary Indigo của Kiddora đạt 8.4:1 (chuẩn AAA). |
| **5 UI States** | 5 trạng thái bắt buộc của mỗi màn hình và component: `Default`, `Loading/Shimmer`, `Empty/Zero Data`, `Error/Retry`, `Offline`. |
| **Thumb Zone Ergonomics** | Vùng công thái học bàn tay trẻ em: Các nút hành động chính (CTA) được đặt ở nửa dưới màn hình với kích thước chạm tối thiểu $48 \times 48\text{ dp}$ (khuyến nghị $56 \times 56\text{ dp}$). |

---

## 📚 2. Thuật Ngữ Nghiệp Vụ Giáo Dục (EdTech Domain)

| Thuật Ngữ | Định Nghĩa Trong Kiddora |
| :--- | :--- |
| **Mental Math** | Phân hệ Toán tư duy giúp học sinh tiểu học rèn luyện phản xạ tính nhẩm nhanh và logic số học. |
| **STEM Explorers** | Phân hệ Khoa học thực nghiệm & Khám phá vũ trụ (Khoa học, Công nghệ, Kỹ thuật, Toán học). |
| **Daily Learning Goals** | Mục tiêu học tập hàng ngày: Bộ 5 nhiệm vụ gamified giúp trẻ xây dựng thói quen tự học bền bỉ mỗi ngày. |
| **Streak Flame** | Ngọn lửa ghi nhận chuỗi ngày hoàn thành bài học liên tục của trẻ (nhân tố thúc đẩy D30 Retention). |
| **Live Coaching** | Buổi học trực tiếp qua video stream thời gian thực cùng giáo viên hướng dẫn chuyên biệt. |
| **Parental Gate** | Cơ chế xác thực chặn trẻ em truy cập vào khu vực cài đặt hoặc mua sắm bằng câu hỏi đố toán bất kỳ (VD: *"7 × 8 = ?"*). |
| **COPPA** | Children's Online Privacy Protection Act — Đạo luật bảo vệ quyền riêng tư trực tuyến của trẻ em: Tuyệt đối không thu thập dữ liệu định danh cá nhân (PII), không quảng cáo hướng đối tượng. |

---

## 🛠️ 3. Thuật Ngữ Kiến Trúc Kỹ Thuật (Architecture & Engineering)

| Thuật Ngữ | Định Nghĩa Trong Kiddora |
| :--- | :--- |
| **Feature-First Clean Architecture** | Kiến trúc phân lớp theo tính năng: Mỗi feature chứa 3 tầng `domain` (Entities thuần Dart), `data` (DTO & Datasources), `presentation` (Riverpod & UI). |
| **Ponytail Clean Code** | Kỷ luật kỹ thuật tối giản: Ưu tiên giải pháp lười nhất nhưng hoạt động hoàn hảo, triệt tiêu 100% boilerplate thừa, không magic numbers, không emojis trong code logic. |
| **Agile Docs-as-Code** | Toàn bộ tài liệu nghiệp vụ, PRD, thiết kế, báo cáo kiểm thử được lưu trữ dưới dạng Markdown trực tiếp trong repository Git, cùng tiến hóa theo từng commit mã nguồn. |
