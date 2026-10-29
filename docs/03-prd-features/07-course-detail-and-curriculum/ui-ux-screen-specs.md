# Đặc Tả Giao Diện UI/UX Specs: Chi Tiết Khóa Học (FEAT-07)

- **Feature**: `FEAT-07`
- **Sub-Agent**: UI/UX Designer, rà soát bởi Tech Lead
- **Asset đối sánh**: `05_course_detail_01_overview_about.png`, `05_course_detail_02_curriculum_lessons.png`
- **Nguyên tắc**: kích thước/màu lấy từ `AppValues`/`AppColors`, không magic number.

---

## 1. Ánh Xạ Component Tái Sử Dụng

| Thành phần trên ảnh | Component | Ghi chú |
| :--- | :--- | :--- |
| Nút Back / tim tròn nổi trên ảnh | `ClayIconButton` | Vùng chạm $\ge 48\text{dp}$ |
| Thẻ nội dung trắng bo góc trên (`05_01`) | `ClayWaveSheet` hoặc `ClayCard` | Chọn loại đã có sẵn trong `surfaces/` |
| Header thu gọn (`05_02`) | `ClayScreenHeader` | Thêm thumbnail qua `trailing`/leading nếu cần, không viết header mới |
| 3 tab pill `Lessons/About/Reviews` | `ClayFilterBar` (3 mục) | Dùng lại thay vì viết `TabBar` mới |
| Nút `Start Learning` | `ClayButton` primary | Full-width, sticky đáy |
| Thẻ bài học | `ClayListTile` (leading = số + thumbnail, trailing = trạng thái) | |
| Pill thông số (`Science`, `Ages`, `Lessons`) | **Mới**: `CourseMetaPill` | Nhỏ, dùng chung Hub + Detail |
| Banner huy hiệu cuối danh sách | **Mới**: `CourseBadgeBanner` | |

## 2. Trạng Thái Bài Học (3 Biến Thể Trailing)
- **Hoàn thành**: vòng tròn xanh `Meadow Mint` + dấu tick.
- **Đang mở**: vòng tròn `Primary Indigo` + chevron.
- **Khóa**: vòng tròn xám + ổ khóa; chạm hiển thị `lessonLockedAlert`.

## 3. Năm Trạng Thái Màn Hình
1. **Default**.
2. **Loading**: shimmer ảnh bìa và 5 hàng bài học.
3. **Course không tồn tại (404)**: hiển thị `detail` từ Backend (nguyên tắc CR-010).
4. **Đã hoàn thành 100%**: CTA đổi nhãn (chỉ nếu PO chốt, mặc định chưa làm).
5. **Offline**: dùng `ClayDialog` lỗi mạng sẵn có.
