# Bộ Kịch Bản Kiểm Thử Thủ Công (Manual Test Cases) — Sprint 5
## Phân Hệ Khám Phá Khóa Học & Chi Tiết Giáo Trình (`v0.5.0-courses-hub`)
### Tái Hiện 1:1 Bộ 6 Màn Hình Dribbble Benchmark (Domain 04 & Domain 05)

- **Người lập kịch bản**: Sub-Agent QA / QC Tester — *"The Paranoid Inquisitor"*
- **Người thẩm định**: Sub-Agent Tech Lead & Sub-Agent PO
- **Phiên bản đích**: `v0.5.0-courses-hub`
- **Tài sản đối sánh (Ground Truth)**: `assets/design_references/screens/04_courses_01` $\rightarrow$ `05_course_detail_02`
- **Kỷ luật kiểm thử**: Chuẩn ISTQB (EP, BVA, State Transition, Adversarial Error Guessing), CẤM DU DI.

---

## 🎯 1. Hướng Dẫn & Môi Trường Kiểm Thử Dành Cho Tester

### 1.1. Thiết Bị & Cấu Hình Thử Nghiệm Khuyến Nghị
1. **Thiết bị chuẩn (Standard Screen)**: iPhone 13/14/15/16 (hoặc Simulator 390×844) / Android Pixel 7 (412×915).
2. **Thiết bị màn hình nhỏ (Small Viewport - BVA)**: iPhone SE 2020/2022 (375×667) hoặc Android 360×640 dp.
3. **Chế độ kiểm tra tiếp cận (Accessibility)**: Bật cỡ chữ phóng to **1.3x – 1.5x** trong Cài đặt hệ thống (Display & Text Size).

### 1.2. Cách Vào Phân Hệ Sprint 5 Trên Ứng Dụng
1. Mở ứng dụng Kiddora. Nếu ở màn hình Đăng nhập/Onboarding, chọn **Dùng thử / Chế độ Khách (Guest Mode)** hoặc đăng nhập bằng tài khoản mẫu.
2. Tại màn hình chính (`HomeScreen`), quan sát thanh điều hướng đất sét ở đáy (`ClayBottomNav`).
3. Chạm vào **Tab thứ 2 (Icon Khóa học / Sách mở)** để vào `CoursesHubBody`.

### 1.3. Bảng Dữ Liệu Khóa Học Mẫu (Mock Benchmark Data)
Toàn bộ dữ liệu kiểm thử được nạp sẵn từ `MockCourseDatasource`:
- `course_amazing_animals`: Amazing Animals (Khoa học, 7–10 tuổi, Cơ bản, 5 bài, 4.8★, Nổi bật).
- `course_space_exploration`: Space Exploration (Khoa học, 8–12 tuổi, Trung cấp, 6 bài, 4.9★, Nổi bật).
- `course_math_fun_numbers`: Math Fun with Numbers (Toán học, 7–10 tuổi, Cơ bản, 5 bài, 4.7★, Nổi bật).
- `course_creative_drawing`: Creative Drawing (Nghệ thuật, 7–12 tuổi, Cơ bản, 8 bài, 4.8★, Nổi bật).
- `course_our_planet`: Our Planet (Khoa học, 8–12 tuổi, Trung cấp, 6 bài, 4.6★, Thường).
- `course_intro_technology`: Intro to Technology (Công nghệ, 9–12 tuổi, Nâng cao, 5 bài, 4.9★, Thường).

---

## 📱 PHẦN 1: MÀN HÌNH COURSES HUB (`04_courses_01`)

### TC-HUB-01: Kiểm tra Render giao diện tổng thể Courses Hub
- **Mã kịch bản**: `TC-HUB-01`
- **Mức độ ưu tiên**: `P0 (Blocker)`
- **Kỹ thuật áp dụng**: Phân vùng tương đương (EP)
- **Tiền điều kiện**: Ứng dụng đang ở màn hình chính `HomeScreen`.
- **Các bước thực hiện**:
  1. Chạm vào tab thứ 2 trên thanh điều hướng đáy (`ClayNavTab.courses`).
  2. Quan sát toàn bộ bố cục từ trên xuống dưới.
- **Dữ liệu thử nghiệm**: N/A.
- **Kết quả mong đợi**:
  - [ ] Header hiển thị tiêu đề `"Khóa học"` (Quicksand 700), phụ đề `"Khám phá, Học tập & Lớn khôn!"`.
  - [ ] Góc trên bên phải header có nút tròn chứa icon kính lúp tím (`ClayIconButton` $\ge 48\times48\text{dp}$).
  - [ ] Thẻ Hero Banner màu tím pastel với tiêu đề `"Tương lai tươi sáng bắt đầu từ đây!"`, minh họa cậu bé đeo balo vẫy tay và ngôi sao.
  - [ ] Dải 5 thẻ danh mục bo góc: `Tất cả` (All), `Khoa học` (Science), `Toán học` (Math), `Ngôn ngữ` (Language), `Nghệ thuật` (Arts). Thẻ `Tất cả` có nền nổi bật active.
  - [ ] Tiêu đề mục `"Khóa học nổi bật"` và nút chữ `"Xem tất cả"` màu tím.
  - [ ] Lưới 2 cột hiển thị 4 thẻ khóa học nổi bật: `Amazing Animals`, `Space Exploration`, `Math Fun with Numbers`, `Creative Drawing`. Mỗi thẻ có hình 3D, nhãn môn học, số bài, lứa tuổi và nút tròn tím `>`.

---

