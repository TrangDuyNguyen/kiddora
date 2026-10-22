# Đặc Tả Tính Năng (PRD): Chi Tiết Khóa Học & Giáo Trình Bài Giảng (FEAT-07)

- **Mã tính năng**: `FEAT-07`
- **Tên tính năng**: Course Detail & Lessons Curriculum
- **Module**: `features/exploration`
- **Sub-Agent Quản trị**: Sub-Agent BA & Sub-Agent PO
- **Trạng thái**: 🟡 **Planned for Sprint 4** (`v0.4.0`)
- **Tài sản đối sánh Dribbble**: `assets/design_references/screens/05_course_detail_01_overview_about.png` và `05_course_detail_02_curriculum_lessons.png`

---

## 1. Bối Cảnh & Mục Tiêu Nghiệp Vụ

### 1.1. Bối Cảnh
Khi học sinh chọn một khóa học từ Hub, màn hình Chi tiết khóa học cung cấp thông tin toàn diện về nội dung, đánh giá chất lượng từ phụ huynh khác, danh sách từng bài học kèm thời lượng, giúp trẻ và phụ huynh dễ dàng ra quyết định bắt đầu học.

### 1.2. Chỉ Số Đo Lường (KPIs)
- **Start Learning Conversion**: $\ge 65\%$ lượt xem chi tiết khóa học chuyển đổi thành hành động bấm [Start Learning].
- **Tab Switching Speed**: Chuyển đổi giữa 3 tab (*Lessons, About, Reviews*) phản hồi tức thời $\le 16\text{ms}$.

---

## 2. Phạm Vi Tính Năng (Feature Scope)
1. **Course Hero Banner**: Hình ảnh minh họa 3D chất lượng cao, tên khóa học lớn, huy hiệu danh mục môn học, số sao đánh giá (4.8 sao / 320 reviews).
2. **Feature Highlights Row**: 4 biểu tượng tính năng nổi bật (*Fun Videos, Interactive Quizzes, Activity Sheets, Earn Badges*).
3. **3-Tab Navigation Segment**: 3 tab đất sét chuyển đổi mượt mà:
   - **Tab Lessons**: Danh sách từng bài học có số thứ tự, tên bài, thời lượng (10 min, 15 min), trạng thái hoàn thành hoặc khóa.
   - **Tab About**: Đoạn giới thiệu sinh động về mục tiêu kiến thức đạt được.
   - **Tab Reviews**: Đánh giá và nhận xét thực tế từ các phụ huynh khác.
4. **Sticky Bottom Action Bar**: Nút lớn [Start Learning] màu Indigo nổi bật nằm cố định trong vùng ngón tay cái dễ bấm.
