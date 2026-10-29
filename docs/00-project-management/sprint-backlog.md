# Sprint Backlog — Kiddora Mobile App

* **Sprint Hiện Tại**: Sprint 5 (Tuần 7 & 8) — *Khởi Động & Lập Kế Hoạch Thực Thi (Phương Án A)*
* **Project Manager (PM)**: Sub-Agent Project Manager (PM) — *"The Clockwork Disciplinarian"*
* **Scrum Master (SM)**: Sub-Agent Scrum Master (SM) — *"The Servant Leader & Agile Coach"*
* **Sprint Goal**: *"Hiện thực hóa trọn gói 6 màn hình chuẩn 1:1 Design References Dribbble cho Phân hệ Khám phá Khóa học (Courses Hub, Search, Multi-criteria Filter) và Chi tiết Khóa học (Hero 3D, 3 Tabs, Giáo trình bài học), kết nối đồng bộ Mock Data Freezed và REST API FastAPI."*
* **Tổng Story Points cam kết**: **23 SP**
* **Trạng thái Sprint**: `PLANNING_AND_READY`

---

## 📊 Bảng Theo Dõi Kanban Thời Gian Thực (Sprint 5 — Phương Án A)

| Mã US | Hạng Mục / User Story | MoSCoW | SP | Gate Hiện Tại | Sub-Agent Phụ Trách | Trạng Thái |
| :---: | :--- | :---: | :---: | :---: | :---: | :---: |
| **US-15** | [KZN-01] Data Models Freezed `Course`, `Lesson`, `Subject` & Mock Seed Data | Must-have | 3 | Gate 0 Tech Lead | `tech-lead` / `backend-dev` | `[ ] READY` |
| **US-16** | Courses Hub & Grid View (`04_courses_01`, `04_courses_04`) + tách `HomeScreen` thành body switcher | Must-have | 5 | Gate 4A Flutter Dev | `flutter-core-dev` | `[ ] READY` |
| **US-15b** | [ADR-005] Spike kiến trúc song ngữ Việt–Anh (Tech Lead, timebox 1 ngày) — chặn mọi task UI | Must-have | TBD | Gate 0 Tech Lead | `tech-lead` | `[ ] READY` |
| **US-17** | Real-time Course Search Screen (`04_courses_02`) | Must-have | 3 | Gate 4A Flutter Dev | `flutter-core-dev` | `[ ] READY` |
| **US-18** | Multi-Criteria Filter Bottom Sheet (`04_courses_03`) | Must-have | 3 | Gate 4A Flutter Dev | `flutter-core-dev` | `[ ] READY` |
| **US-19** | Course Detail Screen & 3 Tabs Curriculum (`05_course_detail_01`, `05_course_detail_02`) | Must-have | 4 | Gate 4A Flutter Dev | `flutter-core-dev` | `[ ] READY` |
| **US-20** | FastAPI REST Endpoints cho Courses & Pytest Suite | Should-have | 3 | Gate 4B Backend Dev | `backend-dev` | `[ ] READY` |
| **US-21** | Ponytail Git Diff Review (Zero Bloat, 100% AppStrings/AppColors) | Must-have | 1 | Gate 5 Reviewer | `code-reviewer` | `[ ] READY` |
| **US-22** | QA Automated Test Suite & Visual QA Matrix 6 màn hình (0 Overflow 360×640) | Must-have | 1 | Gate 6 QA Verify | `qa-tester` | `[ ] READY` |

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
| **Tổng Cộng** | **Lũy kế giá trị đã bàn giao** | **89 SP** | **89 SP** | **100% On-Track** | **4 Releases + CR-013** |

---

## 🛡️ Nhật Ký Rủi Ro & Điểm Nghẽn (Risk & Blocker Log)

| Mã Rủi Ro | Ngày Ghi Nhận | Phân Loại | Mô Tả Điểm Nghẽn | Tác Động | Giải Pháp Tháo Gỡ | Sub-Agent | Trạng Thái |
| :---: | :---: | :---: | :--- | :---: | :--- | :---: | :---: |
| **RSK-006** | 2026-10-22 | Data/Mock | Mock data khóa học cần khớp với 14 domains Dribbble | Trung bình | Xây dựng domain entities chuẩn Freezed & mock repository (KZN-01) | `tech-lead` / `backend-dev` | 🟡 **IN_PROGRESS** |
| **RSK-007** | 2026-10-29 | Assets | Lệch style 3D Clay hoặc dính viền trắng khi tách nền PNG | Cao | Tách nền flood-fill + color unmixing RGBA 32-bit | `ui-ux-designer` | 🟢 **RESOLVED** |
| **RSK-008** | 2026-10-29 | UI-UX | RenderFlex overflow trong `ClayDialog` trên màn `360×640` | Nghiêm trọng | `ConstrainedBox(maxHeight)` + `SingleChildScrollView` | `qa-tester` / `dev` | 🟢 **RESOLVED** |
| **RSK-010** | 2026-10-29 | Doc-Sync | Trôi lệch tài liệu khi mở rộng `shared/ui_kit/` | Cao | Đồng bộ toàn diện `DESIGN.md`, PRD, WBS và chạy `graphify update .` | `ba` / `sm` | 🟢 **RESOLVED** |