### TC-HUB-02: Lọc nhanh danh mục môn học trên Courses Hub
- **Mã kịch bản**: `TC-HUB-02`
- **Mức độ ưu tiên**: `P0 (Blocker)`
- **Kỹ thuật áp dụng**: Chuyển đổi trạng thái (State Transition)
- **Tiền điều kiện**: Đang ở màn hình `CoursesHubBody`, thẻ `Tất cả` đang được chọn.
- **Các bước thực hiện**:
  1. Chạm vào thẻ danh mục `"Khoa học"`. Quan sát lưới khóa học.
  2. Chạm vào thẻ danh mục `"Toán học"`. Quan sát lưới khóa học.
  3. Chạm vào thẻ danh mục `"Nghệ thuật"`. Quan sát lưới khóa học.
  4. Chạm vào thẻ danh mục `"Ngôn ngữ"`. Quan sát lưới khóa học.
  5. Chạm lại vào thẻ `"Tất cả"`.
- **Kết quả mong đợi**:
  - [ ] Khi chọn `"Khoa học"`: Thẻ `Khoa học` nổi bật; lưới chỉ hiển thị 2 khóa: `Amazing Animals` và `Space Exploration`. Không hiển thị thẻ Toán hay Nghệ thuật.
  - [ ] Khi chọn `"Toán học"`: Chỉ hiển thị duy nhất thẻ `Math Fun with Numbers`.
  - [ ] Khi chọn `"Nghệ thuật"`: Chỉ hiển thị duy nhất thẻ `Creative Drawing`.
  - [ ] Khi chọn `"Ngôn ngữ"`: Lưới trống không có khóa nào (vì mock data chưa có môn này), không xảy ra crash ứng dụng.
  - [ ] Khi bấm lại `"Tất cả"`: Hiển thị đầy đủ cả 4 khóa học nổi bật.
  - [ ] Chuyển đổi mượt mà, không bị giật khung hình.

---

### TC-HUB-03: Điều hướng từ Courses Hub sang các màn hình chức năng
- **Mã kịch bản**: `TC-HUB-03`
- **Mức độ ưu tiên**: `P0 (Blocker)`
- **Kỹ thuật áp dụng**: Chuyển đổi trạng thái (State Transition)
- **Tiền điều kiện**: Đang ở màn hình `CoursesHubBody`.
- **Các bước thực hiện**:
  1. Chạm vào nút kính lúp tròn ở góc trên phải Header.
  2. Nhấn nút Back để quay lại Hub.
  3. Chạm vào nút `"Xem tất cả"` cạnh mục Khóa học nổi bật.
  4. Nhấn nút Back để quay lại Hub.
  5. Chạm vào thẻ khóa học `"Amazing Animals"`.
- **Kết quả mong đợi**:
  - [ ] Bước 1: Điều hướng chính xác sang màn hình Tìm kiếm (`CourseSearchScreen`).
  - [ ] Bước 2: Quay lại Hub thành công, giữ nguyên trạng thái.
  - [ ] Bước 3: Điều hướng chính xác sang màn hình Lưới tất cả khóa học (`AllCoursesGridScreen`).
  - [ ] Bước 4: Quay lại Hub thành công.
  - [ ] Bước 5: Điều hướng chính xác sang màn hình Chi tiết khóa học (`CourseDetailScreen`).

---

## 🔍 PHẦN 2: MÀN HÌNH TÌM KIẾM THEO THỜI GIAN THỰC (`04_courses_02`)

### TC-SRC-01: Render giao diện tìm kiếm khóa học
- **Mã kịch bản**: `TC-SRC-01`
- **Mức độ ưu tiên**: `P1 (High)`
- **Kỹ thuật áp dụng**: Phân vùng tương đương (EP)
- **Tiền điều kiện**: Mở màn hình `CourseSearchScreen` từ Courses Hub.
- **Các bước thực hiện**:
  1. Quan sát bố cục màn hình tìm kiếm.
- **Kết quả mong đợi**:
  - [ ] Header có nút Back tròn, tiêu đề `"Tìm kiếm khóa học"`, phụ đề `"Tìm khóa học phù hợp nhất cho con!"`.
  - [ ] Ô tìm kiếm dạng pill đất sét bo cong, icon kính lúp tím, placeholder `"Tìm kiếm khóa học"`.
  - [ ] Khi chưa gõ từ khóa: không có icon "X" xóa text.

---

### TC-SRC-02: Tìm kiếm khớp từ khóa với Debounce 300ms
- **Mã kịch bản**: `TC-SRC-02`
- **Mức độ ưu tiên**: `P0 (Blocker)`
- **Kỹ thuật áp dụng**: Phân tích giá trị biên (BVA) & Thời gian đáp ứng
- **Tiền điều kiện**: Đang ở màn hình `CourseSearchScreen`.
- **Các bước thực hiện**:
  1. Chạm vào ô tìm kiếm, nhập từ khóa: `"Space"`.
  2. Dừng gõ và quan sát phản hồi sau khoảng 300ms.
- **Kết quả mong đợi**:
  - [ ] Sau 300ms debounce, xuất hiện tiêu đề `"Kết quả tìm kiếm (1)"`.
  - [ ] Danh sách kết quả hiển thị 1 thẻ ngang `Space Exploration`: có thumbnail 3D bên trái, tên khóa học, môn học `SCIENCE`, số bài `6 Bài học`, độ tuổi `Tuổi 8–12`, và icon mũi tên phải `>`.
  - [ ] Không xuất hiện các khóa học khác không liên quan.

---

### TC-SRC-03: Tìm kiếm không phân biệt hoa thường và xóa nhanh từ khóa
- **Mã kịch bản**: `TC-SRC-03`
- **Mức độ ưu tiên**: `P1 (High)`
- **Kỹ thuật áp dụng**: Phân vùng tương đương (EP) & State Transition
- **Tiền điều kiện**: Đang ở màn hình `CourseSearchScreen`.
- **Các bước thực hiện**:
  1. Nhập từ khóa chữ thường: `"math"`. Quan sát kết quả.
  2. Nhập từ khóa chữ hoa: `"MATH"`. Quan sát kết quả.
  3. Quan sát icon chữ "X" (close) ở góc phải ô tìm kiếm.
  4. Chạm vào icon `"X"`.
