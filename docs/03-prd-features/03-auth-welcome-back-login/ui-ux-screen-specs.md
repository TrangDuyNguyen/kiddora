# Đặc Tả Giao Diện UI/UX Specs: Xác Thực (FEAT-03)

- **Feature**: `FEAT-03`
- **Sub-Agent**: Sub-Agent UI/UX Designer
- **Asset đối sánh Dribbble**: `assets/design_references/screens/02_auth_01_welcome_back_login.png`

---

## 🎨 1. Quy Chuẩn Thành Phần & Tokens

- **Mascot Header**: Bé trai đất sét vẫy tay chào thân thiện, đặt trên nền tím nhạt `#EEF2FF`, chiều cao $170\text{ dp}$.
- **Container Ô Nhập (Clay Input Fields)**: Chiều cao $52\text{ dp}$, bo góc $14\text{ dp}$, nền xám sứ `#F9FAFB`, viền `#E5E7EB`, bóng đổ nén nhẹ `inset -2px -2px 4px rgba(0,0,0,0.04)`.
- **Primary CTA Button**: Màu Indigo `#4648D4`, bóng nổi $4\text{ dp}$, chữ in hoa đậm Quicksand $16\text{ sp}$.
- **Social Auth Row**: 3 nút tròn đường kính $48\text{ dp}$, nền trắng, viền mảnh $1\text{ dp}$, bóng đổ đất sét tròn.

---

## 📱 2. Danh Sách 5 Trạng Thái Màn Hình
1. **Default**: Form hiển thị sạch sẽ, con trỏ sẵn sàng tại ô đầu tiên.
2. **Focus-visible**: Ô nhập được chọn viền sáng Indigo `#4648D4` dày $2\text{ dp}$.
3. **Password Visible**: Icon mắt đổi sang trạng thái mở, hiển thị rõ văn bản.
4. **Validation Error**: Viền ô nhập chuyển sang đỏ Coral `#EF4444`, hiển thị text thông báo lỗi nhỏ phía dưới.
5. **Loading**: Nút CTA hiển thị vòng xoay tròn nhỏ, khóa tương tác chống double-tap.
