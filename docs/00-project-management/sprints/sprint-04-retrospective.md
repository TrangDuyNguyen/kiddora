# Biên Bản Sprint Retrospective — Sprint 4
## Dự Án Kiddora Mobile App — Kỳ Đánh Giá & Cải Tiến Quy Trình

- **Điều phối viên (Scrum Master)**: Sub-Agent Scrum Master (SM) — *"The Servant Leader & Agile Coach"*
- **Thành phần tham dự**: 
  - Sub-Agent Product Owner (PO)
  - Sub-Agent Project Manager (PM)
  - Sub-Agent Tech Lead & System Architect
  - Sub-Agent Dev FE (`flutter-core-dev`)
  - Sub-Agent Dev BE (`backend-dev`)
  - Sub-Agent QA Tester & Visual QA
  - Sub-Agent UI/UX Designer
  - Sub-Agent DevOps & Cloud Infrastructure Specialist
- **Thời gian**: 29/10/2026
- **Format Retrospective**: **4Ls Framework** (*Liked, Learned, Lacked, Longed for*)
- **Sprint Goal Được Đánh Giá**: *"Hiện thực hóa trọn gói luồng Fullstack End-to-End: Đăng ký, Đăng nhập, Onboarding và Hồ sơ bé, đồng bộ REST API FastAPI với PostgreSQL Database (Alembic Migration), hỗ trợ chế độ Khách (Guest) và chuyển đổi tài khoản."*
- **Kết quả nghiệm thu**: 15/15 SP ($100\%$) + 26 SP UI Kit mở rộng (CR-013) — Đạt chuẩn Release `v0.4.0`.

---

## 💡 1. Tổng Hợp Ý Kiến Đội Ngũ (4Ls Framework)

### 🌟 1.1. Liked (Những điều làm tốt và mang lại niềm vui cho đội)
- **Kiến trúc Hybrid Dev Server (CR-008)**: Tách biệt toàn bộ 6 Docker backend services sang máy chủ Windows Host Server 24/7 giúp máy lập trình macOS chạy nhẹ, mượt mà, không bị nóng máy hay tụt pin khi chạy test song song.
- **Kỷ luật "Backend là nguồn lỗi duy nhất" (CR-010)**: Việc quy định BE chịu trách nhiệm sinh thông báo lỗi thân thiện (`ClayErrorText`) giúp tiết kiệm hơn 80% công sức viết logic thông báo lỗi phân mảnh ở phía client.
- **Shared UI Kit v2 tái sử dụng cao (CR-013)**: Việc chuẩn hóa `ClayDialog`, `ClayFilterBar`, `ClayScreenHeader`, `ClayListTile` đã giải phóng đội FE khỏi việc dựng lại các widget lặp lại.
- **Tốc độ và độ tin cậy kiểm thử**: 83 test Flutter chạy chỉ mất ~6 giây, 13 test pytest chạy mất 1.8 giây, 100% xanh mà không có test flaky.

### 📚 1.2. Learned (Những bài học kinh nghiệm sâu sắc rút ra)
- **Xử lý Case-Insensitive Email từ đầu**: Bàn phím ảo trên iOS và Android luôn tự động viết hoa chữ cái đầu (ví dụ: `Trang...` thay vì `trang...`). Việc không chuẩn hóa `toLowerCase()` ở cả 2 đầu ngay từ Gate 0 đã tạo ra bug 401 giả lập rất khó chịu lúc đầu.
- **Kiểm thử trên màn hình nhỏ sớm**: `ClayDialog` bị RenderFlex overflow 32px khi text scale 1.5x trên màn $360\times640$. Phải luôn đưa bộ đôi `ConstrainedBox(maxHeight)` + `SingleChildScrollView` vào template của mọi modal dialog.
- **Tách riêng tư liệu tham khảo khỏi APK runtime**: Nhờ phát hiện sớm việc giữ 57 ảnh benchmark màn hình trong `assets/design_references/` không đưa vào `pubspec.yaml`, app tránh được nguy cơ phình to thêm gần 80MB.

