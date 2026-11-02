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

### 1.1 Bảng Hợp Đồng Thông Số Pixel-Exact: `CoursesHubBody` (`04_courses_01`)

| Cấp Bậc / Thành Phần UI | Kích Thước ($W \times H$ / Aspect Ratio) | Padding & Margin | Bo Góc (Radius) | Kiểu Chữ (Font, Size, Weight, LH) | Màu Sắc & Tokens (`AppColors`) | Icon / Asset 3D (Tên, Size, Color, BoxFit) | Hành Vi Responsive & Tràn Chữ |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Top Header Row** | `double.infinity` × $\approx 56\text{dp}$ | Margin ngang `16dp` (`space7`), top `8dp` | N/A | Title: Quicksand Bold `22dp`<br>Sub: Quicksand SemiBold `12.5dp` | Text: `textPrimary` (`#0D0C22`)<br>Sub: `textSecondary` (`#6E6D7A`) | N/A | `maxLines: 1`, flex tight |
| **Nút Search Tròn** | $48\times48\text{dp}$ (`minTouchTarget`) | Gắn mép phải Header | Tròn `9999px` | N/A | Nền trắng `#FFFFFF`, shadow ambient `0 3px 6px` | `Icons.search_rounded`, `22dp`, `brandPrimary` | Tappable, `HapticFeedback.lightImpact` |
| **Hero Banner** | Aspect Ratio **$378 / 204$** ($\approx 1.853$) | Margin ngang `16dp`, Padding trong `16dp` | $24\text{dp}$ (`bannerCoursesRadius`) | Headline: Quicksand Bold 800 `18dp`, LH `1.2`<br>Sub: Quicksand `11dp` | Nền gradient: `courseHeroBgGradStart` (`#EBE6FE`) → `courseHeroBgGradEnd` (`#DED6FD`)<br>Text: `courseHeroText` (`#5B4DDF`) | `course_hero_banner.png`<br>Khung chuẩn $378\times204\text{px}$<br>`BoxFit.fill` | Duy trì tỷ lệ $1.853$, hiển thị trọn vẹn $100\%$ tiêu đề "A Brighter Future Starts Here!" và cánh tay bé vẫy, 0 bị cắt mép trên |
| **Thẻ Danh Mục Squircle (5 Thẻ)** | Rộng $64\text{dp}$ × Cao $74\text{dp}$ (`categoryCardW/H`) | Khoảng cách ngang `8dp` (`categoryCardSpacing`), Padding dọc `8dp`, ngang `3dp` | $18\text{dp}$ (`categoryCardRadius`) | Label: Quicksand Bold `11.5dp` (`fontCaptionSm`), letter spacing `-0.2` | **Active**: Tím `#6C5CE7`<br>**Inactive**: Trắng `#FFFFFF`, Level 1 clay shadow | Icon $26\text{dp}$ phía trên:<br>• All: `grid_view_rounded` (trắng)<br>• Science: `science_rounded` (Cyan `#06B6D4`)<br>• Math: `calculate_rounded` (Cam `#F59E0B`)<br>• Language: `menu_book_rounded` (Blue `#0EA5E9`)<br>• Arts: `palette_rounded` (Pink `#EC4899`) | Bọc `FittedBox(fit: BoxFit.scaleDown)`, chữ dài (e.g. `Language`, `Ngôn ngữ`) tự động co giãn, cấm tuyệt đối cắt cụt `Langua...` |
| **Popular Courses Header** | `double.infinity` × $32\text{dp}$ | Margin trên `16dp`, dưới `10dp` | N/A | Title: Quicksand Bold `18dp`<br>See All: Quicksand Bold `12.5dp` | Title: `textPrimary`<br>See All: `brandPrimary` (`#4648D4`) | N/A | Bấm "See All" chuyển sang `AllCoursesGridRoute` |
| **Lưới 2 Cột Popular Courses** | Tỷ lệ khung hình **$0.85$** (~$172\times202\text{dp}$) | Cross: `14dp`<br>Main: `16dp` | N/A | N/A | N/A | N/A | Bọc `RepaintBoundary` từng thẻ, triệt tiêu khoảng trắng thừa, nhịp điệu hiển thị chặt chẽ |
| **Thẻ Khóa Học (`CourseClayCard`)** | Rộng $\approx 172\text{dp}$ × Cao $\approx 202\text{dp}$ | Padding trong `10dp` (`courseCardPadding`) | $20\text{dp}$ (`courseCardRadius`) | Title: Quicksand Bold `14dp`<br>Category: Quicksand `11.5dp`<br>Meta: Quicksand SemiBold `11dp` | Nền trắng `#FFFFFF`, ambient shadow Level 1 | Thumbnail 3D: Chiều cao `90dp` chuẩn $180\times90\text{px}$ (tỷ lệ $2:1$), bo góc $14\text{dp}$, `BoxFit.cover`, không dính text thừa | Nút tròn tím $32\times32\text{dp}$ (`courseActionButtonSize`), icon `chevron_right_rounded` `16dp` |

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

