# Sprint Backlog — Kiddora Mobile App

* **Sprint Hiện Tại**: Sprint 4 (Tuần 5 & 6) — *Đang Thực Thi*
* **Project Manager (PM)**: Sub-Agent Project Manager (PM) — *"The Clockwork Disciplinarian"*
* **Scrum Master (SM)**: Sub-Agent Scrum Master (SM) — *"The Servant Leader & Agile Coach"*
* **Sprint Goal**: *"Hiện thực hóa trọn gói luồng Fullstack End-to-End: Đăng ký, Đăng nhập, Onboarding và Hồ sơ bé, đồng bộ REST API FastAPI với PostgreSQL Database (Alembic Migration), hỗ trợ chế độ Khách (Guest) và chuyển đổi tài khoản."*
* **Tổng Story Points cam kết**: **15 SP**
* **Trạng thái Sprint**: `IN_PROGRESS`

---

## 📊 Bảng Theo Dõi Kanban Thời Gian Thực (Sprint 4)

| Mã US | Hạng Mục / User Story | MoSCoW | SP | Gate Hiện Tại | Sub-Agent Phụ Trách | Trạng Thái |
| :---: | :--- | :---: | :---: | :---: | :---: | :---: |
| **US-08** | Khởi tạo Alembic, Migration 0001 & Seed Data PostgreSQL | Must-have | 2 | Gate 0 Tech Lead | `tech-lead` / `backend-dev` | `[x] DONE` |
| **US-09** | FastAPI REST Endpoints (`/register`, `/login`, `/me`, `/kid-profile`) & Pytest | Must-have | 3 | Gate 4B Backend Dev | `backend-dev` | `[x] DONE` |
| **US-10** | Cập nhật Doc PRD, BDD Gherkin & Data Dictionary Zero-Drift | Must-have | 2 | Gate 1 PRD | `ba` / `po` | `[x] DONE` |
| **US-11** | Cài đặt Dio, SecureStorage, ApiClient & TokenStorage trên Flutter | Must-have | 2 | Gate 4A Flutter Dev | `flutter-expert` | `[x] DONE` |
| **US-12** | Tích hợp E2E: Kết nối Register, Login, KidProfileSetup & Guest Banner | Must-have | 3 | Gate 4A Flutter Dev | `flutter-expert` | `[x] DONE` |
| **US-13** | Code Review (Ponytail: rà soát diff, zero bloat, SLA verification) | Must-have | 1 | Gate 5 Reviewer | `code-reviewer` | `[x] DONE` |
| **US-14** | QA Test Suite E2E (API test thực tế + Widget test Flutter + 0 Overflow) | Must-have | 2 | Gate 6 QA Verify | `qa-tester` | `[x] DONE` |


---

## 📈 Tốc Độ Thực Thi & Lịch Sử Sprints (Cumulative Velocity)

| Sprint / Hạng Mục | Phạm Vi / Tính Năng | SP Cam Kết | SP Hoàn Thành | Trạng Thái | Chữ Ký Gate 7 |
| :--- | :--- | :---: | :---: | :---: | :---: |
| **Sprint 1** | Interactive Onboarding & Kid Profile Identity | 22 SP | 22 SP | `RELEASED` | `v0.1.0-onboarding` |
| **Sprint 2** | Tactile Kid Profile Setup v2 Enhancement | 5 SP | 5 SP | `RELEASED` | `v0.2.0-profile-v2` |
| **Sprint 3** | 3 Core Screens (Login, Home, Today's Goal) | 13 SP | 13 SP | `RELEASED` | `v0.3.0-core-screens` |
| **Hardening** | Clean Code Ponytail, Register Screen, Splash & 57 Assets | 8 SP | 8 SP | `COMPLETED` | `main` |
| **Tổng Cộng** | **Lũy kế giá trị đã bàn giao** | **48 SP** | **48 SP** | **100% On-Track** | **3 Releases** |

---

## 🛡️ Nhật Ký Rủi Ro & Điểm Nghẽn (Risk & Blocker Log)

| Mã Rủi Ro | Ngày Ghi Nhận | Phân Loại | Mô Tả Điểm Nghẽn | Tác Động | Giải Pháp Tháo Gỡ | Sub-Agent | Trạng Thái |
| :---: | :---: | :---: | :--- | :---: | :--- | :---: | :---: |
| **RSK-003** | 2026-10-22 | UI-UX | Cuộn ListWheelScrollView có thể xung đột với SingleChildScrollView | Trung bình | Dùng fixedExtentScrollController với ClampingScrollPhysics | `tech-lead` | **RESOLVED** (ADR-004) |
| **RSK-004** | 2026-10-22 | Audio | Phát audio mascot liên tục khi click gây lag main thread | Cao | Debounce 300ms và tái sử dụng Audio/Haptic engine nhẹ | `tech-lead` | **RESOLVED** (ADR-004) |
| **RSK-005** | 2026-10-22 | Assets | 57 Màn hình Dribbble chất lượng cao có thể làm phình to APK nếu nhúng nhầm | Cao | Giữ trong `assets/design_references` không đưa vào `pubspec.yaml` runtime | `tech-lead` / `pm` | **RESOLVED** |
