# Ma Trận Phân Nhiệm Các Bên Liên Quan (RACI Matrix) — Kiddora

Tài liệu này chuẩn hóa vai trò và quyền hạn của **9 Sub-Agents Chuyên Trách** trong quy trình quản trị và phát triển ứng dụng di động Kiddora theo nguyên tắc kiểm soát chéo (**Four-Eyes Principle**).

---

## 1. Danh Sách 9 Sub-Agents Chuyên Trách

1. **Sub-Agent Product Owner (PO)** (`product-owner`): Định hướng chiến lược, quản trị Lộ trình 3 Chân trời, phân loại MoSCoW, phê duyệt PRD Gate 1 và ký duyệt phát hành Gate 7.
2. **Sub-Agent Tech Lead (Architect)** (`tech-lead`): Nghiên cứu kỹ thuật, thực hiện Spikes, ban hành Quyết định Kiến trúc (ADR Gate 0), kiểm soát SLA hiệu năng.
3. **Sub-Agent Project Manager (PM)** (`project-manager`): Lập kế hoạch Sprint, phân rã WBS theo 6 Cổng, ước lượng Fibonacci Story Points, quản trị rủi ro và điều phối thực thi.
4. **Sub-Agent Business Analyst (BA)** (`business-analyst`): Thu thập yêu cầu, soạn thảo PRD, viết kịch bản BDD User Stories (Given-When-Then), cập nhật Từ điển Dữ liệu.
5. **Sub-Agent UI/UX Designer (Design)** (`ui-ux-designer`): Thiết kế Layout Spec lưới 4pt, 5 trạng thái màn hình, chuẩn hóa tokens Tactile Claymorphism và giao diện Google Stitch.
6. **Sub-Agent QA Tester & Visual QA (QA)** (`qa-tester` & `visual-qa`): Lập Master Test Plan, kịch bản BDD `.feature`, kiểm thử tự động, kiểm chuẩn 60 FPS và kiểm tra thị giác chống RenderFlex overflow.
7. **Sub-Agent Dev FE (Developer)** (`flutter-expert` & `flutter-core-dev`): Xây dựng mã nguồn Feature-First Clean Architecture, Riverpod Notifier, AutoRoute, tuân thủ kỷ luật Ponytail.
8. **Sub-Agent Code Reviewer (Reviewer)** (`code-reviewer` & `ponytail-review`): Rà soát git diff tại Gate 5, loại bỏ over-engineering, dead code, và cấp chứng chỉ `Lean already. Ship.`.
9. **Sub-Agent Security Auditor (Security)** (`security-auditor` & `security-audit`): Kiểm toán an toàn trẻ em (COPPA), bảo mật cổng phụ huynh, phát hiện rò rỉ secret và rà soát biên tin cậy tại Gate 6.5.

---

## 2. Ma Trận RACI (Responsible, Accountable, Consulted, Informed)

| Hạng Mục Trách Nhiệm | PO | Tech Lead | PM | BA | Design | Dev FE | Reviewer | QA | Security |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **Tầm nhìn & Lộ trình 3 Chân trời** | **A** | C | C | R | I | I | I | I | I |
| **Quản lý Epics & Phân loại MoSCoW** | **A** | C | C | R | I | I | I | I | I |
| **Nghiên cứu Spike & Ban hành ADR Gate 0** | I | **A / R** | I | C | C | C | I | I | C |
| **Soạn thảo PRD & BDD Scenarios Gate 1** | C | C | I | **A / R** | C | C | I | C | C |
| **Ký duyệt PRD & Khả thi Kỹ thuật Gate 1** | **A** | **A** | I | R | I | I | I | I | I |
| **Lập Kế hoạch Sprint & Phân rã WBS** | C | C | **A / R** | C | C | C | C | C | C |
| **Thiết kế UI Layout Spec 5 States Gate 2** | C | C | I | C | **A / R** | C | I | C | I |
| **Thiết kế Test Plan & Kịch bản BDD Gate 3**| I | I | I | C | C | I | I | **A / R**| I |
| **Triển khai Mã nguồn Flutter Gate 4** | I | C | I | I | C | **A / R** | C | I | I |
| **Rà soát Ponytail Diff Gate 5** | I | C | I | I | I | C | **A / R** | I | I |
| **Kiểm thử Tự động & Visual QA Gate 6** | I | I | I | I | I | C | I | **A / R**| I |
| **Kiểm toán An toàn COPPA Gate 6.5** | I | C | I | I | I | C | I | I | **A / R** |
| **Ký duyệt Phát hành Tổng thể Gate 7** | **A** | **A** | R | I | I | I | I | C | C |

*Quy ước*:
- **R (Responsible)**: Sub-Agent trực tiếp thực hiện công việc.
- **A (Accountable)**: Sub-Agent chịu trách nhiệm tối cao và có quyền ký duyệt duy nhất.
- **C (Consulted)**: Sub-Agent được tham vấn chuyên môn 2 chiều.
- **I (Informed)**: Sub-Agent được nhận thông tin thông báo 1 chiều.

---

## 3. Nguyên Tắc Bất Khả Xâm Phạm (Four-Eyes Principle)
- Tuyệt đối không một Sub-Agent nào được tự phê duyệt sản phẩm của chính mình.
- Bất kỳ tính năng nào trước khi merge vào nhánh `main` đều phải có đủ chữ ký của các Cổng Chất Lượng liên quan.
