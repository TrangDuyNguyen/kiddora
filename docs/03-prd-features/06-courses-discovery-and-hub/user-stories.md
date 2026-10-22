# Kịch Bản BDD User Stories: Khám Phá Khóa Học (FEAT-06)

- **Feature**: `FEAT-06` — Courses Discovery Hub & Filter Sheet
- **Tác giả**: Sub-Agent BA — *"The Pedantic Logician"*

---

## User Story US-07: Tìm Kiếm & Lọc Khóa Học

**Là một** học sinh hoặc phụ huynh đang tìm khóa học phù hợp,  
**Tôi muốn** lọc theo môn học, gõ từ khóa tìm kiếm và áp dụng bộ lọc lứa tuổi,  
**Để** nhanh chóng chọn được khóa học bổ ích và vừa sức.

### Kịch Bản 1: Lọc khóa học theo Danh mục môn học (Category Chip)
- **Given** người dùng đang ở màn hình `CoursesHubScreen` với chip *"All"* đang được chọn.
- **When** người dùng chạm vào chip *"Science"*.
- **Then** lưới khóa học lập tức lọc và chỉ hiển thị các khóa học thuộc lĩnh vực Khoa học (*Amazing Animals, Space Exploration*).

### Kịch Bản 2: Tìm kiếm theo từ khóa
- **Given** người dùng đang ở ô tìm kiếm.
- **When** người dùng nhập từ khóa `"Space"`.
- **Then** màn hình hiển thị danh sách kết quả phù hợp kèm tiêu đề *"Search Results (12)"*.

### Kịch Bản 3: Mở và áp dụng bộ lọc Bottom Sheet
- **Given** người dùng chạm vào icon bộ lọc (Filter Icon) trên thanh tìm kiếm.
- **When** bảng `FilterCoursesSheet` trượt lên từ dưới, người dùng chọn độ tuổi *"9-10"* và nhấn `Apply Filters`.
- **Then** bảng bộ lọc đóng lại, lưới khóa học làm mới danh sách khớp với tiêu chí đã chọn.
