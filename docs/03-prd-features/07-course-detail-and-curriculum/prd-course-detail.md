# Đặc Tả Tính Năng (PRD): Chi Tiết Khóa Học & Giáo Trình Bài Giảng (FEAT-07)

- **Mã tính năng**: `FEAT-07`
- **Tên tính năng**: Course Overview & Lessons Curriculum
- **Module**: `features/exploration`
- **Sub-Agent Quản trị**: Sub-Agent BA & Sub-Agent PO
- **Trạng thái**: 🟡 **Sprint 5** (`v0.5.0-courses-hub`) — Đã qua Gate 0 Tech Lead Review
- **Tài sản đối sánh Dribbble (1:1)**:
  - `05_course_detail_01_overview_about.png` (Overview)
  - `05_course_detail_02_curriculum_lessons.png` (Curriculum + 3 tabs)

---

## 1. Bối Cảnh & Mục Tiêu
Khi chọn khóa học từ Hub, trẻ và phụ huynh cần thấy tổng quan nội dung, đánh giá và lộ trình bài học để quyết định bắt đầu học.

### KPIs
- **Start Learning Conversion**: $\ge 65\%$ lượt xem chi tiết bấm `Start Learning`.
- **Tab Switching**: phản hồi $\le 16\text{ms}$.

---

## 2. Phạm Vi Tính Năng (Theo Đúng Ảnh Benchmark)

### 2.1. Màn `CourseOverview` (`05_course_detail_01`)
1. Ảnh bìa 3D tràn viền trên (khủng long), nút Back tròn (trái) và nút tim yêu thích tròn (phải) nổi trên ảnh.
2. Thẻ nội dung trắng bo góc trên: tiêu đề `Amazing Animals`, phụ đề `Discover the wonderful world of animals and their habitats!`.
3. **3 pill thông số**: `Science`, `Ages 7–10`, `5 Lessons`; dòng sao `4.8 (320 reviews)`.
4. Mục `About This Course` + đoạn mô tả.
5. **4 ô tính năng**: `Fun Videos`, `Interactive Quizzes`, `Activity Sheets`, `Earn Badges` (mỗi ô một màu pastel riêng).
6. Nút đáy `Start Learning` full-width kèm icon play và mũi tên.

### 2.2. Màn `CourseCurriculum` (`05_course_detail_02`)
1. Header thu gọn: Back + thumbnail $64\times64$ + `Amazing Animals` + `5 Lessons • Science`.
2. **3 tab pill**: `Lessons` (active) | `About` | `Reviews`.
3. **5 thẻ bài học** (số thứ tự, thumbnail 3D, tên, thời lượng, trạng thái):
   1. `Meet the Animals` — 10 min — hoàn thành (tick xanh lá)
   2. `Animals and Their Habitats` — 12 min — đang mở (chevron tím)
   3. `Food and Eating Habits` — 10 min — khóa
   4. `Animal Life Cycles` — 15 min — khóa
   5. `How We Can Help` — 10 min — khóa
4. Banner cuối kem vàng: cúp vàng + `Complete all lessons to earn a special badge!` + huy hiệu.

---

## 3. Điểm Mở Cần PO Quyết Định (Open Questions)

| # | Câu hỏi | Mặc định Tech Lead đề xuất |
| :---: | :--- | :--- |
| 1 | `Start Learning` đi đâu khi Lesson Player (Domain 06) chưa làm? | Mở màn `CourseCurriculum` (05_02). Chạm bài đang mở chỉ phát haptic + snackbar, chưa phát video. |
| 2 | Tab `About` và `Reviews` **không có ảnh benchmark**. | Làm tối giản: `About` dùng lại mô tả + 4 ô tính năng; `Reviews` hiển thị điểm tổng, ghi rõ dữ liệu mẫu. Không thiết kế mới ngoài benchmark. |
| 3 | Trạng thái tiến độ (bài 1 hoàn thành, bài 2 mở) lấy từ đâu? | Sprint 5: dữ liệu seed tĩnh. Bảng `user_progress` cá nhân hóa dời sang Sprint 6. |
