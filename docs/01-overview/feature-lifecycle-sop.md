# Quy Trình Phát Triển Tính Năng Toàn Diện (8-Gate Feature Lifecycle SOP) — Kiddora

Tài liệu này chuẩn hóa **Quy trình Phát triển Tính năng Khép kín (End-to-End Feature Delivery SOP)** từ lúc khởi tạo ý tưởng đến khi phát hành ra thị trường, vận hành bởi **11 Sub-Agents Chuyên Trách** theo nguyên tắc kiểm soát chéo (**Four-Eyes Principle**).

---

## 🧭 Sơ Đồ Điều Phối 8 Cổng Chất Lượng (Full-Stack 11 Sub-Agents)

```mermaid
flowchart TD
    Strategy([👑 Sub-Agent PO: Định Hướng Epic & MoSCoW]) --> Gate0
    
    subgraph Gate0: Kiến Trúc & Hạ Tầng [CỔNG 0: Tech Lead & DevOps Infra]
        Gate0[Khảo sát kỹ thuật & Spikes - Tech Lead]
        ADR[Ban hành Quyết định Kiến trúc ADR]
        InfraSpike[Thiết lập Hạ tầng & Container - DevOps Infra]
        Gate0 --> ADR
        Gate0 --> InfraSpike
    end
    
    ADR --> Gate1
    
    subgraph Gate1: Yêu Cầu Nghiệp Vụ [CỔNG 1: Sub-Agent BA - docs/03-prd-features/]
        Gate1[BA lập PRD & BDD Given-When-Then]
        DataDict[Cập nhật Từ điển Dữ liệu]
        Gate1 --> DataDict
    end
    
    DataDict -->|Four-Eyes: PO & Tech Lead Phê Duyệt| PM_Plan
    
    subgraph Lập Kế Hoạch Sprint & WBS [ĐIỀU PHỐI: Sub-Agent PM - docs/00-project-management/]
        PM_Plan[PM mở Sprint & Lập Ma Trận WBS 6 Cổng]
        Points[Ước lượng Fibonacci Story Points 1, 2, 3, 5, 8]
        PM_Plan --> Points
    end
    
    Points --> Gate2 & Gate3
    
    subgraph Gate2 & 3: Thiết Kế UI/UX & Kế Hoạch Test [SONG HÀNH TRƯỚC KHI CODE]
        Gate2[UI/UX Designer: 5 UI States & 4pt Grid]
        Gate3[QA Tester: Master Test Plan & Kịch bản .feature]
    end
    
    Gate2 & Gate3 --> Gate4_Hub
    
    subgraph Gate4: Triển Khai Mã Nguồn Song Hành [CỔNG 4: FE & BE DUAL-TRACK]
        Gate4_Hub[Kích hoạt song song]
        Gate4A[Gate 4A: Dev FE - Flutter Clean Ponytail UI]
        Gate4B[Gate 4B: Dev BE - FastAPI Feature-First & DB]
        Gate4_Hub --> Gate4A
        Gate4_Hub --> Gate4B
        Gate4A --> FE_Tests[Unit & Widget Tests]
        Gate4B --> BE_Tests[Pytest Async API Tests]
    end
    
    FE_Tests & BE_Tests -->|0 errors & 0 warnings| Gate5
    
    subgraph Gate5: Rà Soát Tinh Gọn [CỔNG 5: Sub-Agent Code Reviewer]
        Gate5[Quét Git Diff FE & BE, Triệt tiêu Over-engineering]
        Signoff5[Cấp chứng chỉ: Lean already. Ship.]
        Gate5 --> Signoff5
    end
    
    Signoff5 --> Gate6 & Gate6_5
    
    subgraph Gate6 & 6.5: Nghiệm Thu Thực Chất & An Ninh [ĐỘC LẬP CHẶN CỔNG]
        Gate6[QA Tester & Visual QA: 100% Pass, 60 FPS, API Contract Match]
        Gate6_5[Security Auditor: Kiểm toán COPPA, Container & Secret Audit]
    end
    
    Gate6 & Gate6_5 --> Gate7
    
    subgraph Gate7: Ký Duyệt Phát Hành [CỔNG 7: Hội Đồng Ký Duyệt & DevOps]
        DeployCheck[DevOps Infra: Container Health & VPS Readiness]
        ReleaseCouncil[PO, PM, Tech Lead Ký Duyệt Release Tag]
        Gate7 --> DeployCheck --> ReleaseCouncil
    end
```

---

## 📋 Chi Tiết Trách Nhiệm Từng Cổng Chất Lượng

