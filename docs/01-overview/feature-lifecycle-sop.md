# Quy Trình Phát Triển Tính Năng Toàn Diện (8-Gate Feature Lifecycle SOP) — Kiddora

Tài liệu này chuẩn hóa **Quy trình Phát triển Tính năng Khép kín (End-to-End Feature Delivery SOP)** từ lúc khởi tạo ý tưởng đến khi phát hành ra thị trường, vận hành bởi **9 Sub-Agents Chuyên Trách** theo nguyên tắc kiểm soát chéo (**Four-Eyes Principle**).

---

## 🧭 Sơ Đồ Điều Phối 8 Cổng Chất Lượng

```mermaid
flowchart TD
    Strategy([👑 Sub-Agent PO: Định Hướng Epic & MoSCoW]) --> Gate0
    
    subgraph Gate0: Kiến Trúc & Thử Nghiệm [CỔNG 0: Sub-Agent Tech Lead - docs/04-specifications/adr/]
        Gate0[Khảo sát kỹ thuật & Spikes]
        ADR[Ban hành Quyết định Kiến trúc ADR]
        Gate0 --> ADR
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
    
    Gate2 & Gate3 --> Gate4
    
    subgraph Gate4: Triển Khai Mã Nguồn [CỔNG 4: Sub-Agent Dev FE]
        Gate4[Clean Code: Domain -> Data -> Presentation]
        PonytailCode[Triệt tiêu Magic Numbers & Emojis, dùng AppStrings]
        UnitTests[Viết Unit & Widget Tests]
        Gate4 --> PonytailCode --> UnitTests
    end
    
    UnitTests -->|flutter analyze 0 warnings| Gate5
    
    subgraph Gate5: Rà Soát Tinh Gọn [CỔNG 5: Sub-Agent Code Reviewer]
        Gate5[Quét Git Diff & Triệt tiêu Over-engineering]
        Signoff5[Cấp chứng chỉ: Lean already. Ship.]
        Gate5 --> Signoff5
    end
    
    Signoff5 --> Gate6 & Gate6_5
    
    subgraph Gate6 & 6.5: Nghiệm Thu Thực Chất & An Ninh [ĐỘC LẬP CHẶN CỔNG]
        Gate6[QA Tester & Visual QA: 100% Pass, 60 FPS, 0 Overflow]
        Gate6_5[Security Auditor: Kiểm toán COPPA & Parental Gate]
    end
    
    Gate6 & Gate6_5 --> Gate7
    
    subgraph Gate7: Ký Duyệt Phát Hành [CỔNG 7: Hội Đồng Ký Duyệt Tối Cao]
        Gate7[PO, PM, Tech Lead Ký Duyệt Release Tag]
    end
```

---

## 📋 Chi Tiết Trách Nhiệm Từng Cổng Chất Lượng

### Cổng 0: Nghiên Cứu Kỹ Thuật & Quyết Định Kiến Trúc (Gate 0 — Tech Lead)
- **Đầu ra**: Tài liệu `docs/04-specifications/adr/adr-*.md`.
- **Trách nhiệm**: Đánh giá tính khả thi, phân tích rủi ro bộ nhớ, kiểm soát Cold Start $\le 1.8\text{s}$, kích thước bản build $\le 65\text{MB}$.

### Cổng 1: Đặc Tả Nghiệp Vụ & BDD Scenarios (Gate 1 — BA & PO)
- **Đầu ra**: Thư mục tính năng `docs/03-prd-features/<feature-name>/prd-*.md` và `user-stories.md`.
- **Trách nhiệm**: BA viết tiêu chuẩn nghiệm thu dạng Given-When-Then chi tiết, PO và Tech Lead đồng ký duyệt Feasibility trước khi code.

### Cổng 2: Thiết Kế Giao Diện Tactile Claymorphism (Gate 2 — UI/UX Designer)
- **Đầu ra**: `docs/03-prd-features/<feature-name>/ui-ux-screen-specs.md`.
- **Trách nhiệm**: Bố cục lưới 4pt, 5 trạng thái màn hình (`default`, `hover`, `active/pressed`, `disabled`, `error`), tương thích chuẩn WCAG 2.2 AA.

### Cổng 3: Thiết Kế Kế Hoạch Kiểm Thử Sớm (Gate 3 — QA Tester)
- **Đầu ra**: `docs/03-prd-features/<feature-name>/gate-3-test.md` và file kịch bản `.feature`.
- **Trách nhiệm**: Bao phủ 100% kịch bản kiểm thử Happy Path và Edge Cases (mất mạng, xoay màn hình, nhập sai).

### Cổng 4: Triển Khai Mã Nguồn Sạch (Gate 4 — Dev FE)
- **Đầu ra**: Mã nguồn Flutter trong `lib/features/<feature-name>/` và `test/`.
- **Trách nhiệm**: Feature-First Clean Architecture, Riverpod Notifier, AutoRoute. Tuyệt đối không dùng magic numbers (100% `AppValues`), không emojis, 100% chuỗi trong `AppStrings`.

### Cổng 5: Rà Soát Tinh Gọn Ponytail (Gate 5 — Code Reviewer)
- **Đầu ra**: Biên bản rà soát `gate-5-ponytail-review.md`.
- **Trách nhiệm**: Săn tìm và triệt tiêu code thừa, YAGNI, over-engineering qua git diff. Chỉ chấp thuận khi code đạt chuẩn tối giản.

### Cổng 6: Nghiệm Thu Tự Động & Visual QA (Gate 6 — QA Tester)
- **Đầu ra**: Biên bản `gate-6-qa-signoff.md`.
- **Trách nhiệm**: Chạy `flutter test` đạt $100\%$ pass, kiểm tra tốc độ $60\text{ FPS}$, kiểm tra không có hiện tượng RenderFlex overflow khi text scale 1.5x.

### Cổng 6.5: Kiểm Toán An Toàn Trẻ Em (Gate 6.5 — Security Auditor)
- **Đầu ra**: Biên bản `gate-6.5-security-signoff.md`.
- **Trách nhiệm**: Xác nhận không thu thập PII, kiểm toán bảo mật SharedPreferences, kiểm tra cơ chế khóa phụ huynh Parental Gate math riddle.

### Cổng 7: Ký Duyệt Phát Hành Tối Cao (Gate 7 — Hội Đồng Phát Hành)
- **Đầu ra**: File `release-v*.md` và Git tag chính thức.
- **Trách nhiệm**: Hội đồng PO, PM, Tech Lead kiểm tra toàn bộ tiêu chí trước khi đóng gói phát hành.
