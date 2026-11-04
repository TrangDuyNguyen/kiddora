# Sprint Backlog — Kiddora Mobile App

* **Sprint Hiện Tại**: Sprint 6 (Tuần 9 & 10) — *Trình Phát Bài Học 5E & Hệ Thống Mini-Game Xúc Giác*
* **Project Manager (PM)**: Sub-Agent Project Manager (PM) — *"The Clockwork Disciplinarian"*
* **Scrum Master (SM)**: Sub-Agent Scrum Master (SM) — *"The Servant Leader & Agile Coach"*
* **Sprint Goal**: *"Hiện thực hóa Trình phát bài học chuẩn Sư phạm 5E (Engage - Explore - Explain - Elaborate - Evaluate) tương thích 3 màn hình benchmark Domain 06 (Continue Lesson, Progress Tracker, Celebration), tích hợp bộ 5 Widget Mini-Game Xúc Giác Đất Nặn Play-Doh (ClayDragDropSorter, ClayScaleBalancer, ClayBubblePopper, MagicStrokeTracer, ClayCardFlipper), kịch bản JSON DSL Freezed và API Đồng bộ tiến độ (FastAPI UserProgress)."*
* **Tổng Story Points cam kết**: **25 SP**
* **Trạng thái Sprint**: `RELEASED` (Hoàn thành 100% — Ký duyệt Gate 7 `v0.6.0-lesson-player`)

---

## 📊 Bảng Theo Dõi Kanban Thời Gian Thực (Sprint 6 — v0.6.0-lesson-player)

| Mã US | Hạng Mục / User Story | MoSCoW | SP | Gate Hiện Tại | Sub-Agent Phụ Trách | Trạng Thái |
| :---: | :--- | :---: | :---: | :---: | :---: | :---: |
| **US-23** | Data Models Freezed `LessonBlueprint`, `LessonStageConfig` & Parser | Must-have | 3 | Gate 0 / 4A | `tech-lead` / `flutter-core-dev` | 🟢 `[x] DONE` |
| **US-28** | Kịch Bản Bài Học Mẫu Chuẩn 5E & Seed Data Minh Họa (*Amazing Animals*, *Math Fun*) | Should-have | 2 | Gate 1 & 2 | `ui-ux-designer` / `ba` | 🟢 `[x] DONE` |
| **US-24** | Bộ Thư Viện 5 Widget Mini-Game Xúc Giác Đất Nặn (`shared/ui_kit/games/`) | Must-have | 5 | Gate 4A | `flutter-core-dev` | 🟢 `[x] DONE` |
| **US-25** | Trình Phát Bài Học 5E Engine & Bộ Điều Phối (`06_learning_01`) | Must-have | 5 | Gate 4A | `flutter-core-dev` | 🟢 `[x] DONE` |
| **US-26** | Màn Hình Tiến Độ & Ăn Mừng Hoàn Thành (`06_learning_02`, `06_learning_03`) | Must-have | 4 | Gate 4A | `flutter-core-dev` | 🟢 `[x] DONE` |
| **US-27** | FastAPI Backend Endpoints cho Blueprint & Đồng Bộ Tiến Độ | Should-have | 3 | Gate 4B | `backend-dev` | 🟢 `[x] DONE` |
| **US-29** | Ponytail Git Diff Review (Zero Bloat, Zero Hardcoded Values) | Must-have | 1 | Gate 5 | `code-reviewer` | 🟢 `[x] DONE` |
| **US-30** | QA Automated & Visual QA Test Matrix (0 Overflow, 60 FPS, COPPA) | Must-have | 2 | Gate 6 & 6.5 | `qa-tester` / `security-auditor` | 🟢 `[x] DONE` |

---

## 📈 Tốc Độ Thực Thi & Lịch Sử Sprints (Cumulative Velocity)

