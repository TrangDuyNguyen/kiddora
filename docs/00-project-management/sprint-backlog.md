# Sprint 1 Backlog — Kiddora Mobile App

* **Sprint**: Sprint 1 (Tuần 1 & 2)
* **Scrum Master / PM**: Sub-Agent Project Manager (PM) — *"The Clockwork Disciplinarian"*
* **Sprint Goal**: *"Thiết lập Bộ khung Kiến trúc Feature-First Clean Architecture, hoàn thiện Động cơ Thiết kế Tactile Claymorphism 3D và bàn giao luồng Nhập môn (3-Step Onboarding & Kid Profile Identity) đạt 60 FPS chuẩn thiết kế kiddora_full_shot.png."*
* **Tổng Story Points cam kết**: **28 SP**
* **Trạng thái Sprint**: `ACTIVE`

---

## 📊 Bảng Theo Dõi Kanban Thời Gian Thực

| Mã US | Hạng Mục / User Story | MoSCoW | SP | Gate Hiện Tại | Sub-Agent Phụ Trách | Trạng Thái |
| :---: | :--- | :---: | :---: | :---: | :---: | :---: |
| **US-01** | Core Routing & Riverpod State Engine | Must-have | 3 | Gate 0 / 4 | `tech-lead` / `dev` | `[/] IN PROGRESS` |
| **US-02** | Tactile Clay UI Kit Foundation & 7 UI States | Must-have | 5 | Gate 2 / 4 | `design` / `dev` | `[/] IN PROGRESS` |
| **US-03** | Interactive 3-Step Onboarding (kiddora_full_shot) | Must-have | 5 | Gate 1 $\rightarrow$ 2 | `ba` $\rightarrow$ `design` | `[?] IN REVIEW` |
| **US-04** | Kid Profile Setup (Age 7-10 & Clay Avatar Picker) | Must-have | 5 | Gate 1 $\rightarrow$ 2 | `ba` $\rightarrow$ `design` | `[?] IN REVIEW` |
| **US-05** | Local Identity Hydration (SharedPreferences) | Should-have | 3 | Gate 3 / 4 | `qa` / `dev` | `[ ] TODO` |
| **US-06** | Tactile Haptic Squish & Audio Click Engine | Should-have | 3 | Gate 4 | `dev` | `[ ] TODO` |
| **US-07** | Floating Clay Confetti Micro-Animations | Could-have | 4 | Gate 4 | `dev` | `[ ] TODO` |

---

## 📈 Tốc Độ Thực Thi & Phân Bổ Năng Lực (Velocity & Capacity)

- **Must-have**: $18\text{ SP}$ ($64\%$) — Chốt chặn sống còn của MVP.
- **Should-have**: $6\text{ SP}$ ($21\%$) — Tăng cường trải nghiệm xúc giác & lưu trữ.
- **Could-have**: $4\text{ SP}$ ($14\%$) — Hiệu ứng vi chuyển động phụ trợ.
- **Tổng cộng**: $28\text{ SP}$ (Nằm trong trần kiểm soát $\le 30\text{ SP}$/Sprint).

---

## 🛡️ Nhật Ký Rủi Ro & Điểm Nghẽn (Risk & Blocker Log)

| Mã Rủi Ro | Ngày Ghi Nhận | Phân Loại | Mô Tả Điểm Nghẽn | Tác Động | Giải Pháp Tháo Gỡ | Sub-Agent | Trạng Thái |
| :---: | :---: | :---: | :--- | :---: | :--- | :---: | :---: |
| **RSK-001** | 2026-10-19 | UI-Asset | Asset ảnh 3D dung lượng lớn gây giật khung hình khi swipe | Cao | Precache toàn bộ 3 ảnh slide trước khi mount PageView; nén WebP | `tech-lead` | **RESOLVED** (ADR-003) |
| **RSK-002** | 2026-10-19 | Routing | Xung đột route khi kiểm tra trạng thái first-launch | Trung bình | Đọc SharedPreferences đồng bộ trong main() trước khi gắn router | `dev` | **IN PROGRESS** |