- **Kết quả mong đợi**:
  - [ ] Cả hai trường hợp `"math"` và `"MATH"` đều trả về đúng kết quả: `Math Fun with Numbers`.
  - [ ] Khi có ký tự trong ô nhập, icon `"X"` xuất hiện.
  - [ ] Khi chạm `"X"`, ô nhập được xóa sạch ngay lập tức, danh sách kết quả khôi phục trạng thái ban đầu.

---

### TC-SRC-04: Trạng thái không tìm thấy kết quả (Empty State)
- **Mã kịch bản**: `TC-SRC-04`
- **Mức độ ưu tiên**: `P1 (High)`
- **Kỹ thuật áp dụng**: Đoán lỗi / Kịch bản nghịch đảo (Adversarial Error Guessing)
- **Tiền điều kiện**: Đang ở màn hình `CourseSearchScreen`.
- **Các bước thực hiện**:
  1. Nhập một từ khóa ngẫu nhiên không tồn tại: `"xyz987654"`.
  2. Quan sát giao diện rỗng.
- **Kết quả mong đợi**:
  - [ ] Hiển thị icon kính lúp gạch chéo lớn (`search_off_rounded`).
  - [ ] Tiêu đề thân thiện: `"Không tìm thấy khóa học nào!"`.
  - [ ] Phụ đề gợi ý: `"Thử tìm kiếm với từ khóa khác như Toán, Khoa học nhé!"`.
  - [ ] Ứng dụng không bị đứng hình, không văng lỗi ngoại lệ.

---

### TC-SRC-05: Chạm vào thẻ kết quả tìm kiếm để xem chi tiết
- **Mã kịch bản**: `TC-SRC-05`
- **Mức độ ưu tiên**: `P0 (Blocker)`
- **Kỹ thuật áp dụng**: Chuyển đổi trạng thái (State Transition)
- **Tiền điều kiện**: Có kết quả tìm kiếm hiển thị trên màn hình.
- **Các bước thực hiện**:
  1. Nhập từ khóa `"Animal"`.
  2. Chạm vào thẻ kết quả `"Amazing Animals"`.
  3. Tại màn hình Chi tiết, bấm nút Back tròn.
- **Kết quả mong đợi**:
  - [ ] Chuyển tiếp mượt mà vào `CourseDetailScreen` đúng khóa học `Amazing Animals`.
  - [ ] Khi bấm Back, quay trở về `CourseSearchScreen` và giữ nguyên trạng thái tìm kiếm.

---

## ⚙️ PHẦN 3: BỘ LỌC ĐA TIÊU CHÍ 4 CHIỀU (`04_courses_03`)

### TC-FLT-01: Render đầy đủ 4 nhóm tiêu chí lọc đất sét
- **Mã kịch bản**: `TC-FLT-01`
- **Mức độ ưu tiên**: `P0 (Blocker)`
- **Kỹ thuật áp dụng**: Phân vùng tương đương (EP)
- **Tiền điều kiện**: Mở màn hình `CourseFilterScreen` (từ route điều hướng hoặc nút Filter).
- **Các bước thực hiện**:
  1. Cuộn màn hình kiểm tra toàn bộ 4 nhóm tiêu chí và nút thao tác.
- **Kết quả mong đợi**:
  - [ ] Header có nút Back, tiêu đề `"Bộ lọc khóa học"`, nút chữ đỏ `"Xóa bộ lọc"`.
  - [ ] Nhóm 1 (`Chủ đề / Môn học`): Đủ 7 chip (`Tất cả`, `Khoa học`, `Toán tư duy`, `Ngôn ngữ`, `Mỹ thuật & Sáng tạo`, `Công nghệ`, `Kỹ năng sống`).
  - [ ] Nhóm 2 (`Độ tuổi`): Đủ 4 chip (`Tất cả`, `7 – 8`, `9 – 10`, `11 – 12`).
  - [ ] Nhóm 3 (`Cấp độ khó`): Đủ 4 chip (`Tất cả`, `Cơ bản`, `Trung cấp`, `Nâng cao`).
  - [ ] Nhóm 4 (`Thời lượng khóa học`): Đủ 4 chip (`Tất cả`, `Ngắn (1–3 bài)`, `Vừa (4–6 bài)`, `Dài (7+ bài)`).
  - [ ] Nút CTA full-width ở đáy: `"Áp dụng bộ lọc"` kèm icon bộ chỉnh âm (`tune_rounded`).

---

### TC-FLT-02: Lọc kết hợp đa tiêu chí chính xác (Happy Path)
- **Mã kịch bản**: `TC-FLT-02`
- **Mức độ ưu tiên**: `P0 (Blocker)`
- **Kỹ thuật áp dụng**: Phân tích giá trị biên (BVA) & Lọc giao thoa
- **Tiền điều kiện**: Đang mở `CourseFilterScreen`.
- **Các bước thực hiện**:
  1. Tại nhóm Chủ đề: Chọn chip `"Khoa học"`.
  2. Tại nhóm Độ tuổi: Chọn chip `"7 – 8"`.
  3. Tại nhóm Cấp độ khó: Chọn chip `"Cơ bản"`.
  4. Tại nhóm Thời lượng: Chọn chip `"Vừa (4–6 bài)"`.
  5. Chạm vào nút `"Áp dụng bộ lọc"`.
- **Kết quả mong đợi**:
  - [ ] Mỗi lần chạm chip: Chip được chọn đổi màu tím `AppColors.brandPrimary`, phát haptic nhẹ.
  - [ ] Khi bấm `"Áp dụng bộ lọc"`: Màn hình bộ lọc đóng lại, danh sách khóa học bên ngoài cập nhật hiển thị đúng **duy nhất khóa học `Amazing Animals`** (vì thỏa mãn cả 4 điều kiện: Khoa học, 7–10 tuổi, Cơ bản, 5 bài học).

