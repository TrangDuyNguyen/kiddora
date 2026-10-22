# Đặc Tả Giao Diện UI/UX Specs: [Tên Màn Hình]

- **Feature**: `FEAT-XX`
- **Sub-Agent**: Sub-Agent UI/UX Designer
- **Asset đối sánh Dribbble**: `assets/design_references/screens/[tên file]`
- **Tỷ lệ chuẩn Figma**: $406 \times 950\text{ dp}$

---

## 🎨 1. Tokens Màu Sắc, Bo Góc & Hiệu Ứng Xúc Giác
- **Nền (Canvas Background)**: [Mã màu hex]
- **Thẻ chính (Clay Card Surface)**: Bo góc [XX dp], bóng đổ [offset, blur, color]
- **Nút hành động (Buttons)**: Màu chủ đạo [AppColors], hiệu ứng squish `scale(0.96) translateY(3px)`
- **Kiểu chữ (Typography)**: Header [Quicksand Bold], Body [Mona Sans Regular]

---

## 📱 2. Danh Sách 5 Trạng Thái Màn Hình (5 UI States)
1. **Default**: Trạng thái chuẩn khi có đầy đủ dữ liệu.
2. **Loading / Shimmer**: Hiệu ứng khung xương tải nội dung.
3. **Empty / Zero Data**: Màn hình rỗng có hình vẽ đất sét ngộ nghĩnh và nút hành động.
4. **Error / Retry**: Thông báo lỗi nhẹ nhàng và nút thử lại [Retry].
5. **Offline**: Biểu tượng ngoại tuyến và hướng dẫn truy cập nội dung đã tải về.
