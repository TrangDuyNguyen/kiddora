# Đặc Tả Giao Diện UI/UX Specs: Hồ Sơ Bé (FEAT-02)

- **Feature**: `FEAT-02`
- **Sub-Agent**: Sub-Agent UI/UX Designer
- **Asset đối sánh**: `assets/design_references/screens/12_profile_01_keil_adam_stats.png`

---

## 🎨 1. Tokens & Cấu Trúc Khối Giao Diện

- **Header Mascot**: Chiều cao $160\text{ dp}$, căn chỉnh đáy tiếp xúc trực tiếp với mép cong của Bottom Sheet trắng (loại bỏ khe hở).
- **Quick Nickname Chips**: Chiều cao $36\text{ dp}$, bo góc tròn $18\text{ dp}$, nền xám sứ `#F3F4F6`, chữ `#374151`. Khi chọn: nền Indigo `#4648D4`, chữ trắng, bóng đổ tím mờ.
- **Age Wheel Spinner**: Sử dụng `ListWheelScrollView` với `itemExtent: 52`, đường kính bánh xe cong nhẹ mô phỏng hình trụ đất sét, nhãn tuổi $20\text{ sp}$ in đậm.
- **12 Mascot Carousel**: Kích thước mỗi item $80 \times 80\text{ dp}$, bệ tròn đất sét bo viền highlight specular $2\text{ dp}$.
- **Nút CTA Hoàn Tất**: Rộng tối đa (Full-width), chiều cao $54\text{ dp}$, bo góc $16\text{ dp}$, nền Indigo `#4648D4`, chữ trắng Quicksand Bold $16\text{ sp}$.

---

## 📱 2. Danh Sách 5 Trạng Thái Màn Hình
1. **Default**: Hiển thị form khởi tạo với gợi ý tuổi mặc định là 8 tuổi.
2. **Selecting Age / Name**: Bánh xe tuổi xoay mượt mà với Clamping physics, không gây rung lắc màn hình cha.
3. **Validation Error**: Báo lỗi chữ đỏ nếu người dùng cố tình xóa sạch tên và nhấn hoàn tất.
4. **Submitting**: Nút CTA hiển thị trạng thái mờ nhẹ và lưu dữ liệu tức thì.
5. **Success / Navigation**: Chuyển hướng tức thì sang màn hình Home hoặc Login.