---

### TC-FLT-03: Chức năng "Xóa bộ lọc" (Clear All)
- **Mã kịch bản**: `TC-FLT-03`
- **Mức độ ưu tiên**: `P1 (High)`
- **Kỹ thuật áp dụng**: Chuyển đổi trạng thái (State Transition)
- **Tiền điều kiện**: Màn hình `CourseFilterScreen` đang có nhiều chip được chọn khác giá trị mặc định.
- **Các bước thực hiện**:
  1. Chạm vào nút chữ đỏ `"Xóa bộ lọc"` ở góc trên phải Header.
  2. Quan sát trạng thái của cả 4 nhóm chip.
- **Kết quả mong đợi**:
  - [ ] Toàn bộ 4 nhóm chip ngay lập tức trở về lựa chọn `"Tất cả"`.
  - [ ] Phát rung haptic phản hồi (`HapticFeedback.mediumImpact`).

---

### TC-FLT-04: Hủy thao tác lọc bằng nút Back
- **Mã kịch bản**: `TC-FLT-04`
- **Mức độ ưu tiên**: `P2 (Medium)`
- **Kỹ thuật áp dụng**: Kiểm tra hủy bỏ (Cancel State)
- **Tiền điều kiện**: Màn hình `CourseFilterScreen` đang mở.
- **Các bước thực hiện**:
  1. Chọn một vài chip ngẫu nhiên.
  2. KHÔNG bấm nút "Áp dụng bộ lọc", mà nhấn nút **Back** trên Header.
- **Kết quả mong đợi**:
  - [ ] Màn hình đóng lại, danh sách khóa học bên ngoài giữ nguyên bộ lọc cũ trước khi mở màn hình, không bị áp dụng những thay đổi dở dang.

---

## 🗂️ PHẦN 4: LƯỚI TẤT CẢ KHÓA HỌC & YÊU THÍCH (`04_courses_04`)

### TC-GRD-01: Render lưới 2 cột đủ 6 khóa học benchmark
- **Mã kịch bản**: `TC-GRD-01`
- **Mức độ ưu tiên**: `P0 (Blocker)`
- **Kỹ thuật áp dụng**: Phân vùng tương đương (EP)
- **Tiền điều kiện**: Bấm `"Xem tất cả"` từ Courses Hub để vào `AllCoursesGridScreen`.
- **Các bước thực hiện**:
  1. Cuộn xem toàn bộ lưới khóa học.
- **Kết quả mong đợi**:
  - [ ] Header có nút Back, tiêu đề `"Tất cả khóa học"`, phụ đề `"Khám phá và tìm kiếm khóa học con yêu thích!"`, và nút tìm kiếm tròn.
  - [ ] Thanh `ClayFilterBar` gồm 4 chip: `Tất cả`, `Khoa học`, `Toán học`, `Nghệ thuật`.
  - [ ] Lưới 2 cột hiển thị đầy đủ 6 khóa học benchmark:
    1. `Amazing Animals`
    2. `Space Exploration`
    3. `Math Fun with Numbers`
    4. `Creative Drawing`
    5. `Our Planet`
    6. `Intro to Technology`
  - [ ] Mỗi thẻ có nút tròn trắng chứa icon Trái tim ở góc trên bên phải hình ảnh.

---

### TC-GRD-02: Lọc nhanh qua thanh ClayFilterBar
- **Mã kịch bản**: `TC-GRD-02`
- **Mức độ ưu tiên**: `P1 (High)`
- **Kỹ thuật áp dụng**: Chuyển đổi trạng thái (State Transition)
- **Tiền điều kiện**: Đang ở màn hình `AllCoursesGridScreen`.
- **Các bước thực hiện**:
  1. Chạm vào chip `"Khoa học"` trên thanh filter bar.
  2. Chạm vào chip `"Toán học"`.
  3. Chạm vào chip `"Nghệ thuật"`.
  4. Chạm lại vào chip `"Tất cả"`.
- **Kết quả mong đợi**:
  - [ ] Khi chọn `"Khoa học"`: Lưới hiển thị 3 khóa (`Amazing Animals`, `Space Exploration`, `Our Planet`).
  - [ ] Khi chọn `"Toán học"`: Lưới hiển thị 1 khóa (`Math Fun with Numbers`).
  - [ ] Khi chọn `"Nghệ thuật"`: Lưới hiển thị 1 khóa (`Creative Drawing`).
  - [ ] Khi chọn `"Tất cả"`: Lưới khôi phục đủ 6 khóa.

---

### TC-GRD-03: Bật/Tắt Yêu Thích (Favorite Heart Button) & Đồng Bộ Trạng Thái
- **Mã kịch bản**: `TC-GRD-03`
- **Mức độ ưu tiên**: `P0 (Blocker)`
- **Kỹ thuật áp dụng**: Chuyển đổi trạng thái (State Transition)
- **Tiền điều kiện**: Đang ở màn hình `AllCoursesGridScreen`.
- **Các bước thực hiện**:
  1. Tìm thẻ khóa học `Amazing Animals`. Quan sát nút Trái tim (mặc định là viền xám).
  2. Chạm vào nút Trái tim.
  3. Chạm lại vào nút Trái tim lần thứ hai.
  4. Chạm lại để tim chuyển sang màu đỏ, sau đó chạm vào thân thẻ để mở `CourseDetailScreen`.
  5. Quan sát nút Trái tim trên Hero Image của màn hình Chi tiết.
