# Biên Bản Họp Căn Chỉnh Sprint 5 (Alignment Meeting)

- **Chủ trì**: Sub-Agent Scrum Master
- **Tham dự**: PO (User), Tech Lead, BA, UI/UX, Dev FE, Dev BE, QA, PM
- **Ngày**: 29/10/2026
- **Đính chính**: Sprint đang bàn là **Sprint 5** (`v0.5.0-courses-hub`). Sprint 4 đã phát hành `v0.4.0`.
- **Mục đích**: gom các thắc mắc còn lại, phân loại ai có quyền quyết, chốt hướng trước khi giao Dev.

---

## 1. Quyết Định Của PO (User)

| # | Vấn đề | Quyết định | Hệ quả |
| :---: | :--- | :--- | :--- |
| P1 | Ngôn ngữ | **Song ngữ Việt–Anh từ Sprint 5** | Gỡ "Multi-language UI" khỏi Won't-Have (CR-015). Cần ADR-005 trước khi làm UI. |
| P2 | Phạm vi | **Cam kết đủ 6 màn = 23 SP** (US-16 lên 5 SP) | CR-016. Rủi ro trễ đã được PO chấp nhận. |
| P3 | Bài học / asset | Chỉ demo, placeholder | Đã ghi tại PRD FEAT-07 mục 3. |
| P4 | Re-baseline roadmap (Learning Player + dịch sprint sau) | **CHƯA QUYẾT** | Không chặn Sprint 5. Xem mục 4. |

## 2. Quyết Định Của Đội (Thuộc Thẩm Quyền Kỹ Thuật)

| # | Vấn đề | Người quyết | Quyết định |
| :---: | :--- | :---: | :--- |
| T1 | Nguồn dữ liệu | Tech Lead | API thật (`/api/v1/courses`) + seed Alembic `0002`. FE dùng repository interface như module `auth`; widget test dùng fake repository, **không phụ thuộc server**. |
| T2 | Tìm kiếm | Tech Lead | Gọi tham số `search` của API, debounce 300ms; số `Search Results (N)` lấy từ số phần tử API trả về, không cố định 12. |
| T3 | Phân loại môn học không đồng nhất giữa các ảnh (Hub 5, Filter 7, Grid 4, thẻ có `Social Studies`) | BA + UI/UX | Dữ liệu hỗ trợ 7 giá trị. Mỗi màn hiển thị đúng bộ chip trong ảnh của màn đó. `Social Studies` chỉ xuất hiện khi chọn `All`. |
| T4 | Mã story | BA | Giữ US-07/07b/07c/07d, US-08 ở tài liệu tính năng; bảng ánh xạ sang US-15..22 ghi ở mục 5. |
| T5 | Nút tim yêu thích | UI/UX | Chỉ đổi trạng thái cục bộ trong phiên, không đồng bộ server. |
| T6 | Thư viện mới | Tech Lead | Không thêm package. `flutter_localizations` và `intl` đã có trong `pubspec.yaml`. |
| T7 | Bảo vệ Sprint Goal | SM | Áp dụng KZN-02: mọi CR mới ngoài scope chuyển sang Sprint 5.5. |

## 3. Số Liệu Cho Quyết Định Song Ngữ (Đầu Vào ADR-005)

| Chỉ số | Giá trị đo được |
| :--- | :---: |
| Chuỗi trong `AppStrings` | ~250 |
| File dùng `AppStrings` | 36 |
| Lượt dùng `AppStrings.` | 194 |
| `flutter_localizations`, `intl` | Đã có sẵn |
| `flutter: generate` | Đang `false` |
| Test hiện tại | 83, nhiều test tìm theo văn bản (`find.text`) |

**Rủi ro Tech Lead nêu**: `AppStrings` là hằng `static const` dùng không cần `BuildContext`, kể cả trong controller. Chuyển sang `gen-l10n` phải đổi cách gọi ở 36 file và có thể làm vỡ test theo văn bản. Chưa ước lượng được SP, nên cần spike 1 ngày.

**Các hướng ADR-005 sẽ so sánh**
1. `gen-l10n` + ARB, di chuyển toàn bộ chuỗi (đúng chuẩn, tốn công nhất).
2. `gen-l10n` chỉ cho màn Sprint 5, chuỗi cũ giữ nguyên rồi di chuyển ở Sprint 5.5.
3. Giữ `AppStrings` nhưng chuyển thành getter theo locale (ít xáo trộn, mất `const`, phải tự lo rebuild khi đổi ngôn ngữ).

## 4. Điểm Cảnh Báo Của Scrum Master

1. **Dung lượng**: 23 SP đã vượt velocity gần nhất (Sprint 4 = 15 SP, trung bình bền vững 16–20 SP). Song ngữ **chưa nằm trong 23 SP**. Tổng thực tế có thể 26–30 SP.
2. **Thứ tự cắt đã thống nhất nếu trễ**: nhóm lọc `Course Duration` → màn Filter → màn Search. PO có quyền đổi thứ tự này.
3. **Chặn trình tự**: `WBS-S5-00` (spike ADR-005) phải xong trước mọi task UI vì cách khai báo chuỗi ảnh hưởng toàn bộ code.
4. **Roadmap đang lệch nhau**: phần đầu file đã dịch sprint (+1) nhưng phần thân vẫn ghi `Sprint 4 = Courses + Learning Player`, `Sprint 5 = Live`. Chưa sửa vì phụ thuộc P4.
5. **Learning Player (Domain 06) chưa có chỗ trong roadmap** sau khi bị loại khỏi Sprint 5.

## 5. Ánh Xạ Mã Story

| Tài liệu tính năng | Backlog Sprint 5 |
| :--- | :--- |
| US-07 (Hub, lọc môn) + US-07d (Grid, tim) | US-16 |
| US-07b (Search) | US-17 |
| US-07c (Filter 4 chiều) | US-18 |
| US-08 (Overview + Curriculum) | US-19 |
| Hạ tầng dữ liệu + API | US-15, US-20 |

## 6. Hành Động

| STT | Việc | Người | Hạn |
| :---: | :--- | :---: | :---: |
| A1 | Spike và ADR-005 song ngữ, kèm ước lượng SP | Tech Lead | Ngày 1 |
| A2 | Chốt P4 (re-baseline roadmap) | PO | Trước Sprint Review |
| A3 | Sửa phần thân roadmap theo P4 | PM | Sau A2 |
| A4 | Cập nhật chuỗi `AppStrings` theo ADR-005 | Dev FE | Sau A1 |
| A5 | Dev FE bắt đầu US-16 | Dev FE | Sau A1 |
