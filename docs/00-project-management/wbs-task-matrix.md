# Ma Trận Phân Rã Công Việc WBS (Work Breakdown Structure)
## Kiddora Mobile App — Multi-Sprint Master Delivery Matrix
**Scrum Master / PM**: Sub-Agent Project Manager (PM) — *"The Clockwork Disciplinarian"*  
**Phê duyệt Chiến lược**: Sub-Agent Product Owner (PO) — *"The Strategic Tyrant"*  
**Cập nhật**: 2026-10-22  

```
[PRD Approved (Gate 1)] 
          │
          ▼ (PM Phân rã WBS theo 6 Cổng Chất Lượng)
┌──────────────────────────────────────────────────────────────────────────────────┐
│ Gate 2 (Design)  : UI Spec, 4pt Grid, Claymorphism Tokens & 5 States              │
│ Gate 3 (QA)      : Master Test Plan, EP/BVA TCs & Gherkin .feature                │
│ Gate 4 (Dev FE)  : Feature-First Clean Code, Riverpod, AutoRoute & Ponytail UI    │
│ Gate 5 (Reviewer): Ponytail Diff Review, Cut Bloat & Over-engineering             │
│ Gate 6 (QA)      : 100% Pass Automated Test, 60 FPS, 0 Memory Leak               │
│ Gate 6.5 (Sec)   : COPPA Kid Privacy & Local Storage Encryption Audit             │
│ Gate 7 (Release) : Supreme Release Sign-off & Clean Git Branch                    │
└──────────────────────────────────────────────────────────────────────────────────┘
```

---

## 🏆 1. Các Sprint Đã Hoàn Thành & Đã Phát Hành (Released Sprints)

### Sprint 1: Interactive Onboarding & Kid Profile Identity (22 SP) — `RELEASED (v0.1.0)`
| Task ID | Hạng Mục Công Việc | Cổng | Sub-Agent | SP | Trạng Thái |
| :---: | :--- | :---: | :---: | :---: | :---: |
| **WBS-01** | Thiết kế UI Layout Spec 3 Slide Onboarding | Gate 2 | `ui-ux-designer` | 3 | `[x] DONE` |
| **WBS-02** | Xây dựng bộ testcase BDD Gherkin (`.feature`) | Gate 3 | `qa-tester` | 3 | `[x] DONE` |
| **WBS-03** | Khởi tạo AutoRoute 9.x & Onboarding Guard | Gate 4 | `dev` | 3 | `[x] DONE` |
| **WBS-04** | Entity & Repository Freezed `KidProfile` | Gate 4 | `dev` | 3 | `[x] DONE` |
| **WBS-05** | Phát triển 3 Slide Onboarding tương tác | Gate 4 | `dev` | 5 | `[x] DONE` |
| **WBS-06** | Màn hình Thiết lập Hồ sơ Bé cơ bản | Gate 4 | `dev` | 5 | `[x] DONE` |
| **WBS-07** | Tích hợp Haptic Feedback & Hiệu ứng Squish | Gate 4 | `dev` | 3 | `[x] DONE` |
| **WBS-08** | Ponytail Diff Review (Zero bloat) | Gate 5 | `code-reviewer` | 1 | `[x] DONE` |
| **WBS-09** | Test tự động & kiểm chuẩn 60 FPS | Gate 6 | `qa-tester` | 2 | `[x] DONE` |
| **WBS-10** | Kiểm toán an ninh COPPA & Local Storage | Gate 6.5 | `security-auditor` | 1 | `[x] DONE` |
| **WBS-11** | Nghiệm thu và phát hành Sprint 1 | Gate 7 | `po` / `tech-lead` | - | `[x] DONE` |

### Sprint 2: Tactile Kid Profile Setup v2 Enhancement (5 SP) — `RELEASED (v0.2.0)`
| Task ID | Hạng Mục Công Việc | Cổng | Sub-Agent | SP | Trạng Thái |
| :---: | :--- | :---: | :---: | :---: | :---: |
| **WBS-S2-01** | Quick Nickname Chips (Gợi ý biệt danh 1-tap & Dice Random) | Gates 1-7 | `dev` / `qa` | 1 | `[x] DONE` |
| **WBS-S2-02** | Tactile Clay Age Wheel Spinner (Dải tuổi 6–12 & Curriculum Hint) | Gates 1-7 | `dev` / `qa` | 2 | `[x] DONE` |
| **WBS-S2-03** | Tactile 3D Mascot Pedestal v2 (Trọn bộ 12 Con Giáp) | Gates 1-7 | `dev` / `qa` | 2 | `[x] DONE` |

