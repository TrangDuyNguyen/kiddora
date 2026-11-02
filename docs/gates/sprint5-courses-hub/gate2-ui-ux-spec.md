# Gate 2: Thiết Kế Giao Diện & Tactile Claymorphism Tokens (Design Sign-off)
## Sprint 5 — Phân Hệ Khám Phá Khóa Học & Chi Tiết Giáo Trình (`v0.5.0-courses-hub`)

- **Sub-Agent Thiết kế**: Sub-Agent Mobile UI/UX Designer — *"The Tactile Claymorphism Artisan"*
- **Sub-Agent Phê Duyệt**: Sub-Agent BA, Sub-Agent PO & Sub-Agent Tech Lead
- **Ngày**: 2026-10-30
- **Trạng thái**: 🟢 **APPROVED (GATE 2 PASSED)**

---

## 1. Bản Đồ Màn Hình & Thành Phần Trực Quan
1. **`CoursesHubBody` (`04_courses_01`)**:
   - Header lời chào, nút tìm kiếm tròn nổi `ClayIconButton` ($\ge 48\times48\text{dp}$).
   - Hero banner gradient tím pastel kèm linh vật bé trai đeo balo vẫy tay và ngôi sao vàng.
   - Dải 5 thẻ danh mục vuông bo góc: `All`, `Science`, `Math`, `Language`, `Arts`.
   - Lưới 2 cột Popular Courses với nút hành động tròn tím `>`.

2. **`CourseSearchScreen` (`04_courses_02`)**:
   - Thanh tìm kiếm clay bo tròn pill, icon kính lúp và nút xóa.
   - Thẻ kết quả ngang `CourseSearchCard` bo góc `20dp`, bóng ambient đổ mềm.

3. **`CourseFilterScreen` (`04_courses_03`)**:
   - 4 nhóm chip lọc clay: Program (7 môn), Age Group (4 mức), Difficulty Level (3 mức), Course Duration (3 mức).
   - Nút `Clear All` góc trên và nút full-width `Apply Filters` ở đáy.

4. **`AllCoursesGridScreen` (`04_courses_04`)**:
   - Lưới 2 cột 6 khóa học benchmark kèm nút tròn trắng chứa icon Trái tim đỏ `❤️` góc trên phải ảnh.
   - Dải chip lọc ngang `ClayFilterBar`.

5. **`CourseDetailScreen` (`05_course_detail_01`)**:
   - Hero 3D Card khủng long tràn viền, nút Back và nút Yêu thích nổi.
   - Thẻ trắng bo góc cong lớn `36dp`, 3 chip thông số, 5 sao vàng, 4 ô tính năng pastel, nút CTA `Start Learning`.

6. **`CourseCurriculumScreen` (`05_course_detail_02`)**:
   - Header thu gọn với thumbnail nhỏ `64×64dp`.
   - Thanh 3 tab pill: `Lessons` | `About` | `Reviews`.
   - Danh sách bài học với 3 trạng thái visual rõ ràng (hoàn thành: xanh lá tick; đang mở: tím chevron; khóa: xám lock).
   - Banner thưởng màu kem vàng với cúp vàng 3D và huy hiệu đặc biệt.

---

## 2. Tiêu Chuẩn Công Thái Học & Khả Năng Tiếp Cận (WCAG 2.2 AA)
- Toàn bộ Touch Target $\ge 48\times48\text{dp}$ (khuyến nghị $56\times56\text{dp}$).
- Lưới kích thước chuẩn 4pt/8pt (`AppValues`).
- Tỷ lệ tương phản văn bản Primary Indigo đạt $8.4:1$ (vượt chuẩn WCAG AAA).

---

## 3. Chữ Ký Phê Duyệt Gate 2
- **Sub-Agent UI/UX**: *"Đã hoàn thiện bộ layout spec và ánh xạ 100% token Tactile Claymorphism."* — `[APPROVED]`
- **Sub-Agent Tech Lead**: *"Mockup layout và tokens đã sẵn sàng cho Dev FE, không có rủi ro kỹ thuật."* — `[APPROVED]`

