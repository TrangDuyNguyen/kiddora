# Kho Tài Liệu Quản Trị Sản Phẩm & Nghiệp Vụ — Kiddora

Kho tài liệu này lưu trữ toàn bộ Lộ trình sản phẩm (Product Roadmap), Danh mục Epics MoSCoW, Kế hoạch Sprint & Ma trận WBS 8 Cổng, Đặc tả nghiệp vụ (PRD/BDD), Từ điển dữ liệu, Thiết kế UI/UX Specs và Quy chuẩn vận hành của dự án di động **Kiddora** (Kids Learning & Live Classes Mobile App), tuân theo mô hình **Agile Docs-as-Code** và hệ thống **9 Sub-Agents Độc Lập** vận hành qua **8 Cổng Chất Lượng (Quality Gates 0–7)**.

---

## 📌 Cấu Trúc Thư Mục Quản Trị Chuẩn Hóa

```
docs/
├── 00-roadmap/              # [SUB-AGENT PO] Lộ trình 3 Chân trời (Now-Next-Later) & Danh mục 14 Epics MoSCoW
├── 00-project-management/   # [SUB-AGENT PM] Kế hoạch Sprint Backlog, Ma trận WBS 8 Cổng, Risk & Blocker Log
├── 01-overview/             # Tầm nhìn sản phẩm, Ma trận RACI Đa Sub-Agent, Quy trình 8-Gate Lifecycle SOP
├── 02-business-rules/       # Quy chuẩn sư phạm lứa tuổi 6-12, Chính sách COPPA bảo vệ dữ liệu trẻ em
├── 03-prd-features/         # [DOC TÍNH NĂNG] PRD, User Stories BDD và UI/UX Screen Specs theo từng Feature
│   ├── 01-onboarding-brand-intro/
│   ├── 02-kid-profile-mascot-identity/
│   ├── 03-auth-welcome-back-login/
│   ├── 04-student-home-dashboard/
│   ├── 05-today-learning-goals-progress/
│   ├── 06-courses-discovery-and-hub/
│   └── 07-course-detail-and-curriculum/
├── 04-specifications/       # Quyết định kiến trúc (ADR), Từ điển dữ liệu (Data Dictionary), Tích hợp hệ thống
├── 05-change-management/    # Sổ theo dõi yêu cầu thay đổi (Change Request Log) & Release Notes chi tiết
├── gates/                   # Hồ sơ nghiệm thu các cổng chất lượng theo từng Sprint (Gates 0-7)
└── templates/               # Mẫu chuẩn: Epic, Roadmap Item, Sprint, WBS Task, PRD, User Story, Release
```

---

## 🔗 Liên Kết Truy Vết (Traceability & Four-Eyes Governance)

Mọi tính năng trong Kiddora đều được liên kết chặt chẽ qua **8 Cổng Chất Lượng**:
- **Gate 0 (Kiến trúc & Tech Spikes)**: `docs/04-specifications/adr/` do **Tech Lead** nghiên cứu và ban hành ADR.
- **Gate 1 (Chiến lược & PRD/BDD)**: `docs/00-roadmap/` do **PO** phê duyệt; `docs/03-prd-features/` do **BA** soạn thảo, **PO & Tech Lead** đồng ký duyệt.
- **Gate 2 (Thiết kế UI/UX Specs)**: `docs/03-prd-features/*/ui-ux-screen-specs.md` do **UI/UX Designer** dựng chuẩn Tactile Claymorphism × 5 UI States lưới 4pt.
- **Gate 3 (Kiểm thử & Test Plan)**: `docs/03-prd-features/*/gate-3-test.md` do **QA Tester** thiết kế Test Plan và BDD Gherkin `.feature`.
- **Gate 4 (Mã nguồn Clean Architecture)**: `lib/features/` do **Dev FE** triển khai Feature-First Clean Code, Riverpod Notifier, AutoRoute.
- **Gate 5 (Rà soát Ponytail & Docs Sync)**: Do **Reviewer** quét git diff code và đối soát tài liệu, loại bỏ 100% bloat & over-engineering.
- **Gate 6 (Nghiệm thu Thực chất)**: Do **QA Tester** chạy automated test suite 100% pass, 60 FPS, 0 memory leak, 0 RenderFlex overflow.
- **Gate 6.5 (Bảo mật Trẻ em COPPA)**: Do **Security Auditor** kiểm toán không thu thập PII và kiểm tra Parental Gate math riddle.
- **Gate 7 (Phát hành)**: Do **Hội đồng PO, PM, Tech Lead & Security Auditor** ký duyệt và gắn tag phát hành.

---

## ✍️ Quy Định Vận Hành Cốt Lõi (Zero Doc-Code Drift)

1. **Code đổi là Doc phải đổi (Backward Sync)**: Mọi thay đổi về tính năng, scope, data model BẮT BUỘC phải được cập nhật vào `docs/` ngay trong cùng commit.
2. **Minh bạch nhãn trạng thái (Feature State Badges)**: Phải gắn nhãn rõ ràng: `🟡 [Phase 1: Mock/In-Memory UI]`, `🔵 [Client-Only]`, hoặc `🟢 [Full-Stack E2E]`. Tuyệt đối cấm báo cáo "DONE" ảo.
3. **Nguyên tắc Four-Eyes**: Không Sub-Agent nào được tự duyệt sản phẩm của chính mình.
4. **Git-Centric Markdown**: Toàn bộ tài liệu được quản lý trực tiếp trong Git, làm cơ sở dữ liệu duy nhất cho mọi báo cáo dự án.