### ⚠️ 1.3. Lacked (Những điểm còn thiếu hụt hoặc gây cản trở)
- **Quản lý yêu cầu thay đổi chen ngang (Scope Influx)**: Giữa Sprint 4 đã phát sinh liên tiếp 6 Change Requests (CR-008 đến CR-013). Mặc dù các CR này đều rất chất lượng và đã hoàn thành 100%, nhưng việc tiếp nhận dồn dập khiến đội ngũ phải liên tục switch context giữa Dev và Review.
- **Thiếu mock data chuẩn hóa cho giai đoạn tiếp theo**: Rủi ro `RSK-006` về việc mock dữ liệu cho 14 domains Dribbble vẫn ở trạng thái `IN_PROGRESS`, chưa kịp đóng gói thành Mock Service hoàn chỉnh trước khi Sprint 5 bắt đầu.

### 🔭 1.4. Longed for (Những điều đội ngũ khao khát có ở Sprint tới)
- **Hệ thống Mock Repository & Seed Data sẵn sàng trước ngày Planning**: Đội ngũ mong muốn BA và Backend chuẩn bị sẵn bộ dữ liệu danh mục khóa học, bài học và danh mục môn học (`courses`, `lessons`, `subjects`) trước khi đội FE bắt tay vào code giao diện Sprint 5.
- **Bảo vệ Sprint Goal nghiêm ngặt hơn**: Cần gom các cải tiến nhỏ vào một đợt Hardening định kỳ thay vì đưa CR xen ngang giữa lúc đang tập trung làm tính năng cốt lõi.

---

## 🛠️ 2. Hành Động Cải Tiến Trọng Tâm (Kaizen Action Items)

Theo nguyên tắc của Scrum Master: **"Chỉ chọn 1–2 hành động cụ thể, có người phụ trách rõ ràng, và kiểm tra lại ở Retro sau."**

| STT | Hành Động Kaizen Cụ Thể | Người Phụ Trách | Hạn Chót (Deadline) | Tiêu Chí Đo Lường Hoàn Thành |
| :---: | :--- | :---: | :---: | :--- |
| **KZN-01** | **Xây dựng Course Seed Data & Mock Repository chuẩn Freezed**: Đóng gói sẵn 12 khóa học mẫu theo 4 chủ đề (Math, STEM, Arts, Language) có đầy đủ tên bài, thời lượng, avatar giảng viên để phục vụ Sprint 5. | `backend-dev` & `flutter-core-dev` | Ngày 1 của Sprint 5 | File `course_mock_repository.dart` và migration seed data BE sẵn sàng 100% test pass. |
| **KZN-02** | **Bộ đệm tiếp nhận CR (CR Buffer Gate)**: Trong Sprint 5, mọi CR phát sinh giữa Sprint không liên quan đến Blocker hoặc Security sẽ được chuyển vào backlog "Sprint 5.5 Hardening" thay vì chèn trực tiếp vào Sprint đang chạy. | `scrum-master` & `po` | Toàn bộ Sprint 5 | Tỷ lệ can thiệp phạm vi giữa Sprint = 0, Sprint Goal được bảo vệ trọn vẹn. |

---

## 🏁 3. Kết Luận Của Scrum Master

Sprint 4 là một bước tiến vượt bậc của Kiddora về mặt kỹ thuật và tính toàn vẹn của sản phẩm. Toàn đội ngũ đã chuyển mình thành công từ giai đoạn chỉ có giao diện tĩnh sang một hệ thống Fullstack thực thụ có cơ sở dữ liệu và REST API hoàn chỉnh. Tinh thần cộng tác giữa các Sub-Agents diễn ra nhịp nhàng, trung thực và minh bạch.

**Sprint 4 chính thức khép lại thành công rực rỡ! Toàn đội bước vào Sprint 5 với khí thế cao nhất!**

