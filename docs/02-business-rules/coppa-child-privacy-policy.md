# Quy Định An Toàn & Bảo Vệ Quyền Riêng Tư Trẻ Em (COPPA Compliance) — Kiddora

Tài liệu này xác lập các nguyên tắc pháp lý và kỹ thuật bắt buộc để bảo vệ dữ liệu trẻ em theo đạo luật **COPPA (Children's Online Privacy Protection Act)** và các quy chuẩn quốc tế về bảo mật trẻ em trên không gian số.

---

## 1. Nguyên Tắc Cốt Lõi: Zero PII (Personally Identifiable Information)

1. **Không thu thập dữ liệu định danh trẻ em**:
   - Ứng dụng **không bao giờ yêu cầu họ tên đầy đủ**, số chứng minh, địa chỉ nhà, trường học thực tế, hay số điện thoại của trẻ.
   - Trẻ chỉ sử dụng **Biệt danh ngắn (Nickname)** hoặc chọn từ danh sách **Quick Nickname Chips** có sẵn (VD: *"Leo"*, *"Milo"*, *"Toby"*).
2. **Không thu thập hình ảnh thật của trẻ**:
   - Thay vì cho phép chụp ảnh khuôn mặt thật làm avatar, Kiddora cung cấp trọn bộ **12 Mascot 3D Con Giáp Đất Sét**.
3. **Không định vị địa lý (Zero Geolocation)**:
   - Ứng dụng tuyệt đối không yêu cầu quyền truy cập GPS hoặc vị trí chính xác của thiết bị.

---

## 2. Cơ Chế Khóa Phụ Huynh (Parental Gate Policy)

Theo quy định bắt buộc, mọi luồng giao dịch hoặc thay đổi cấu hình sau đây đều phải vượt qua **Parental Gate**:
- Thay đổi cấu hình bảo mật tài khoản hoặc xóa tài khoản.
- Chuyển hướng ra trình duyệt web bên ngoài (External Links).
- Truy cập vào Trung tâm Phụ huynh (Parent Hub) và báo cáo phân tích nâng cao.

### Thuật Toán Parental Gate (Math Riddle Challenge):
1. Hệ thống tự động sinh ngẫu nhiên 1 câu đố toán nhân chia phù hợp với người lớn nhưng gây khó khăn cho trẻ nhỏ (VD: $14 \times 7 = ?$, $96 \div 8 = ?$).
2. Người dùng phải nhập đáp án chính xác trong vòng $30\text{ giây}$.
3. Quá 3 lần nhập sai liên tiếp, hệ thống khóa truy cập tạm thời trong $5\text{ phút}$.

---

## 3. Lưu Trữ Dữ Liệu Cục Bộ & Mã Hóa

- Thông tin hồ sơ bé (`KidProfile`) được lưu trữ tại `SharedPreferences` dưới dạng chuỗi JSON mã hóa cục bộ.
- Dữ liệu không được chia sẻ cho bất kỳ bên thứ ba quảng cáo nào (Third-party Trackers). Tuyệt đối cấm tích hợp SDK quảng cáo hướng đối tượng (AdMob tracking, Facebook Audience Network).
