# Sprint 2 Backlog — Kiddora Mobile App

* **Sprint**: Sprint 2 (Tuần 3 & 4)
* **Scrum Master / PM**: Sub-Agent Project Manager (PM) — *"The Clockwork Disciplinarian"*
* **Sprint Goal**: *"Nâng cấp toàn diện màn hình Thiết lập Hồ sơ Bé (US-04-v2): Tích hợp Tactile Clay Wheel Age Spinner dải tuổi 6–12, Quick Nickname Chips 1-tap, loại bỏ viền vuông bệ mascot, bổ sung phản hồi xúc giác Haptic và bảo đảm 60 FPS mượt mà."*
* **Tổng Story Points cam kết**: **5 SP**
* **Trạng thái Sprint**: `COMPLETED` (RELEASED)

---

## 📊 Bảng Theo Dõi Kanban Thời Gian Thực

| Mã US | Hạng Mục / User Story | MoSCoW | SP | Gate Hiện Tại | Sub-Agent Phụ Trách | Trạng Thái |
| :---: | :--- | :---: | :---: | :---: | :---: | :---: |
| **US-04.1** | Quick Nickname Chips (Gợi ý biệt danh 1-tap & Dice Random) | Must-have | 1 | Gate 7 Release | `ba` $\rightarrow$ `dev` | `[x] DONE` |
| **US-04.2** | Tactile Clay Age Wheel Spinner (Dải tuổi 6–12 & Curriculum Hint) | Must-have | 2 | Gate 7 Release | `tech-lead` $\rightarrow$ `dev` | `[x] DONE` |
| **US-04.3** | Tactile 3D Mascot Pedestal v2 (Trọn bộ 12 Con Giáp & Seamless Cutouts) | Must-have | 2 | Gate 7 Release | `design` $\rightarrow$ `dev` | `[x] DONE` |

---

## 📈 Tốc Độ Thực Thi & Phân Bổ Năng Lực (Velocity & Capacity)

- **Must-have**: $5\text{ SP}$ ($100\%$) — Tối ưu hóa hoàn toàn phễu Onboarding.
- **Tổng cộng**: $5\text{ SP}$ hoàn thành, $0$ backlog tồn đọng.
- **Nghiệm thu**: Gate 6 (QA 21/21 Pass) & Gate 6.5 (Security Pass) $\rightarrow$ Gate 7 Release Approved.

---

## 🛡️ Nhật Ký Rủi Ro & Điểm Nghẽn (Risk & Blocker Log)

| Mã Rủi Ro | Ngày Ghi Nhận | Phân Loại | Mô Tả Điểm Nghẽn | Tác Động | Giải Pháp Tháo Gỡ | Sub-Agent | Trạng Thái |
| :---: | :---: | :---: | :--- | :---: | :--- | :---: | :---: |
| **RSK-003** | 2026-10-22 | UI-UX | Cuộn ListWheelScrollView có thể xung đột cuộn với SingleChildScrollView bên ngoài | Trung bình | Khóa physics hoặc dùng fixedExtentScrollController với ClampingScrollPhysics | `tech-lead` | **RESOLVED** (ADR-004) |
| **RSK-004** | 2026-10-22 | Audio | Phát audio mascot liên tục khi spam click gây treo main thread hoặc memory leak | Cao | Giới hạn debounce $300\text{ms}$ và tái sử dụng Audio/Haptic engine nhẹ | `tech-lead` | **RESOLVED** (ADR-004) |
