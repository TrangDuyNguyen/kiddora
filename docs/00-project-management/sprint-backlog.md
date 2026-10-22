# Sprint Backlog — Kiddora Mobile App

* **Sprint Hiện Tại**: Sprint 4 (Tuần 5 & 6) — *Chuẩn bị kích hoạt*
* **Scrum Master / PM**: Sub-Agent Project Manager (PM) — *"The Clockwork Disciplinarian"*
* **Sprint Goal**: *"Hiện thực hóa luồng Khám phá Khóa học (Domain 04) và Chi tiết Bài giảng (Domain 05) theo chuẩn Dribbble: Tìm kiếm, bộ lọc chip đất sét đa tiêu chí, lưới khóa học 3D xúc giác và danh sách bài học tương tác."*
* **Tổng Story Points cam kết**: **13 SP**
* **Trạng thái Sprint**: `PLANNING`

---

## 📊 Bảng Theo Dõi Kanban Thời Gian Thực (Sprint 4)

| Mã US | Hạng Mục / User Story | MoSCoW | SP | Gate Hiện Tại | Sub-Agent Phụ Trách | Trạng Thái |
| :---: | :--- | :---: | :---: | :---: | :---: | :---: |
| **US-08** | Spike Kiến trúc Dữ liệu Khóa học & ADR | Must-have | 1 | Gate 0 Tech Spike | `tech-lead` | `[ ] TODO` |
| **US-09** | PRD & BDD Given-When-Then cho Khám phá & Lọc | Must-have | 2 | Gate 1 PRD | `ba` / `po` | `[ ] TODO` |
| **US-10** | UI Layout Spec & 5 Trạng Thái Màn hình Khóa Học | Must-have | 2 | Gate 2 Design | `ui-ux-designer` | `[ ] TODO` |
| **US-11** | Master Test Plan & Traceability Matrix | Must-have | 2 | Gate 3 QA | `qa-tester` | `[ ] TODO` |
| **US-12** | Màn hình Courses Hub & Bộ Lọc Đa Tiêu Chí | Must-have | 3 | Gate 4 Dev | `dev` | `[ ] TODO` |
| **US-13** | Màn hình Chi Tiết Khóa Học (Course Detail & Lessons) | Must-have | 3 | Gate 4 Dev | `dev` | `[ ] TODO` |

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
