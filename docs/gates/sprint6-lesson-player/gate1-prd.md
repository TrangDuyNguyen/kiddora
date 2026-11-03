# Gate 1: Đặc Tả Yêu Cầu Nghiệp Vụ (PRD Sign-off)
## Sprint 6 — Trình Phát Bài Học Chuẩn Sư Phạm 5E & Mini-Game Xúc Giác (`v0.6.0-lesson-player`)

- **Sub-Agent Lập PRD**: Sub-Agent Business Analyst (BA) — *"The Pedantic Logician"*
- **Sub-Agent Phê Duyệt**: Sub-Agent Product Owner (PO) — *"The Strategic Tyrant"*
- **Đồng thẩm định**: Sub-Agent Tech Lead & Sub-Agent Scrum Master
- **Ngày**: 2026-11-03
- **Trạng thái**: 🟢 **APPROVED (GATE 1 PASSED)**

---

## 1. Mục Tiêu & Phạm Vi Bàn Giao (25 SP)

Hiện thực hóa toàn diện Trình phát bài học 5E chuẩn sư phạm quốc tế và tích hợp trọn gói 3 màn hình benchmark Domain 06:
1. `06_learning_01`: **Continue Lesson Player Screen** (Trình phát bài học mẹ, thanh hạt đậu nảy 5E, bộ điều phối stage, hộp thoại thoát xác nhận).
2. `06_learning_02`: **Course Progress Tracker Screen** (Tiến độ khóa học tổng thể, danh sách module phân đoạn với 3 trạng thái rõ rệt: Completed tick xanh, In Progress tím active, Locked xám ổ khóa).
3. `06_learning_03`: **Course Completed Celebration Screen** (Màn hình ăn mừng hoàn thành khóa học, pháo hoa ngôi sao, linh vật chúc mừng, thưởng $+10$ sao, giữ chuỗi streak).
4. Thư viện **5 Widget Mini-Game Xúc Giác Đất Nặn Play-Doh** tái sử dụng tại `shared/ui_kit/games/`.
5. Hệ thống kịch bản **JSON DSL Freezed** và API Backend đồng bộ tiến độ học tập (`FastAPI + PostgreSQL JSONB`).

---

## 2. Tiêu Chí Nghiệm Thu BDD (Given-When-Then)

### US-23: Data Models Freezed `LessonBlueprint` & JSON DSL Parser
- **Given**: File kịch bản JSON DSL bài học hợp lệ (ví dụ: `lesson_anim_01_exploration.json`).
- **When**: Hệ thống gọi `LessonBlueprint.fromJson()`.
- **Then**: Chuyển đổi thành công thành đối tượng Dart bất biến, các trường cấu hình chặng (`LessonStageConfig`) và mini-game được parse chính xác không gây runtime error.

### US-24: Thư Viện 5 Widget Mini-Game Xúc Giác Đất Nặn
- **Given**: Trẻ đang chơi một trong 5 mini-game (`ClayDragDropSorter`, `ClayScaleBalancer`, `ClayBubblePopper`, `MagicStrokeTracer`, `ClayCardFlipper`).
- **When**: Trẻ thực hiện tương tác kéo thả, bấm vỡ, cân thăng bằng, nối nét hoặc lật thẻ.
- **Then**: 
  - Nếu thao tác đúng: Hiệu ứng nảy đàn hồi (Spring), phát hào quang vàng Joyful Amber và rung nhẹ haptic (`lightImpact` hoặc `mediumImpact`).
  - Nếu thao tác sai: Vật thể nảy ngược về chỗ cũ nhẹ nhàng kèm âm thanh bloop, không trừ điểm, không hiện màn hình "Game Over".
  - Nếu trẻ không tương tác trong $15\text{ giây}$: Kích hoạt Smart Hint khẽ lắc lư vật phẩm đúng.

### US-25: Trình Phát Bài Học 5E Engine & Bộ Điều Phối (`06_learning_01`)
- **Given**: Trẻ bấm nút "Bắt đầu học" từ một bài học cụ thể trong `CourseCurriculumScreen`.
- **When**: Màn hình `LessonPlayerScreen` mở ra.
- **Then**: Thanh tiến độ hiển thị 5 hạt đậu đất sét tương ứng 5 chặng (E1 $\rightarrow$ E5). Bộ điều phối tự động nạp giao diện phù hợp với từng chặng (*Engage: Mascot đối thoại; Explore: Khám phá tự do; Explain: Thẻ tóm tắt 3D; Elaborate: Mini-game xúc giác; Evaluate: Chúc mừng & thưởng sao*).
- **Given**: Trẻ bấm nút [X] (Thoát) ở góc trên.
- **When**: Hộp thoại `ExitConfirmationDialog` xuất hiện.
- **Then**: Trẻ có thể chọn "Học tiếp" để ở lại hoặc "Lưu & Thoát" để quay về màn hình trước mà không bị mất tiến độ chặng đã qua.

### US-26: Màn Hình Tiến Độ & Ăn Mừng Hoàn Thành (`06_learning_02`, `06_learning_03`)
- **Given**: Trẻ xem lộ trình học của khóa học trong `CourseProgressTrackerScreen`.
- **When**: Giao diện được dựng.
- **Then**: Hiển thị tỷ lệ phần trăm tiến độ, tổng số sao đạt được, và danh sách các bài học thể hiện rõ trạng thái (Đã học xong, Đang học dở, Chưa mở khóa).
- **Given**: Trẻ hoàn thành bài học cuối cùng của khóa học.
- **When**: Chuyển tiếp sang màn `CourseCompletedCelebrationScreen`.
- **Then**: Hiển thị pháo hoa ngôi sao đất sét, linh vật nhảy múa chúc mừng, cộng $+10$ sao, thắp sáng ngọn lửa streak và trao huy hiệu danh dự 3D.

### US-27: FastAPI Backend Endpoints cho Blueprint & Đồng Bộ Tiến Độ
- **Given**: Ứng dụng gửi `GET /api/v1/lessons/{id}/blueprint`.
- **When**: Request đến server backend.
- **Then**: Trả về mã HTTP 200 kèm toàn bộ cấu trúc JSON DSL của bài học được lưu trong cột `blueprint_json`.
- **Given**: Trẻ hoàn thành bài học và gửi `POST /api/v1/lessons/{id}/complete`.
- **When**: Request được xác thực.
- **Then**: Backend tự động cộng $+10$ sao vào hồ sơ trẻ (`kid_profiles`), cập nhật ngày streak (`streak_days`), ghi nhận `UserProgress` và trả về HTTP 200.

---

## 3. Chữ Ký Phê Duyệt Gate 1

- **Sub-Agent BA**: *"Toàn bộ yêu cầu bài học 5E, quy tắc Safe-to-Fail và trải nghiệm học tập của trẻ đã được đặc tả chính xác $100\%$ không còn độ lệch."* — `[APPROVED]`
- **Sub-Agent PO**: *"Phê duyệt trọn gói phạm vi 25 SP cho Sprint 6, cam kết tiến độ và chất lượng không thỏa hiệp."* — `[APPROVED]`
- **Sub-Agent Scrum Master**: *"Quy trình lập kế hoạch Sprint 6 đã tuân thủ chuẩn Scrum, năng lực phân bổ hài hòa, sẵn sàng chuyển sang giai đoạn thực thi Gate 2 & Gate 4."* — `[APPROVED]`

