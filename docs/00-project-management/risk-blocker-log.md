# Sổ Nhật Ký Rủi Ro & Điểm Nghẽn (Risk & Blocker Log)

- **Quản lý bởi**: Sub-Agent Project Manager (PM) & Sub-Agent QA Tester (Gate 3/6)
- **Chu kỳ rà soát**: Cập nhật liên tục theo từng Quality Gate
- **Ngày cập nhật**: 2026-10-22

| Mã Risk/Blocker | Mức Độ | Sub-Agent Báo Cáo | Mô Tả & Tác Động | Phương Án Giảm Thiểu | Trạng Thái |
|:---|:---:|:---|:---|:---|:---:|
| `RSK-INIT-01` | Medium | `tech-lead` | Xung đột phiên bản SDK môi trường local | Kiểm tra pre-flight script trước khi code | 🟢 MITIGATED |
| `BLK-VIS-01` | Critical | `qa-tester` | S1 RenderFlex overflowed by 32px khi text scale 1.5x | Sử dụng Wrap layout và responsive constraints | 🟢 RESOLVED |
| `BLK-VIS-02` | Major | `qa-tester` | S2 Header Camera Scanner bị lẹm vào Dynamic Island | Sử dụng SafeArea & MediaQuery padding | 🟢 RESOLVED |
| `BLK-VIS-03` | Major | `qa-tester` | S2 Độ tương phản text màu vi phạm WCAG AA | Chuẩn hóa bảng màu AppColors (Contrast ratio 8.4:1) | 🟢 RESOLVED |
| `RSK-003` | Medium | `tech-lead` | Xung đột cuộn ListWheelScrollView với SingleChildScrollView | Khóa physics hoặc dùng FixedExtentScrollController | 🟢 RESOLVED |
| `RSK-004` | Major | `tech-lead` | Spam click mascot audio gây lag main thread | Debounce 300ms & Haptic squish engine nhẹ | 🟢 RESOLVED |
| `RSK-005` | Major | `pm` / `po` | Nhúng 57 ảnh benchmark màn hình làm phình APK | Tách riêng assets/design_references ra khỏi runtime bundle | 🟢 RESOLVED |
| `RSK-006` | Medium | `qa-tester` | Mock data khóa học cần khớp với 14 domains Dribbble | Xây dựng domain entities chuẩn Freezed & mock repository | 🟡 IN_PROGRESS |
| `RSK-007` | Major | `ui-ux-designer` | Lệch style 3D Clay hoặc dính viền trắng khi tách nền PNG | Tách nền flood-fill + color unmixing RGBA 32-bit, kiểm định trên nền tím | 🟢 RESOLVED |
| `RSK-008` | Critical | `qa-tester` | RenderFlex overflow trong `ClayDialog` trên màn `360×640` & `textScaler: 1.5x` | `ConstrainedBox(maxHeight: 0.86 * screenH)` + `Flexible` + `SingleChildScrollView` | 🟢 RESOLVED |
| `RSK-009` | Major | `ui-ux-designer` | Vùng chạm nút `Close (×)`, `Filter Pill`, `Compact Button` nhỏ hơn `48×48dp` | Bọc ngoài bằng `SizedBox`/`ConstrainedBox` `48×48dp` với `HitTestBehavior.opaque` | 🟢 RESOLVED |
| `RSK-010` | Major | `pm` / `ba` | Trôi lệch tài liệu khi mở rộng `shared/ui_kit/` và đổi Tab 5 sang `Profile` | Đồng bộ đầy đủ `DESIGN.md`, `CR-013`, PRD `FEAT-04`, WBS & `graphify update .` | 🟢 RESOLVED |
| `RSK-011` | Medium | `tech-lead` | `HomeScreen` có nguy cơ vượt 200 dòng khi thêm tab Courses | Tách `HomeDashboardBody` trước khi thêm `CoursesHubBody` | 🟡 OPEN |
| `RSK-012` | Major | `ui-ux-designer` | Thiếu asset 3D runtime cho ảnh khóa học/bài học (chỉ có `course_dino.png`) | PO chốt 29/10: nội dung bài học và asset chỉ ở mức demo, dùng asset sẵn có làm placeholder; sản xuất asset thật dời sang các Sprint sau | 🟢 ACCEPTED (không còn chặn) |
| `RSK-013` | Medium | `tech-lead` | Tab About/Reviews không có benchmark | PO đã chốt: làm tối giản, dữ liệu demo | 🟢 RESOLVED |
| `RSK-014` | Medium | `qa-tester` | Thêm tab Courses có thể làm vỡ điều hướng tab Tests hiện tại | Test hồi quy bắt buộc | 🟡 OPEN |
