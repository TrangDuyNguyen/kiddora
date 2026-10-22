# Đặc Tả Giao Diện UI/UX Specs: Chi Tiết Khóa Học (FEAT-07)

- **Feature**: `FEAT-07`
- **Sub-Agent**: Sub-Agent UI/UX Designer
- **Asset đối sánh Dribbble**: `assets/design_references/screens/05_course_detail_01_overview_about.png` và `05_course_detail_02_curriculum_lessons.png`

---

## 🎨 1. Tokens & Bố Cục Màn Hình Chi Tiết

- **Top App Bar**: Nút Back đất sét tròn $44\text{ dp}$ và nút Bookmark lưu khóa học yêu thích (STEM Pink `#EC4899`).
- **Course Banner Image**: Chiều cao $200\text{ dp}$, bo góc dưới $24\text{ dp}$, phủ lớp bóng đổ mờ nhẹ.
- **Rating & Metadata**: Xếp hạng sao vàng Joyful Amber `#F59E0B`, số lượng review và nhãn độ tuổi phù hợp.
- **Feature Icons Row**: 4 vòng tròn màu pastel đường kính $44\text{ dp}$, icon biểu trưng tương tác.
- **3-Segment Tabs**: Chiều cao $44\text{ dp}$, nền xám sứ `#F3F4F6`, bo góc $22\text{ dp}$, tab active có nền trắng và bóng đổ nảy nhẹ.
- **Lessons List Item**: Chiều cao $68\text{ dp}$, bo góc $14\text{ dp}$, vòng tròn số thứ tự bài học, icon play nhỏ, nhãn thời lượng $12\text{ sp}$.
- **Sticky Bottom CTA**: Nút [Start Learning] chiều cao $54\text{ dp}$, bo góc $16\text{ dp}$, màu Primary Indigo `#4648D4`.

---

## 📱 2. Danh Sách 5 Trạng Thái Màn Hình
1. **Default**: Hiển thị đầy đủ thông tin khóa học và danh sách bài giảng.
2. **Switching Tabs**: Hiệu ứng chuyển động fade mượt mà giữa các tab.
3. **Completed Course State**: Nếu khóa học đã học xong $100\%$, nút CTA đổi thành [Review Course / Certificate].
4. **Offline Mode**: Các bài học chưa tải về có icon đám mây nhỏ cho phép tải về máy.
5. **Loading**: Hiển thị banner shimmer và các khung xám bài học đang nạp.
