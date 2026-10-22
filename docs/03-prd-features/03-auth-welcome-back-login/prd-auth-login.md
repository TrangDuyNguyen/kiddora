# Đặc Tả Tính Năng (PRD): Xác Thực & Đăng Nhập / Đăng Ký (FEAT-03)

- **Mã tính năng**: `FEAT-03`
- **Tên tính năng**: Authentication & Welcome Back Flow (Login & Register)
- **Module**: `features/auth`
- **Sub-Agent Quản trị**: Sub-Agent BA & Sub-Agent PO
- **Trạng thái**: 🟢 **Completed & Hardened** (`v0.3.0`)
- **Tài sản đối sánh Dribbble**: `assets/design_references/screens/02_auth_01_welcome_back_login.png`

---

## 1. Bối Cảnh & Mục Tiêu Nghiệp Vụ

### 1.1. Bối Cảnh
Khi phụ huynh hoặc học sinh quay trở lại ứng dụng, màn hình đăng nhập cần tạo cảm giác thân thuộc như được chào đón về nhà (*"Welcome Back!"*). Đồng thời, đối với người dùng mới, màn hình Đăng ký (Register) cung cấp quy trình tạo tài khoản nhanh chóng, minh bạch về điều khoản và bảo vệ trẻ em (COPPA).

### 1.2. Chỉ Số Đo Lường (KPIs)
- **Login Success Rate**: Đạt $\ge 98\%$.
- **Password Obscurity Toggle**: Phản hồi tức thời $\le 16\text{ms}$.
- **Zero Confusion**: $100\%$ lỗi nhập liệu được thông báo rõ ràng bằng tiếng Việt / tiếng Anh chuẩn qua `AppStrings`.

---

## 2. Phạm Vi Tính Năng (Feature Scope)
1. **Login Screen (1:1 Dribbble Benchmark)**: Ô nhập Email/Username, ô Mật khẩu bo cong đất sét, icon mắt chuyển đổi ẩn/hiện, checkbox "Remember me", nút [Log In] Indigo 3D.
2. **Register Screen (Sign-Up Flow)**: Ô nhập Họ tên, Email, Mật khẩu, Xác nhận mật khẩu, checkbox chấp thuận Điều khoản dịch vụ & Chính sách bảo mật trẻ em.
3. **Social Authentication Buttons**: Hàng 3 nút tròn xúc giác đăng nhập qua Google, Apple, Facebook.
4. **Link Chuyển Đổi Luồng**: Chuyển đổi qua lại giữa Đăng nhập và Đăng ký bằng 1 chạm.
