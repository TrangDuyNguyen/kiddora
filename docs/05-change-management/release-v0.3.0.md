# Biên Bản Công Bố Phát Hành (Release Notes) — Kiddora v0.3.0

- **Sản phẩm**: Kiddora — Kids Learning & Live Classes Mobile App
- **Phiên bản phát hành**: `v0.3.0` (Sprint 3 Milestone)
- **Ngày phát hành**: 2026-10-22
- **Ký duyệt Gate 7**: Sub-Agent Product Owner (PO), Sub-Agent PM & Sub-Agent Tech Lead
- **Tình trạng kiểm thử**: **34/34 tests PASSED (100%)**, `flutter analyze`: **0 issues**

---

## 🚀 1. Điểm Nhấn Phiên Bản (Release Highlights)
Phiên bản `v0.3.0` hiện thực hóa trọn vẹn 3 màn hình cốt lõi 1:1 chuẩn xác từ bản thiết kế Dribbble benchmark:
1. **Welcome Back / Login Screen**:
   - Đăng nhập Email/Username, Mật khẩu, Remember me, Nút Indigo 3D và hàng nút Social Auth.
2. **Student Home Dashboard**:
   - Chào mừng Keil cá nhân hóa, 3 thẻ tóm tắt tiến độ, khóa học đang học (*Amazing Animals*), thẻ tham gia Live Class cùng Coach Sarah.
   - Thanh điều hướng đáy đất sét xúc giác (Clay Bottom Navigation).
3. **Today's Learning Goal Screen**:
   - Vòng tròn tiến độ 3D *"3 of 5 Tasks Completed"*, danh sách 5 nhiệm vụ tương tác có checkbox xúc giác, banner linh vật giơ ngón tay cái động viên.
4. **Register Screen & Splash Screen Architecture**:
   - Đăng ký tài khoản đầy đủ, kiểm tra độ an toàn mật khẩu và bảo mật trẻ em COPPA.
   - Khởi động với Native Splash Screen và App Icon chính thức.
5. **Kỷ Luật Ponytail Clean Code**:
   - Triệt tiêu $100\%$ Magic Numbers (`AppValues`), xóa toàn bộ Emojis trong code, tập trung $100\%$ chuỗi văn bản trong `AppStrings` và màu sắc trong `AppColors`.
