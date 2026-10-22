# Đặc Tả Tính Năng (PRD): Onboarding & Giới Thiệu Thương Hiệu (FEAT-01)

- **Mã tính năng**: `FEAT-01`
- **Tên tính năng**: Interactive Onboarding & Brand Introduction
- **Module**: `features/onboarding`
- **Sub-Agent Quản trị**: Sub-Agent BA & Sub-Agent PO
- **Trạng thái**: 🟢 **Completed & Released** (`v0.1.0`)
- **Tài sản đối sánh Dribbble**: `assets/design_references/screens/01_onboarding_01_welcome.png` đến `03_live_coaches.png`

---

## 1. Bối Cảnh & Mục Tiêu Nghiệp Vụ (Business Objectives & KPIs)

### 1.1. Bối Cảnh
Trẻ em và phụ huynh khi tải Kiddora cần ngay lập tức cảm nhận được sự ấm áp, an toàn, sống động và giá trị cốt lõi của ứng dụng (Học vui vẻ, Tự khám phá, Lớp học trực tuyến tương tác). Luồng Onboarding 3 slide đất sét tạo ấn tượng thị giác đầu tiên (First Impression) vượt trội.

### 1.2. Chỉ Số Đo Lường (KPIs)
- **Onboarding Completion Rate**: $\ge 92\%$ người dùng hoàn thành hết 3 slide và tiến vào tạo hồ sơ.
- **Swipe Frame Rate**: Đạt ổn định $60\text{ FPS}$ trong suốt thao tác vuốt chuyển slide.
- **Time to Complete**: Thời gian trung bình trải nghiệm luồng Onboarding $\le 25\text{ giây}$.

---

## 2. Phạm Vi Tính Năng (Feature Scope)
1. **Slide 1 - Fun Learning for a Brighter Tomorrow**: Giới thiệu thương hiệu, logo Kiddora, linh vật bé trai đất sét vẫy tay chào, huy hiệu sao vàng.
2. **Slide 2 - Discover & Learn**: Giới thiệu việc tự học đa môn (Toán, Vẽ, STEM) với 3 chip tính năng nổi bật.
3. **Slide 3 - Learn with Live Coaches**: Giới thiệu lớp học trực tuyến cùng giáo viên, 3 chip tính năng nổi bật và nút chuyển tiếp sang thiết lập hồ sơ bé.
4. **Onboarding Guard & State**: Kiểm tra trạng thái đã hoàn thành onboarding hay chưa trong `SharedPreferences` để không hiển thị lại cho lần mở app tiếp theo.