| Sprint / Hạng Mục | Phạm Vi / Tính Năng | SP Cam Kết | SP Hoàn Thành | Trạng Thái | Chữ Ký Gate 7 |
| :--- | :--- | :---: | :---: | :---: | :---: |
| **Sprint 1** | Interactive Onboarding & Kid Profile Identity | 22 SP | 22 SP | `RELEASED` | `v0.1.0-onboarding` |
| **Sprint 2** | Tactile Kid Profile Setup v2 Enhancement | 5 SP | 5 SP | `RELEASED` | `v0.2.0-profile-v2` |
| **Sprint 3** | 3 Core Screens (Login, Home, Today's Goal) | 13 SP | 13 SP | `RELEASED` | `v0.3.0-core-screens` |
| **Hardening** | Clean Code Ponytail, Register Screen, Splash & 57 Assets | 8 SP | 8 SP | `COMPLETED` | `main` |
| **Sprint 4** | Fullstack E2E Auth, Onboarding & User Sync (PostgreSQL + FastAPI) | 15 SP | 15 SP | `RELEASED` | `v0.4.0-auth-onboarding-e2e` |
| **UI Kit v2 (CR-013)** | Full Phase 1 + Phase 2 Tactile Clay Modal, Shared UI Kit & 7 3D Assets | 26 SP | 26 SP | `COMPLETED` | `CR-013` |
| **Sprint 5** | Courses Hub, Discovery & Curriculum Details (6 Màn Hình Benchmark) | 23 SP | 23 SP | `RELEASED` | `v0.5.0-courses-hub` |
| **Sprint 6** | Lesson Player 5E Engine, 5 Mini-Games & Progress Sync | 25 SP | 25 SP | `RELEASED` | `v0.6.0-lesson-player` |
| **Tổng Cộng Đã Bàn Giao** | **Lũy kế giá trị đã phát hành chính thức** | **137 SP** | **137 SP** | **100% On-Track** | **6 Releases + CR-013** |

---

## 🛡️ Nhật Ký Rủi Ro & Điểm Nghẽn (Risk & Blocker Log)

| Mã Rủi Ro | Ngày Ghi Nhận | Phân Loại | Mô Tả Điểm Nghẽn | Tác Động | Giải Pháp Tháo Gỡ | Sub-Agent | Trạng Thái |
| :---: | :---: | :---: | :--- | :---: | :--- | :---: | :---: |
| **RSK-006** | 2026-10-22 | Data/Mock | Mock data khóa học cần khớp với 14 domains Dribbble | Trung bình | Xây dựng domain entities chuẩn Freezed & mock repository (KZN-01) | `tech-lead` / `backend-dev` | 🟢 **RESOLVED** |
| **RSK-007** | 2026-10-29 | Assets | Lệch style 3D Clay hoặc dính viền trắng khi tách nền PNG | Cao | Tách nền flood-fill + color unmixing RGBA 32-bit | `ui-ux-designer` | 🟢 **RESOLVED** |
| **RSK-008** | 2026-10-29 | UI-UX | RenderFlex overflow trong `ClayDialog` trên màn `360×640` | Nghiêm trọng | `ConstrainedBox(maxHeight)` + `SingleChildScrollView` | `qa-tester` / `dev` | 🟢 **RESOLVED** |
| **RSK-010** | 2026-10-29 | Doc-Sync | Trôi lệch tài liệu khi mở rộng `shared/ui_kit/` | Cao | Đồng bộ toàn diện `DESIGN.md`, PRD, WBS và chạy `graphify update .` | `ba` / `sm` | 🟢 **RESOLVED** |
| **RSK-011** | 2026-11-03 | Performance | Độ trễ Spring Simulation & Haptic trong Mini-Game trên thiết bị yếu | Cao | Sử dụng `RepaintBoundary` cho từng vật phẩm kéo thả, tối ưu CustomPainter | `tech-lead` / `flutter-core-dev` | 🟡 **MONITORING** |
| **RSK-012** | 2026-11-03 | Schema | Trôi lệch schema JSON DSL kịch bản bài học giữa FE và BE | Trung bình | Dùng chung JSON Schema chuẩn hóa, kiểm định chặt chẽ bằng Unit Tests | `tech-lead` / `backend-dev` | 🟡 **MONITORING** |
