# Kịch Bản BDD User Stories: Xác Thực (FEAT-03)

- **Feature**: `FEAT-03` — Authentication & Welcome Back Flow
- **Tác giả**: Sub-Agent BA — *"The Pedantic Logician"*

---

## User Story US-03: Đăng Nhập Tài Khoản Đã Có

**Là một** phụ huynh hoặc học sinh đã có tài khoản,  
**Tôi muốn** nhập thông tin đăng nhập và duy trì phiên làm việc ("Remember me"),  
**Để** truy cập ngay vào trang chủ học tập của mình.

### Kịch Bản 1: Đăng nhập thành công với thông tin hợp lệ
- **Given** người dùng đang ở `LoginScreen`.
- **When** người dùng nhập email `keil@kiddora.com`, mật khẩu `Pass123!`, tích chọn `Remember me`, và nhấn nút `Log In`.
- **Then** ứng dụng hiển thị hiệu ứng nảy nút, xác thực thông tin và chuyển hướng sang `HomeScreen`.

### Kịch Bản 2: Chuyển đổi ẩn/hiện mật khẩu
- **Given** người dùng đang nhập mật khẩu tại ô Password.
- **When** người dùng chạm vào icon con mắt.
- **Then** mật khẩu chuyển đổi trạng thái giữa che giấu (`obscureText: true`) và hiển thị rõ ký tự (`obscureText: false`).

---

## User Story US-04: Đăng Ký Tài Khoản Mới

**Là một** phụ huynh muốn đăng ký tài khoản mới cho con,  
**Tôi muốn** điền form đăng ký với các trường thông tin cơ bản và điều khoản an toàn,  
**Để** thiết lập tài khoản gia đình an toàn trên Kiddora.

### Kịch Bản 1: Đăng ký thành công
- **Given** người dùng đang ở `RegisterScreen`.
- **When** người dùng điền đầy đủ Họ tên, Email hợp lệ, Mật khẩu $\ge 8$ ký tự, khớp xác nhận mật khẩu, tích chọn đồng ý điều khoản và nhấn `Sign Up`.
- **Then** hệ thống tạo tài khoản mới và chuyển tiếp đến màn hình chính.

### Kịch Bản 2: Báo lỗi khi thiếu thông tin
- **Given** form đăng ký chưa được điền thông tin.
- **When** người dùng nhấn nút `Sign Up`.
- **Then** hệ thống chặn submit và hiển thị thông báo lỗi rõ ràng bên dưới các trường còn thiếu.

## Bổ sung CR-009: Lỗi mạng khi đăng nhập

```gherkin
Scenario: Máy chủ không khả dụng
  Given phụ huynh nhập email và mật khẩu hợp lệ
  When máy chủ backend tắt hoặc không kết nối được
  Then màn Login ngừng loading và hiển thị "Không thể kết nối đến máy chủ. Vui lòng kiểm tra lại mạng."

Scenario: Máy chủ phản hồi quá chậm
  When request vượt AppValues.apiTimeout
  Then hiển thị thông báo timeout và cho phép thử lại

Scenario: Phản hồi 200 thiếu token
  Then hiển thị "Phản hồi từ máy chủ không hợp lệ." và không lưu phiên đăng nhập
```

## Bổ sung CR-010: BE là nguồn thông báo lỗi

```gherkin
Scenario: Hiển thị nguyên văn lỗi từ BE
  When BE trả HTTP 4xx/5xx với {"detail": "<thông báo>"}
  Then Login, Register và Kid Profile hiển thị đúng "<thông báo>" (ClayErrorText)

Scenario: Dữ liệu gửi lên không hợp lệ
  When BE trả 422
  Then detail là chuỗi dạng "Dữ liệu không hợp lệ (<trường>): <lý do>"

Scenario: Không có phản hồi từ BE
  Then FE hiển thị thông báo mất kết nối/timeout cục bộ
```