### Sprint 3: 3 Core Screens 1:1 Implementation (13 SP) — `RELEASED (v0.3.0)`
| Task ID | Hạng Mục Công Việc | Cổng | Sub-Agent | SP | Trạng Thái |
| :---: | :--- | :---: | :---: | :---: | :---: |
| **WBS-S3-01** | Màn hình Đăng nhập (Welcome Back / Login Screen 1:1 Dribbble) | Gates 1-7 | `dev` / `qa` | 4 | `[x] DONE` |
| **WBS-S3-02** | Màn hình Trang Chủ Học Sinh (Student Dashboard & Clay Bottom Nav) | Gates 1-7 | `dev` / `qa` | 5 | `[x] DONE` |
| **WBS-S3-03** | Màn hình Mục Tiêu Học Tập Hàng Ngày (Today's Learning Goal 3D Circle) | Gates 1-7 | `dev` / `qa` | 4 | `[x] DONE` |

### Hardening & Auth Expansion (8 SP) — `COMPLETED`
| Task ID | Hạng Mục Công Việc | Cổng | Sub-Agent | SP | Trạng Thái |
| :---: | :--- | :---: | :---: | :---: | :---: |
| **WBS-HD-01** | Refactor Clean Code Ponytail: 100% AppStrings, AppColors, Zero magic numbers/emojis | Gate 4-5 | `tech-lead` / `dev` | 2 | `[x] DONE` |
| **WBS-HD-02** | RegisterScreen: Tactile Claymorphic Sign Up Form & Validation | Gates 1-6 | `dev` / `qa` | 3 | `[x] DONE` |
| **WBS-HD-03** | SplashScreen: Native Splash, App Icon & Route Guard Architecture | Gates 1-6 | `dev` | 1 | `[x] DONE` |
| **WBS-HD-04** | Catalog hóa & bóc tách 57 Màn hình Dribbble Benchmark qua 14 Domains | Gate 2 | `design` / `po` | 2 | `[x] DONE` |

---

## 🚀 2. Kế Hoạch Sprint 4 Đề Xuất: Courses Discovery & Curriculum Hub

* **Sprint Goal**: *"Hiện thực hóa trọn vẹn luồng Khám phá Khóa học (Domain 04) và Chi tiết Bài giảng (Domain 05): Tìm kiếm, lọc theo độ tuổi/môn học, lưới thẻ khóa học 3D xúc giác và lộ trình bài giảng tương tác."*
* **Dự kiến Story Points**: **13 SP**
* **Trạng thái**: `PLANNING` (Chờ kích hoạt Gate 1 PRD)

| Task ID | Hạng Mục Công Việc | Cổng | Sub-Agent Phụ Trách | SP | Tiêu Chuẩn Hoàn Thành (DoD) |
| :---: | :--- | :---: | :---: | :---: | :--- |
| **WBS-S4-01** | Spike kiến trúc dữ liệu Course & Curriculum (ADR) | Gate 0 | `tech-lead` | 1 | File ADR định nghĩa Course Entity, Mock Repository, không phụ thuộc mạng ngoài. |
| **WBS-S4-02** | PRD & BDD Scenarios cho Khám phá & Lọc khóa học | Gate 1 | `ba` / `po` | 2 | BDD Given-When-Then cho tìm kiếm, bộ lọc tuổi, và mở chi tiết khóa học. |
| **WBS-S4-03** | Thiết kế UI Layout Spec cho Courses Hub, Search & Filter Sheet | Gate 2 | `ui-ux-designer` | 2 | Khớp 1:1 các màn hình `04_courses_01` -> `04_courses_04` và `05_course_detail`. |
| **WBS-S4-04** | Master Test Plan & Traceability Matrix cho Courses Hub | Gate 3 | `qa-tester` | 2 | File `.feature` bao phủ tìm kiếm không kết quả, lọc đa điều kiện, chuyển tab bài học. |
| **WBS-S4-05** | Phát triển Màn hình Courses Hub & Bộ Lọc Đất Sét Bo Cong | Gate 4 | `dev` | 3 | Thanh tìm kiếm, chip danh mục môn học, lưới khóa học 2 cột, 60 FPS. |
| **WBS-S4-06** | Phát triển Màn hình Chi Tiết Khóa Học (Course Detail & Lessons List) | Gate 4 | `dev` | 3 | 3 tab (Lessons, About, Reviews), thẻ CTA [Start Learning], danh sách bài giảng. |
| **WBS-S4-07** | Ponytail Diff Review, Quét Bloat & Dead Code | Gate 5 | `code-reviewer` | - | Đảm bảo không thừa abstraction, tái sử dụng `ClayCard`, `ClayButton`. |
| **WBS-S4-08** | Kiểm thử Tự động, Đo kiểm 60 FPS & 0 Memory Leak | Gate 6 | `qa-tester` | - | 100% tests pass, zero overflow trên mọi kích cỡ màn hình. |
| **WBS-S4-09** | Ký duyệt Release Sprint 4 | Gate 7 | `po` / `tech-lead` | - | Cấp tag `v0.4.0-courses-hub`. |