### Cổng 0: Nghiên Cứu Kỹ Thuật & Quyết Định Kiến Trúc (Gate 0 — Tech Lead & DevOps Infra)
- **Đầu ra**: Tài liệu `docs/04-specifications/adr/adr-*.md`, file `docker-compose.yml`, biến môi trường `.env.example`.
- **Trách nhiệm**: Đánh giá tính khả thi, phân tích rủi ro bộ nhớ, kiểm soát Cold Start $\le 1.8\text{s}$, chuẩn bị cụm container (FastAPI, DB, Redis, MinIO, LiveKit).

### Cổng 1: Đặc Tả Nghiệp Vụ & BDD Scenarios (Gate 1 — BA & PO)
- **Đầu ra**: Thư mục tính năng `docs/03-prd-features/<feature-name>/prd-*.md` và `user-stories.md`.
- **Trách nhiệm**: BA viết tiêu chuẩn nghiệm thu dạng Given-When-Then chi tiết, PO và Tech Lead đồng ký duyệt Feasibility trước khi code.

### Cổng 2: Thiết Kế Giao Diện Tactile Claymorphism (Gate 2 — UI/UX Designer)
- **Đầu ra**: `docs/03-prd-features/<feature-name>/ui-ux-screen-specs.md`.
- **Trách nhiệm**: Bố cục lưới 4pt, 5 trạng thái màn hình (`default`, `hover`, `active/pressed`, `disabled`, `error`), tương thích chuẩn WCAG 2.2 AA.

### Cổng 3: Thiết Kế Kế Hoạch Kiểm Thử Sớm (Gate 3 — QA Tester)
- **Đầu ra**: `docs/03-prd-features/<feature-name>/gate-3-test.md` và file kịch bản `.feature`.
- **Trách nhiệm**: Bao phủ 100% kịch bản kiểm thử Happy Path và Edge Cases (mất mạng, xoay màn hình, nhập sai, lỗi API 401/404/500).

### Cổng 4: Triển Khai Mã Nguồn Song Hành (Gate 4A Dev FE & Gate 4B Dev BE)
- **Cổng 4A (Dev FE — Flutter)**:
  - Mã nguồn trong `lib/features/<feature-name>/` và `test/`.
  - Feature-First Clean Architecture, Riverpod Notifier, AutoRoute. 100% `AppValues`, không emojis trong code, 100% `AppStrings`.
- **Cổng 4B (Dev BE — FastAPI & Database)**:
  - Mã nguồn trong `backend/app/modules/<feature-name>/` và `backend/tests/`.
  - Feature-First Modular Monolith, SQLAlchemy 2.0 Async, Pydantic DTOs, Alembic migrations, Redis caching, Celery background worker, Pytest.

### Cổng 5: Rà Soát Tinh Gọn Ponytail (Gate 5 — Code Reviewer)
- **Đầu ra**: Biên bản rà soát `gate-5-ponytail-review.md`.
- **Trách nhiệm**: Săn tìm và triệt tiêu code thừa, YAGNI, over-engineering trên toàn bộ git diff cả Flutter lẫn Python Backend.

### Cổng 6: Nghiệm Thu Tự Động & Visual QA (Gate 6 — QA Tester & Visual QA)
- **Đầu ra**: Biên bản `gate-6-qa-signoff.md`.
- **Trách nhiệm**: 
  - Chạy `flutter test` đạt $100\%$ pass, kiểm tra tốc độ $60\text{ FPS}$, không RenderFlex overflow khi text scale 1.5x.
  - Chạy `pytest` đạt $100\%$ pass, xác thực tính toàn vẹn hợp đồng API (API Contract Verification).

### Cổng 6.5: Kiểm Toán An Toàn Trẻ Em & Bảo Mật Hạ Tầng (Gate 6.5 — Security Auditor)
- **Đầu ra**: Biên bản `gate-6.5-security-signoff.md`.
- **Trách nhiệm**: Kiểm toán COPPA không lộ PII, cơ chế khóa phụ huynh Parental Gate, rà soát lỗ hổng container Docker, kiểm tra không rò rỉ secret key/JWT secret.

### Cổng 7: Ký Duyệt Phát Hành Tối Cao (Gate 7 — Hội Đồng Phát Hành & DevOps)
- **Đầu ra**: File `release-v*.md`, Git tag chính thức, chứng chỉ sẵn sàng hạ tầng VPS từ `devops-infra`.
- **Trách nhiệm**: Hội đồng PO, PM, Tech Lead, DevOps kiểm tra toàn bộ tiêu chí trước khi đóng gói phát hành.
