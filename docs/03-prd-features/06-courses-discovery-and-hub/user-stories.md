# Kịch Bản BDD User Stories: Khám Phá Khóa Học (FEAT-06)

- **Feature**: `FEAT-06` — Courses Hub, Search, Filter & All Courses Grid
- **Tác giả**: Sub-Agent BA, rà soát bởi Tech Lead (Gate 0)

---

## US-07: Khám Phá Khóa Học Từ Tab Courses

**Là một** học sinh, **tôi muốn** xem khóa học nổi bật và lọc theo môn, **để** chọn nhanh khóa học mình thích.

### Kịch Bản 1: Mở tab Courses
- **Given** người dùng đang ở `HomeScreen`.
- **When** chạm tab `Courses` trên `ClayBottomNav`.
- **Then** thân màn hình đổi sang Courses Hub (không đẩy route mới) với tiêu đề `Courses`, banner `A Brighter Future Starts Here!` và 4 thẻ `Popular Courses`.

### Kịch Bản 2: Lọc theo môn học
- **Given** thẻ `All` đang active.
- **When** chạm thẻ `Science`.
- **Then** danh sách chỉ còn khóa học môn Science.

## US-07b: Tìm Kiếm Khóa Học

### Kịch Bản 3: Mở màn tìm kiếm bằng nút kính lúp
- **Given** người dùng ở Courses Hub.
- **When** chạm nút tròn kính lúp.
- **Then** mở `CourseSearchScreen` với tiêu đề `Search Courses`.

### Kịch Bản 4: Tìm theo từ khóa
- **Given** người dùng ở `CourseSearchScreen`.
- **When** nhập `Space`.
- **Then** hiển thị `Search Results (N)` với N bằng số khóa học khớp thực tế từ API (không cố định 12).

### Kịch Bản 5: Không có kết quả
- **Given** từ khóa không khớp khóa học nào.
- **Then** hiển thị trạng thái rỗng với `noCoursesFoundTitle` và nút `clearSearch`.

## US-07c: Lọc Đa Tiêu Chí

### Kịch Bản 6: Áp dụng 4 chiều lọc
- **Given** người dùng mở `CourseFilterScreen`.
- **When** chọn `Science`, `7 – 8`, `Beginner`, `Medium (4–6 lessons)` rồi chạm `Apply Filters`.
- **Then** quay lại danh sách với kết quả khớp đồng thời cả 4 tiêu chí.

### Kịch Bản 7: Xóa bộ lọc
- **When** chạm `Clear All`.
- **Then** cả 4 nhóm trở về `All`.

## US-07d: Xem Toàn Bộ Khóa Học

### Kịch Bản 8: Mở lưới tất cả khóa học
- **When** chạm `See All` ở mục `Popular Courses`.
- **Then** mở `AllCoursesGridScreen` hiển thị 6 khóa học trong lưới 2 cột, mỗi thẻ có nút tim yêu thích.

### Kịch Bản 9: Bật/tắt yêu thích
- **When** chạm tim trên một thẻ.
- **Then** tim đổi trạng thái đầy/rỗng ngay (cục bộ, chưa đồng bộ server).