- **Kết quả mong đợi**:
  - [ ] Bước 2: Nút tim chuyển sang màu đỏ đặc (`favorite_rounded`, `AppColors.favoriteHeartRed`), phát rung haptic.
  - [ ] Bước 3: Nút tim trở về viền xám (`favorite_border_rounded`).
  - [ ] Bước 4 & 5: Nút Trái tim trên đỉnh Hero Image của `CourseDetailScreen` **cũng hiển thị màu đỏ**, đồng bộ trạng thái yêu thích 100% trong phiên làm việc.

---

## 🦖 PHẦN 5: CHI TIẾT KHÓA HỌC & 4 FEATURES (`05_course_detail_01`)

### TC-DTL-01: Render Hero Image 3D & Nút điều hướng nổi
- **Mã kịch bản**: `TC-DTL-01`
- **Mức độ ưu tiên**: `P0 (Blocker)`
- **Kỹ thuật áp dụng**: Phân vùng tương đương (EP)
- **Tiền điều kiện**: Mở chi tiết khóa học `Amazing Animals`.
- **Các bước thực hiện**:
  1. Quan sát phần đầu màn hình (Top Hero).
- **Kết quả mong đợi**:
  - [ ] Banner Hero 3D hiển thị hình minh họa khóa học trên nền màu tím pastel (`blobLavender`).
  - [ ] Nút Back tròn nổi ở góc trên bên trái (`ClayIconButton` $\ge 48\times48\text{dp}$).
  - [ ] Nút Yêu thích tròn nổi ở góc trên bên phải. Chạm vào đổi trạng thái tim đỏ/xám mượt mà.

---

### TC-DTL-02: Kiểm tra Sheet thông tin khóa học & 3 Pill thông số
- **Mã kịch bản**: `TC-DTL-02`
- **Mức độ ưu tiên**: `P0 (Blocker)`
- **Kỹ thuật áp dụng**: Phân vùng tương đương (EP)
- **Tiền điều kiện**: Đang ở màn hình `CourseDetailScreen`.
- **Các bước thực hiện**:
  1. Quan sát phần thân thẻ trắng bo tròn góc lớn (`radiusSheetTop: 36dp`).
- **Kết quả mong đợi**:
  - [ ] Tiêu đề khóa học `"Amazing Animals"` (Quicksand 700).
  - [ ] Phụ đề sinh động: `"Khám phá thế giới động vật kỳ thú và môi trường sống của muôn loài!"`.
  - [ ] Đủ 3 Info Pills với màu riêng biệt:
    1. Pill 1: `"SCIENCE"` (nền xanh pastel `blobPeriwinkle`, chữ tím brand).
    2. Pill 2: `"Tuổi 7–10"` (nền tím nhạt `blobLavender`).
    3. Pill 3: `"5 Bài học"` (nền cam đào `blobPeach`, chữ cam streak).
  - [ ] Dòng đánh giá gồm 5 ngôi sao vàng (`ratingStarGold`) và chuỗi text `"4.8 (320 đánh giá)"`.

---

### TC-DTL-03: Hiển thị mục Giới thiệu & Lưới 4 Thẻ Tính Năng Nổi Bật
- **Mã kịch bản**: `TC-DTL-03`
- **Mức độ ưu tiên**: `P1 (High)`
- **Kỹ thuật áp dụng**: Phân vùng tương đương (EP)
- **Tiền điều kiện**: Đang ở màn hình `CourseDetailScreen`.
- **Các bước thực hiện**:
  1. Cuộn xuống phần nội dung phía dưới.
- **Kết quả mong đợi**:
  - [ ] Tiêu đề mục: `"Về khóa học này"` và đoạn mô tả chi tiết, rõ nét, ngắt dòng đúng chuẩn.
  - [ ] Lưới 2x2 gồm 4 thẻ tính năng nổi bật (`CourseFeatureCard`):
    1. Thẻ 1: `"Video Vui nhộn"` (icon Play tròn, nền xanh pastel).
    2. Thẻ 2: `"Câu đố Tương tác"` (icon Quiz, nền cam đào).
    3. Thẻ 3: `"Phiếu Thực hành"` (icon Assignment, nền vàng nhạt).
    4. Thẻ 4: `"Huy hiệu Thưởng"` (icon Medal, nền tím nhạt).

---

### TC-DTL-04: Nút CTA "Bắt đầu học ngay" (Start Learning)
- **Mã kịch bản**: `TC-DTL-04`
- **Mức độ ưu tiên**: `P0 (Blocker)`
- **Kỹ thuật áp dụng**: Chuyển đổi trạng thái (State Transition)
- **Tiền điều kiện**: Đang ở màn hình `CourseDetailScreen`.
- **Các bước thực hiện**:
  1. Quan sát nút cố định ở đáy màn hình: `"Bắt đầu học ngay"` kèm icon mũi tên phải `arrow_forward_rounded`.
  2. Chạm vào nút `"Bắt đầu học ngay"`.
- **Kết quả mong đợi**:
  - [ ] Nút có hiệu ứng nhấn xúc giác claymorphism.
  - [ ] Điều hướng chính xác sang màn hình Giáo trình bài học (`CourseCurriculumScreen`).

---

## 📚 PHẦN 6: GIÁO TRÌNH BÀI HỌC & 3 TABS (`05_course_detail_02`)

### TC-CUR-01: Header thu gọn & Bộ 3 Tab Pill Selector
- **Mã kịch bản**: `TC-CUR-01`
- **Mức độ ưu tiên**: `P0 (Blocker)`
- **Kỹ thuật áp dụng**: Phân vùng tương đương (EP)
- **Tiền điều kiện**: Mở màn hình `CourseCurriculumScreen`.
- **Các bước thực hiện**:
  1. Quan sát Header và thanh tab selector.
