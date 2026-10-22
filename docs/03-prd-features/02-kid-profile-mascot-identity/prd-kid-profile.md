# Đặc Tả Tính Năng (PRD): Hồ Sơ Bé & 12 Mascot Con Giáp (FEAT-02)

- **Mã tính năng**: `FEAT-02`
- **Tên tính năng**: Tactile Kid Profile Identity & Zodiac Mascots v2
- **Module**: `features/onboarding/presentation/pages/kid_profile_setup_screen.dart`
- **Sub-Agent Quản trị**: Sub-Agent BA & Sub-Agent PO
- **Trạng thái**: 🟢 **Completed & Released** (`v0.2.0`)
- **Tài sản đối sánh Dribbble**: `assets/design_references/screens/12_profile_01_keil_adam_stats.png`

---

## 1. Bối Cảnh & Mục Tiêu Nghiệp Vụ

### 1.1. Bối Cảnh
Trẻ nhỏ từ 6–10 tuổi gặp khó khăn lớn khi phải gõ chữ bằng bàn phím ảo di động và dễ chán nản nếu thủ tục tạo tài khoản rườm rà. Tính năng Hồ sơ Bé v2 cung cấp trải nghiệm 1-tap: chọn nhanh biệt danh, xoay tuổi đất sét và chọn linh vật đại diện trong 12 con giáp.

### 1.2. Chỉ Số Đo Lường (KPIs)
- **Time-to-Setup**: Giảm từ $45\text{ giây}$ xuống $\le 12\text{ giây}$.
- **Form Abandonment Rate**: Giảm xuống dưới $5\%$.
- **Haptic Delight**: $100\%$ các lần xoay tuổi hoặc chọn linh vật đều có phản hồi rung tinh tế.

---

## 2. Phạm Vi Tính Năng (Feature Scope)
1. **Quick Nickname Chips**: 4 chip tên gọi thân mật gợi ý sẵn (*Leo, Milo, Toby, Luna*) + nút tung xúc xắc (Dice Random) tự động sinh tên mới.
2. **Tactile Clay Age Wheel Spinner**: Vòng xoay tuổi hình trụ đất sét dải tuổi 6–12, hiển thị gợi ý cấp lớp học (*"Grade 1 - Early Explorer"* $\rightarrow$ *"Grade 5 - Junior Master"*).
3. **12 3D Zodiac Mascot Pedestal**: Bộ sưu tập 12 linh vật con giáp 3D đất sét không viền hộp, căn chỉnh xúc giác mượt mà.
4. **Validation & Local Storage**: Kiểm tra bắt buộc có tên, tuổi hợp lệ (6-12) và lưu vào `KidProfile` model.
