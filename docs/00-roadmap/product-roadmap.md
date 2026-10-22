# Bản Đồ Lộ Trình Sản Phẩm Kiddora (Product Roadmap)

- **Quản lý bởi**: Sub-Agent Product Owner (PO) — *"The Strategic Tyrant"*
- **Phiên bản hiện tại**: `v0.3.0` (Sprint 3 Hoàn thành & Hardening) $\rightarrow$ `v0.4.0` (Sprint 4 Đang chuẩn bị kích hoạt)
- **Cập nhật lần cuối**: 2026-10-22
- **Tình trạng tổng thể**: 🟢 Các Sprint 1, 2, 3 hoàn thành 100% — Sẵn sàng kích hoạt Sprint 4: Khám phá Khóa học & Lộ trình Bài giảng (`v0.4.0`)

---

## 🧭 Mô Hình Lộ Trình 3 Chân Trời (3-Horizon Framework)

```
       ┌──────────────────────────────────────────────────────────────┐
       │   🟢 CHÂN TRỜI 1: HISTORICAL (v0.1.0 đến v0.3.0)             │
       │   - v0.1.0 (Sprint 1): Onboarding tương tác 3 Slides & Guard │
       │   - v0.2.0 (Sprint 2): Kid Profile v2 (Age Spinner, 12 Giáp) │
       │   - v0.3.0 (Sprint 3): 3 Màn hình 1:1 (Login, Home, Goal)    │
       │   - Hardening: Register Screen, Native Splash, Ponytail Code, │
       │                Bóc tách 57 Màn hình Dribbble qua 14 Domains. │
       └──────────────────────────────┬───────────────────────────────┘
                                      │
                                      ▼
       ┌──────────────────────────────────────────────────────────────┐
       │   🟡 CHÂN TRỜI 2: NOW (v0.4.0 — SPRINT 4)                    │
       │   - EPIC-COURSE-01: Khám Phá & Lưới Khóa Học (Domain 04)     │
       │   - EPIC-COURSE-02: Chi Tiết Khóa Học & Bài Giảng (Domain 05)│
       │   - EPIC-LEARN-01 : Trình Phát Tiếp Bài Giảng (Domain 06)    │
       └──────────────────────────────┬───────────────────────────────┘
                                      │
                                      ▼
       ┌──────────────────────────────────────────────────────────────┐
       │   🟣 CHÂN TRỜI 3: NEXT (v0.5.0 → v1.0.0 — Q1/2027)           │
       │   - EPIC-LIVE-01  : Phòng Học Trực Tuyến Live Video (Domain 07)│
       │   - EPIC-TEST-01  : Luyện Đề & Trắc Nghiệm Xúc Giác (Domain 08)│
       │   - EPIC-GAME-01  : Bảng Vàng Huy Hiệu & Streaks (Domain 09) │
       │   - EPIC-CHAT-01  : Hộp Thư Trao Đổi Với Giáo Viên (Domain 10) │
       │   - EPIC-PARENT-01: Parent Hub & Báo Cáo Tiến Độ (Domain 14)  │
       │   - v1.0.0: Supreme Commercial Release                       │
       └──────────────────────────────┴───────────────────────────────┘
```

---

## 🎯 Chi Tiết Từng Phiên Bản Phát Hành (Release Versions)

### 1. Phiên Bản Đã Phát Hành (Historical Releases)
- **`v0.1.0` (Sprint 1 — 22 SP)**: 
  - Màn hình Onboarding 3 Slides tương tác, giải thích giá trị Fun Learning, Discover & Live Coaches.
  - Cấu trúc AutoRoute 9.x và Onboarding Guard kiểm tra trạng thái khởi chạy lần đầu.
  - Thư viện UI Kit Tactile Claymorphism nền tảng (`ClayCard`, `ClayButton`, `StarCounterBadge`).
  - Ký duyệt phát hành: `docs/gates/sprint1-onboarding/release-tag.txt`.