- **Kết quả mong đợi**:
  - [ ] Header thu gọn: Nút Back tròn, ảnh đại diện thumbnail vuông bo góc `64×64dp`, Tiêu đề `"Amazing Animals"`, phụ đề `"5 Bài học • SCIENCE"`.
  - [ ] Thanh 3 Tab Pill bo tròn: `"Bài học"` (Lessons), `"Giới thiệu"` (About), `"Đánh giá"` (Reviews).
  - [ ] Tab `"Bài học"` có nền màu tím Indigo nổi bật active mặc định.

---

### TC-CUR-02: Kiểm tra 3 trạng thái của 5 bài học trong Tab "Bài học"
- **Mã kịch bản**: `TC-CUR-02`
- **Mức độ ưu tiên**: `P0 (Blocker)`
- **Kỹ thuật áp dụng**: Chuyển đổi trạng thái (State Transition) & Visual Verification
- **Tiền điều kiện**: Đang ở tab `"Bài học"` của `CourseCurriculumScreen`.
- **Các bước thực hiện**:
  1. Quan sát lần lượt cả 5 thẻ bài học trong danh sách.
- **Kết quả mong đợi**:
  - [ ] **Bài 1 (`Meet the Animals` - 10 phút)**: Trạng thái **Đã hoàn thành** $\rightarrow$ Icon tròn màu xanh lá (`Meadow Mint`) chứa dấu tick trắng `✓`.
  - [ ] **Bài 2 (`Animals and Their Habitats` - 12 phút)**: Trạng thái **Đang mở khóa** $\rightarrow$ Icon tròn màu tím brand (`Primary Indigo`) chứa mũi tên chevron phải `>`.
  - [ ] **Bài 3 (`Food and Eating Habits` - 10 phút)**: Trạng thái **Bị khóa** $\rightarrow$ Icon tròn màu xám chứa biểu tượng ổ khóa `🔒`.
  - [ ] **Bài 4 (`Animal Life Cycles` - 15 phút)**: Trạng thái **Bị khóa** $\rightarrow$ Icon tròn màu xám chứa biểu tượng ổ khóa `🔒`.
  - [ ] **Bài 5 (`How We Can Help` - 10 phút)**: Trạng thái **Bị khóa** $\rightarrow$ Icon tròn màu xám chứa biểu tượng ổ khóa `🔒`.

---

### TC-CUR-03: Tương tác với bài học đang mở khóa (Chế độ Demo)
- **Mã kịch bản**: `TC-CUR-03`
- **Mức độ ưu tiên**: `P0 (Blocker)`
- **Kỹ thuật áp dụng**: Đoán lỗi / Kịch bản nghiệp vụ (PO Decision Rule)
- **Tiền điều kiện**: Đang ở tab `"Bài học"`.
- **Các bước thực hiện**:
  1. Chạm vào bài học số 2: `"Animals and Their Habitats"`.
- **Kết quả mong đợi**:
  - [ ] Thiết bị phát rung nhẹ haptic.
  - [ ] Xuất hiện SnackBar thông báo: `"Bài học này đang ở chế độ xem thử. Nội dung đầy đủ sẽ sớm ra mắt!"`.
  - [ ] **TUYỆT ĐỐI KHÔNG mở trình phát video hay văng crash** (Do phạm vi Domain 06 Video Player thuộc Sprint 6).

---

### TC-CUR-04: Tương tác với bài học bị khóa
- **Mã kịch bản**: `TC-CUR-04`
- **Mức độ ưu tiên**: `P1 (High)`
- **Kỹ thuật áp dụng**: Kiểm tra hành vi chặn (Guard Check)
- **Tiền điều kiện**: Đang ở tab `"Bài học"`.
- **Các bước thực hiện**:
  1. Chạm vào bài học số 3: `"Food and Eating Habits"` (hoặc bài 4, bài 5).
- **Kết quả mong đợi**:
  - [ ] Xuất hiện SnackBar nhắc nhở khích lệ: `"Con hãy hoàn thành các bài học trước để mở khóa bài này nhé!"`.
  - [ ] Bài học không mở ra, không có tác vụ điều hướng sai.

---

### TC-CUR-05: Thẻ Banner Phần Thưởng Huy Hiệu Vàng (Reward Banner)
- **Mã kịch bản**: `TC-CUR-05`
- **Mức độ ưu tiên**: `P1 (High)`
- **Kỹ thuật áp dụng**: Phân vùng tương đương (EP)
- **Tiền điều kiện**: Đang ở tab `"Bài học"`.
- **Các bước thực hiện**:
  1. Cuộn xuống cuối danh sách bài học.
- **Kết quả mong đợi**:
  - [ ] Thẻ banner màu kem vàng bo góc lớn.
  - [ ] Icon cúp vàng 3D nổi bật.
  - [ ] Thông điệp: `"Hoàn thành tất cả bài học để nhận huy hiệu đặc biệt!"`.

---

### TC-CUR-06: Chuyển đổi và nội dung Tab "Giới thiệu" (About Tab)
- **Mã kịch bản**: `TC-CUR-06`
- **Mức độ ưu tiên**: `P1 (High)`
- **Kỹ thuật áp dụng**: Chuyển đổi trạng thái (State Transition)
- **Tiền điều kiện**: Đang ở `CourseCurriculumScreen`.
- **Các bước thực hiện**:
  1. Chạm vào tab `"Giới thiệu"`.
- **Kết quả mong đợi**:
  - [ ] Tab "Giới thiệu" đổi màu tím active.
  - [ ] Danh sách bài học ẩn đi, hiển thị tiêu đề `"Về khóa học này"` và văn bản giới thiệu chi tiết.
  - [ ] Chuyển tab tức thời ($\le 16\text{ms}$), không bị đơ giật.

---

