# Đặc Tả Giao Diện UI/UX Specs: Khám Phá Khóa Học (FEAT-06)

- **Feature**: `FEAT-06`
- **Sub-Agent**: UI/UX Designer, rà soát bởi Tech Lead
- **Asset đối sánh**: `assets/design_references/screens/04_courses_01` → `04_courses_04`
- **Nguyên tắc**: mọi kích thước/màu phải lấy từ `AppValues`/`AppColors`; các số dp bên dưới chỉ là **tham chiếu thiết kế**, Dev phải ánh xạ sang token sẵn có (không tạo magic number).

---

## 1. Ánh Xạ Component Tái Sử Dụng (`shared/ui_kit`)

| Thành phần trên ảnh | Component | Ghi chú |
| :--- | :--- | :--- |
| Header `Courses` + nút kính lúp | `ClayScreenHeader` (`trailing`) + `ClayIconButton` | Màn Hub không có Back |
| Header Search / Filter | `ClayScreenHeader` có Back | |
| Chip môn học ngang (`04_04`) | `ClayFilterBar` | Dùng nguyên, không viết lại |
| Hàng kết quả tìm kiếm | `ClayListTile` hoặc `ClayCard` | Cần thumbnail trái, chevron phải |
| Nút `Apply Filters`, `Clear All` | `ClayButton` primary / secondary | |
| Thẻ khóa học lưới | **Mới**: `CourseClayCard` (feature widget) | Bọc `RepaintBoundary`; chỉ tạo mới vì chưa có card tương đương |
| Category card dọc (`04_01`) | **Mới**: `CourseCategoryCard` (feature widget) | Khác `ClayFilterBar` (chip ngang) |

## 2. Quy Tắc Bố Cục
- Lưới 2 cột, tỉ lệ thẻ ~0.78 (đo trên ảnh), khoảng cách theo thang 4pt.
- Mọi vùng chạm $\ge 48\times48\text{dp}$ (nút tròn `>`, tim, kính lúp, chip).
- Chip lọc cuộn ngang, không được gây overflow ở $360\times640$ với `textScaler: 1.5x`.

## 3. Năm Trạng Thái Màn Hình
1. **Default**: dữ liệu đầy đủ.
2. **Loading**: shimmer 4 thẻ.
3. **Empty (Search)**: minh họa linh vật + `Không tìm thấy khóa học nào!`.
4. **Error**: dùng `ClayDialog` lỗi mạng sẵn có (`modalErrorTitle`).
5. **Filter đang áp dụng**: hiển thị số bộ lọc đang bật trên nút lọc (chỉ khi có >= 1 bộ lọc khác `All`).