- **`v0.2.0` (Sprint 2 — 5 SP)**:
  - Tối ưu hóa phễu tạo hồ sơ bé: Bộ chọn tuổi xoay đất sét **Age Wheel Spinner (6–12 tuổi)**.
  - Gợi ý biệt danh nhanh **Quick Nickname Chips 1-tap** và nút tung xúc xắc ngẫu nhiên.
  - Trọn bộ **12 Mascot 3D Con Giáp** cắt bỏ viền hộp, căn chỉnh xúc giác mượt mà 60 FPS.
  - Ký duyệt phát hành: `docs/gates/sprint2-profile-enhancement/release-tag.txt`.

- **`v0.3.0` (Sprint 3 — 13 SP)**:
  - Tái tạo 1:1 chuẩn xác 3 màn hình cốt lõi từ Dribbble benchmark (`33b01983f3e3be3821bcee2f1b2bdf94.webp`).
  - **Login Screen**: Đăng nhập thân thiện, nhớ mật khẩu, nút Indigo 3D.
  - **Student Home Dashboard**: Chào mừng Keil, tóm tắt tiến độ, khóa học đang học (*Amazing Animals*), thẻ tham gia Live Class cùng Coach Sarah.
  - **Today's Learning Goal**: Vòng tròn tiến độ 3D *"3 of 5 Tasks Completed"*, danh sách nhiệm vụ tương tác kèm Haptic squish.
  - Ký duyệt phát hành: `docs/gates/sprint3-core-screens/release-tag.txt`.

- **Hardening & Foundations (8 SP)**:
  - Thêm `RegisterScreen` hoàn chỉnh kèm kiểm soát độ mạnh mật khẩu và bảo mật COPPA.
  - Thêm `SplashScreen` đồng bộ Native Splash, App Icon và kiểm tra route động.
  - Refactor toàn diện: Triệt tiêu 100% magic numbers, 0 emojis trong code, 100% chuỗi tập trung trong `AppStrings`.
  - Ingest, bóc tách và phân loại **57 màn hình benchmark độ nét cao từ Dribbble qua 14 domains**.

---

### 2. Phiên Bản Hiện Tại (Current Horizon — v0.4.0)
- **Mục tiêu phiên bản**: Đưa học sinh từ Trang chủ bước vào hành trình học tập thực thụ bằng trung tâm khóa học đa môn và chi tiết bài giảng trực quan.
- **Tính năng trọng tâm**:
  1. `Courses Hub`: Thanh tìm kiếm bo tròn, chip lọc danh mục môn học (All, Science, Math, Language, Arts).
  2. `Filter Sheet`: Bottom sheet lọc đa tiêu chí (độ tuổi 6-8, 9-10, 11-12; cấp độ; thời lượng).
  3. `Course Detail`: Màn hình chi tiết khóa học, đánh giá sao, 3 tabs (Lessons, About, Reviews), danh sách bài học kèm thời lượng và nút lớn [Start Learning].
  4. `Continue Lesson Player`: Thẻ học tiếp bài đang dở với thanh tiến độ phân đoạn.

---

### 3. Phiên Bản Tương Lai (Next Horizon — v0.5.0 đến v1.0.0)
- **`v0.5.0` (Sprint 5)**: Live Interactive Video Classroom — Phòng học trực tuyến, video bài giảng, ô webcam giáo viên, hàng avatar học sinh, luồng chat/bình luận tương tác, giơ tay phát biểu.
- **`v0.6.0` (Sprint 6)**: Tests & Quizzes Hub — Trung tâm luyện đề trắc nghiệm, giao diện làm bài thi trắc nghiệm đất sét, chấm điểm tự động và vinh danh.
- **`v0.7.0` (Sprint 7)**: Gamification & Badges Showcase — Bộ sưu tập huy hiệu thành tích, ngọn lửa Streak chuỗi ngày học, đổi rương phần thưởng.
- **`v1.0.0` (Supreme Commercial Release)**: Báo cáo phân tích học tập hàng tháng cho phụ huynh (Parent Hub PIN-protected), tối ưu hóa App Store / Google Play sẵn sàng phân phối thương mại.