### TC-CUR-07: Chuyển đổi và nội dung Tab "Đánh giá" (Reviews Tab)
- **Mã kịch bản**: `TC-CUR-07`
- **Mức độ ưu tiên**: `P1 (High)`
- **Kỹ thuật áp dụng**: Chuyển đổi trạng thái (State Transition)
- **Tiền điều kiện**: Đang ở `CourseCurriculumScreen`.
- **Các bước thực hiện**:
  1. Chạm vào tab `"Đánh giá"`.
- **Kết quả mong đợi**:
  - [ ] Tab "Đánh giá" đổi màu tím active.
  - [ ] Hiển thị hàng 5 ngôi sao vàng lớn ở giữa màn hình.
  - [ ] Điểm số trung bình: `"4.8 / 5.0"` (Quicksand 700).
  - [ ] Tổng số đánh giá: `"320 đánh giá"`.

---

## ⚡ PHẦN 7: PHI CHỨC NĂNG, CÔNG THÁI HỌC & GÓC KHUẤT BIÊN (NON-FUNCTIONAL & PARANOID EDGE-CASES)

### TC-NFR-01: Chống tràn giao diện (No RenderFlex Overflow) trên màn hình nhỏ
- **Mã kịch bản**: `TC-NFR-01`
- **Mức độ ưu tiên**: `P0 (Blocker - Zero Tolerance)`
- **Kỹ thuật áp dụng**: Phân tích giá trị biên (BVA)
- **Tiền điều kiện**: Sử dụng máy có màn hình nhỏ (hoặc chạy Simulator iPhone SE 375×667 / Android 360×640).
- **Các bước thực hiện**:
  1. Mở lần lượt 6 màn hình: `CoursesHubBody`, `CourseSearchScreen`, `CourseFilterScreen`, `AllCoursesGridScreen`, `CourseDetailScreen`, `CourseCurriculumScreen`.
  2. Cuộn hết màn hình từ trên xuống dưới.
- **Kết quả mong đợi**:
  - [ ] **100% TUYỆT ĐỐI KHÔNG xuất hiện vạch sọc vàng đen `A RenderFlex overflowed by ... pixels`**.
  - [ ] Không có chữ bị cắt cụt hay đè lên nhau.

---

### TC-NFR-02: Khả năng tiếp cận khi Phóng to cỡ chữ (Text Scale 1.5x)
- **Mã kịch bản**: `TC-NFR-02`
- **Mức độ ưu tiên**: `P0 (Blocker - Zero Tolerance)`
- **Kỹ thuật áp dụng**: Accessibility & BVA
- **Tiền điều kiện**: Cài đặt máy hệ thống: Bật Phóng to chữ lớn (Font Scale / Text Size = 1.3x - 1.5x).
- **Các bước thực hiện**:
  1. Khởi động lại ứng dụng và duyệt qua 6 màn hình Sprint 5.
  2. Quan sát các nút bấm, thẻ danh mục, thanh filter chip và thẻ khóa học 2 cột.
- **Kết quả mong đợi**:
  - [ ] Chữ tự động xuống dòng mượt mà hoặc co giãn hợp lý.
  - [ ] Không bị tràn khung thẻ hay vỡ bóng đổ đất sét Claymorphism.
  - [ ] Nút bấm vẫn đảm bảo kích thước chạm tối thiểu $\ge 48\times48\text{dp}$.

---

### TC-NFR-03: Thử nghiệm phá hoại bấm liên tục (Monkey Tap / Spam CTA)
- **Mã kịch bản**: `TC-NFR-03`
- **Mức độ ưu tiên**: `P1 (High)`
- **Kỹ thuật áp dụng**: Đoán lỗi & Kịch bản phá hoại (Adversarial Error Guessing)
- **Tiền điều kiện**: Mở màn hình `CourseDetailScreen`.
- **Các bước thực hiện**:
  1. Dùng ngón tay bấm thật nhanh 10 lần liên tục vào nút `"Bắt đầu học ngay"`.
  2. Tại màn hình Search, gõ và xóa liên tục từ khóa trong 5 giây.
  3. Tại màn hình Grid, bấm liên tục vào icon Trái tim 10 lần.
- **Kết quả mong đợi**:
  - [ ] Ứng dụng chỉ mở duy nhất **1 màn hình `CourseCurriculumScreen`**, không bị đẩy chồng chéo 10 route.
  - [ ] Search debounce triệt tiêu các tác vụ thừa, không bị crash hoặc giật đơ màn hình (ANR).
  - [ ] Nút tim đổi trạng thái chính xác, không bị race-condition.

---

### TC-NFR-04: Điều hướng cử chỉ Vuốt cạnh (Swipe Back Gesture)
- **Mã kịch bản**: `TC-NFR-04`
- **Mức độ ưu tiên**: `P1 (High)`
- **Kỹ thuật áp dụng**: Thao tác cử chỉ hệ điều hành (Platform Gestures)
- **Tiền điều kiện**: Sử dụng máy iOS (hoặc Android bật thanh cử chỉ vuốt cạnh).
- **Các bước thực hiện**:
  1. Từ `CourseCurriculumScreen`, vuốt từ mép trái màn hình sang phải để quay về `CourseDetailScreen`.
  2. Từ `CourseDetailScreen`, vuốt mép trái để quay về `CoursesHubBody`.
- **Kết quả mong đợi**:
  - [ ] Điều hướng pop mượt mà, chuyển động tự nhiên.
  - [ ] Không bị nháy trắng, không bị kẹt màn hình đen.
  - [ ] Vị trí cuộn trang của màn hình trước được bảo toàn nguyên vẹn.

---

