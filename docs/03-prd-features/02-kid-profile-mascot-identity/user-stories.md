# Kịch Bản BDD User Stories: Hồ Sơ Bé (FEAT-02)

- **Feature**: `FEAT-02` — Tactile Kid Profile Identity & Zodiac Mascots v2
- **Tác giả**: Sub-Agent BA — *"The Pedantic Logician"*

---

## User Story US-02: Thiết Lập Hồ Sơ Bé Bằng Thao Tác 1 Chạm

**Là một** học sinh nhỏ tuổi hoặc phụ huynh,  
**Tôi muốn** chọn nhanh biệt danh, xoay tuổi và chọn linh vật 3D con giáp yêu thích,  
**Để** sở hữu một hồ sơ học tập cá nhân hóa đáng yêu mà không cần gõ chữ phức tạp.

### Kịch Bản 1: Chọn biệt danh từ Quick Chip
- **Given** người dùng đang ở `KidProfileSetupScreen`.
- **When** người dùng chạm vào chip `"Leo"`.
- **Then** ô nhập tên tự động điền `"Leo"`, chip đổi màu sang tím Indigo có bóng đổ và kích hoạt rung nhẹ.

### Kịch Bản 2: Tung xúc xắc ngẫu nhiên biệt danh
- **Given** ô nhập tên đang trống hoặc đã có chữ.
- **When** người dùng chạm vào icon xúc xắc (Dice).
- **Then** hệ thống chọn ngẫu nhiên một biệt danh mới trong kho 20+ tên và điền vào ô nhập.

### Kịch Bản 3: Xoay tuổi trên Age Wheel Spinner
- **Given** con trỏ tuổi đang ở vị trí 8 tuổi (*"Grade 3"*).
- **When** người dùng cuộn bánh xe xuống mốc 9 tuổi.
- **Then** mốc 9 tuổi phóng to nhẹ, chữ đổi sang màu tím đậm, nhãn lộ trình đổi thành *"Grade 4 - Active Learner"* kèm tiếng click xúc giác.

### Kịch Bản 4: Chọn linh vật Mascot 3D
- **Given** danh sách 12 con giáp hiển thị dạng lưới ngang.
- **When** người dùng chọn mascot Rồng (Dragon).
- **Then** bệ mascot Rồng nổi viền sáng Indigo, hiển thị tên linh vật và lưu vào cấu hình hồ sơ.
