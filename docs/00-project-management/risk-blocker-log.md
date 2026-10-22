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