### TC-NFR-05: Chế độ Ngoại Tuyến (Offline / Airplane Mode Test)
- **Mã kịch bản**: `TC-NFR-05`
- **Mức độ ưu tiên**: `P0 (Blocker)`
- **Kỹ thuật áp dụng**: Ngắt kết nối mạng bất ngờ
- **Tiền điều kiện**: Điện thoại đang bật kết nối Wifi/4G.
- **Các bước thực hiện**:
  1. Bật **Chế độ Máy bay (Airplane Mode)** ngắt hoàn toàn Internet.
  2. Mở tab Khóa học (`CoursesHubBody`).
  3. Thử tìm kiếm `"Space"` và áp dụng bộ lọc.
  4. Mở chi tiết và xem giáo trình bài giảng.
- **Kết quả mong đợi**:
  - [ ] Ứng dụng đọc dữ liệu cache / Mock Datasource mượt mà, không giật lag.
  - [ ] **TUYỆT ĐỐI KHÔNG xuất hiện thông báo crash `SocketException` hay văng ứng dụng ra màn hình chính**.

---

## 📋 8. Bảng Check-list Đánh Giá Nhanh (Quick Manual Checklist)

| STT | Hạng Mục Kiểm Thử | Màn Hình | Đạt (PASS) | Lỗi (FAIL) | Ghi Chú |
| :---: | :--- | :--- | :---: | :---: | :--- |
| 1 | Render đủ 4 khối nội dung (Header, Banner, 5 Danh mục, Popular Grid) | Courses Hub | [ ] | [ ] | |
| 2 | Chuyển đổi 5 chip danh mục lọc đúng khóa học tương ứng | Courses Hub | [ ] | [ ] | |
| 3 | Nút kính lúp mở màn hình Tìm kiếm | Courses Hub | [ ] | [ ] | |
| 4 | Nút "Xem tất cả" mở màn hình Lưới tất cả khóa học | Courses Hub | [ ] | [ ] | |
| 5 | Tìm kiếm theo thời gian thực có Debounce 300ms | Search Screen | [ ] | [ ] | |
| 6 | Nút "X" xóa nhanh từ khóa trong ô tìm kiếm | Search Screen | [ ] | [ ] | |
| 7 | Empty State thân thiện khi từ khóa không khớp | Search Screen | [ ] | [ ] | |
| 8 | Hiển thị đủ 4 nhóm tiêu chí trong bộ lọc | Filter Screen | [ ] | [ ] | |
| 9 | Áp dụng bộ lọc đa tiêu chí lọc đúng khóa học | Filter Screen | [ ] | [ ] | |
| 10 | Nút "Xóa bộ lọc" reset toàn bộ về "Tất cả" | Filter Screen | [ ] | [ ] | |
| 11 | Lưới 2 cột hiển thị đủ 6 khóa học benchmark | All Courses Grid | [ ] | [ ] | |
| 12 | Bật/tắt nút Trái tim yêu thích đổi màu đỏ/xám | All Courses Grid | [ ] | [ ] | |
| 13 | Giữ trạng thái Yêu thích khi chuyển sang màn khác | Toàn hệ thống | [ ] | [ ] | |
| 14 | Màn chi tiết hiển thị đủ Hero 3D, 3 Pill, 5 sao, 4 Feature Cards | Course Detail | [ ] | [ ] | |
| 15 | Bấm "Bắt đầu học ngay" chuyển sang màn Giáo trình | Course Detail | [ ] | [ ] | |
| 16 | Header thu gọn hiển thị đúng thumbnail 64x64 và thông tin | Curriculum | [ ] | [ ] | |
| 17 | 5 bài học hiển thị đúng 3 trạng thái (xanh tick, tím mở, xám khóa) | Curriculum | [ ] | [ ] | |
| 18 | Bấm bài đang mở hiện SnackBar demo, không mở video | Curriculum | [ ] | [ ] | |
| 19 | Bấm bài khóa hiện SnackBar nhắc nhở khích lệ | Curriculum | [ ] | [ ] | |
| 20 | Banner cúp vàng nhận huy hiệu hiển thị ở cuối | Curriculum | [ ] | [ ] | |
| 21 | Chuyển đổi giữa 3 Tab (Bài học / Giới thiệu / Đánh giá) mượt mà | Curriculum | [ ] | [ ] | |
| 22 | 0 lỗi RenderFlex Overflow trên màn hình nhỏ 360x640 | Toàn bộ 6 màn | [ ] | [ ] | |
| 23 | Hoạt động bình thường khi bật chế độ máy bay (Offline) | Toàn hệ thống | [ ] | [ ] | |
| 24 | Mọi touch target nút bấm đạt chuẩn $\ge 48\times48\text{dp}$ | Toàn bộ 6 màn | [ ] | [ ] | |

---

## 🐞 9. Mẫu Báo Cáo Lỗi Khi Phát Hiện Bug (Defect Report Template)

Nếu tester phát hiện bất kỳ lỗi nào trong quá trình kiểm thử thủ công, vui lòng ghi nhận lỗi theo mẫu sau và gửi lại cho Dev xử lý:

```markdown
### [BUG-S5-XX] <Tiêu đề lỗi ngắn gọn, súc tích>
- **Màn hình xảy ra lỗi**: (VD: CourseSearchScreen / CourseCurriculumScreen)
- **Mức độ nghiêm trọng**: [S1 - Blocker / S2 - Critical / S3 - Major / S4 - Minor]
- **Mã testcase liên quan**: (VD: TC-SRC-02, TC-NFR-01)
- **Thiết bị & Cấu hình**: (VD: iPhone 13 Simulator iOS 17 / Máy thật Android 13)
- **Các bước tái hiện (Steps to Reproduce)**:
  1. Bước 1...
  2. Bước 2...
  3. Bước 3...
- **Kết quả thực tế (Actual Result)**: (Mô tả hành vi sai, vỡ layout, tràn pixel...)
- **Kết quả mong đợi (Expected Result)**: (Hành vi đúng theo PRD và Design spec)
- **Ảnh chụp / Video đính kèm**: (Screenshot hoặc log đính kèm nếu có)
```

