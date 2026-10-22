# Đặc Tả Giao Diện UI/UX Specs: Khám Phá Khóa Học (FEAT-06)

- **Feature**: `FEAT-06`
- **Sub-Agent**: Sub-Agent UI/UX Designer
- **Asset đối sánh Dribbble**: `assets/design_references/screens/04_courses_01_explore_and_categories.png` đến `04_courses_04_all_courses_grid.png`

---

## 🎨 1. Tokens & Bố Cục Lưới Khóa Học

- **Search Bar**: Chiều cao $50\text{ dp}$, bo góc $25\text{ dp}$, nền xám sứ `#F3F4F6`, viền `#E5E7EB`, nút icon Filter màu Indigo `#4648D4`.
- **Category Chips**: Chiều cao $38\text{ dp}$, bo góc tròn $19\text{ dp}$. Trạng thái active: nền Primary Indigo `#4648D4`, chữ trắng, bóng nổi nhẹ.
- **2-Column Course Cards**: Lưới 2 cột với tỷ lệ khung hình `aspectRatio: 0.78`, thẻ đất sét trắng bo góc $18\text{ dp}$, hình minh họa bo tròn $12\text{ dp}$, huy hiệu số bài học và độ tuổi nhỏ gọn.
- **Filter Bottom Sheet**: Bo tròn 2 góc trên $24\text{ dp}$, thanh kéo bo tròn phía trên, các nhóm chip lựa chọn xếp theo hàng ngang, nút lớn [Apply Filters] full-width.

---

## 📱 2. Danh Sách 5 Trạng Thái Màn Hình
1. **Default**: Hiển thị lưới toàn bộ khóa học phổ biến (Popular Courses).
2. **Filtering / Searching**: Hiển thị kết quả tìm kiếm thời gian thực.
3. **Empty Results**: Hiển thị hình minh họa đất sét ngộ nghĩnh kèm câu *"No courses found! Try searching something else."*.
4. **Bottom Sheet Open**: Nền mờ `rgba(0,0,0,0.4)` phía sau, bảng bộ lọc trượt lên êm ái.
5. **Loading**: Hiển thị 4 thẻ shimmer xám nhạt trong lúc nạp danh sách khóa học.
