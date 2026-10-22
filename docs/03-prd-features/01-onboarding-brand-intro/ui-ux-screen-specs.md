# Đặc Tả Giao Diện UI/UX Specs: Onboarding (FEAT-01)

- **Feature**: `FEAT-01`
- **Sub-Agent**: Sub-Agent UI/UX Designer
- **Asset đối sánh Dribbble**: `assets/design_references/screens/01_onboarding_01_welcome.png` đến `03_live_coaches.png`
- **Tỷ lệ chuẩn Figma**: $406 \times 950\text{ dp}$

---

## 🎨 1. Quy Chuẩn Màu Sắc & Tokens (Claymorphism Tokens)
- **Background Gradient**: Lavender pastel `#F2F4FF` $\rightarrow$ `#E6ECFE`.
- **Thẻ đáy (Bottom Clay Sheet)**: Pure White `#FFFFFF`, bo tròn góc trên $24\text{ dp}$, bóng đổ mềm `offset(0, -6)`, `blurRadius: 18`, màu `rgba(70, 72, 212, 0.08)`.
- **Nút FAB tròn chuyển tiếp**: Primary Indigo `#4648D4`, kích thước $56 \times 56\text{ dp}$, icon mũi tên trắng $24\text{ dp}$.
- **Hiệu ứng Squish**: Khi bấm `scale(0.96) translateY(3px)`.
- **Typography**: Header Quicksand Bold $24\text{ sp}$, Body Mona Sans Regular $14\text{ sp}$.

---

## 📱 2. Danh Sách 5 Trạng Thái Màn Hình (5 UI States)
1. **Default**: Hiển thị đầy đủ hình ảnh linh vật đất sét, tiêu đề, mô tả và nút điều hướng.
2. **Active (Pressed)**: Nút FAB co lại $4\%$ và rung nhẹ xúc giác Haptic.
3. **Transition**: Cuộn mượt $60\text{ FPS}$ giữa các trang qua `PageView`.
4. **Orientation**: Khóa cố định chế độ Portrait dọc trên điện thoại.
5. **Responsive**: Tự động co giãn lề dưới khi chạy trên màn hình compact nhỏ hoặc tablet.
