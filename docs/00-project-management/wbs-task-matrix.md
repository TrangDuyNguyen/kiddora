# Ma Trận Phân Rã Công Việc WBS (Work Breakdown Structure)
## Kiddora Mobile App — Multi-Sprint Master Delivery Matrix
**Project Manager (PM)**: Sub-Agent Project Manager (PM) — *"The Clockwork Disciplinarian"*  
**Scrum Master (SM)**: Sub-Agent Scrum Master (SM) — *"The Servant Leader & Agile Coach"*  
**Phê duyệt Chiến lược**: Sub-Agent Product Owner (PO) — *"The Strategic Tyrant"*  
**Cập nhật**: 2026-10-29  

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

### Sprint 4: Fullstack E2E Auth, Onboarding & User Sync (15 SP) — `RELEASED (v0.4.0)`
*Theo phê duyệt tại [CR-006](file:///Users/nguyenduytrang/flutter_project/kiddora/docs/05-change-management/change-request-log.md) & [SPEC-20261023](file:///Users/nguyenduytrang/flutter_project/kiddora/docs/04-specifications/specs/2026-10-23-fullstack-auth-onboarding-design.md)*
* **Release Tag**: `v0.4.0-auth-onboarding-e2e` (29/10/2026)

| Task ID | Hạng Mục Công Việc | Cổng | Sub-Agent Phụ Trách | SP | Tiêu Chuẩn Hoàn Thành (DoD) | Trạng Thái |
| :---: | :--- | :---: | :---: | :---: | :--- | :---: |
| **WBS-S4-01** | Cấu hình Alembic Migration & PostgreSQL Schema 0001 | Gate 0 | `tech-lead` / `dev` | 2 | File `alembic.ini`, `env.py`, migration `0001` tạo bảng `users` & `kid_profiles` | `[x] DONE` |
| **WBS-S4-02** | FastAPI REST Endpoints & Service (`/register`, `/login`, `/me`, `/kid-profile`) | Gate 4B | `backend-dev` | 3 | Tách 2 bước register/profile, JWT 7 ngày, Pydantic schemas, Pytest suite | `[x] DONE` |
| **WBS-S4-03** | Cập nhật Doc PRD, BDD Given-When-Then & Data Dictionary Zero-Drift | Gate 1 | `ba` / `po` | 2 | Cập nhật data-dictionary, change-request-log, spec 2026-10-23 | `[x] DONE` |
| **WBS-S4-04** | Core Network Layer Flutter (Dio ApiClient, TokenStorage test-safe) | Gate 4A | `flutter-expert` | 2 | `api_client.dart` tự gắn Bearer token, `token_storage.dart` in-memory fallback | `[x] DONE` |
| **WBS-S4-05** | Tích hợp E2E Flutter UI: Register, Login, KidProfile, Guest Banner | Gate 4A | `flutter-expert` | 3 | Kết nối controller với API, guest explore link, guest claim banner | `[x] DONE` |
| **WBS-S4-06** | Code Review (Ponytail: rà soát diff, zero bloat, SLA verification) | Gate 5 | `code-reviewer` | 1 | Zero bloat, tái sử dụng AppValues & AppColors, không magic numbers | `[x] DONE` |
| **WBS-S4-07** | Kiểm thử Tự động, Đo kiểm 60 FPS & 0 Memory Leak | Gate 6 | `qa-tester` | 2 | 100% tests pass (83/83 tests flutter), 0 analyze warnings | `[x] DONE` |
| **WBS-S4-08** | Ký duyệt Release Sprint 4 | Gate 7 | `po` / `tech-lead` | - | Biên bản Gate 7 & Git Tag `v0.4.0-auth-onboarding-e2e` | `[x] DONE` |

### Gói Mở Rộng Hệ Thống UI Kit & 3D Assets (Phase 1 + Phase 2 — CR-013: 26 SP) — `COMPLETED`
| Task ID | Hạng Mục Công Việc | Cổng | Sub-Agent Phụ Trách | SP | Tiêu Chuẩn Hoàn Thành (DoD) | Trạng Thái |
| :---: | :--- | :---: | :---: | :---: | :--- | :---: |
| **WBS-UI1-01** | Spec & Tokens cho `ClayDialog` + `ClayButton.secondary` (Việt hóa `AppStrings`) | Gate 0-1 | `tech-lead` / `ba` | 1 | 0 magic numbers, 0 raw colors, 0 hard text | `[x] DONE` |
| **WBS-UI1-02** | Generate & tách nền RGBA 32-bit cho 7 Assets 3D Tactile Clay (`modal_*`, `icon_*`, `avatar_student_boy`) | Gate 2 | `image-generator` / `ui-ux-designer` | 5 | Nền trong suốt không viền trắng, chuẩn `@3x` PNG | `[x] DONE` |
| **WBS-UI1-03** | Thiết kế & thực thi bộ Test Matrix chống tràn `360×640` + `textScaler: 1.5x` | Gate 3 | `qa-tester` | 4 | Bao phủ cả 3 Modal, FilterBar, Header, ListTile, Badges | `[x] DONE` |
| **WBS-UI1-04** | Triển khai `ClayDialog`, `ClayButton.secondary` & `compact`, đấu nối `HomeScreen` Logout/Empty Sessions | Gate 4A | `flutter-core-dev` | 5 | Mọi file `< 200 dòng`, `RepaintBoundary`, xóa sạch `TokenStorage` | `[x] DONE` |
| **WBS-UI2-03** | Chuẩn hóa `ClayBottomNav` 5-tab (`Profile`) về `shared/ui_kit/navigation/`, xây dựng `ClayScreenHeader`, `ClayFilterBar`, `ClayListTile`, `StarCounterBadge.custom` | Gate 4A | `flutter-core-dev` | 6 | Tái sử dụng trực tiếp tại `HomeScreen`, `HomeUpcomingSessionCard`, `TodayLearningGoalScreen` | `[x] DONE` |
| **WBS-UI2-05** | Ponytail Git Diff Review, Visual QA (`flutter-preview`), `flutter test` (83/83 Pass) & Continuous Doc-Sync | Gate 5-6 | `code-reviewer` / `qa-tester` | 5 | `flutter analyze` 0 lỗi, 83/83 tests pass, cập nhật đủ `docs/` & `graphify` | `[x] DONE` |

---

## 🚀 2. Kế Hoạch Sprint 5: Courses Hub, Discovery & Curriculum Details (20 SP)
*Theo phê duyệt tại [EPIC-06](file:///Users/nguyenduytrang/flutter_project/kiddora/docs/00-roadmap/epics-backlog.md) & [EPIC-07](file:///Users/nguyenduytrang/flutter_project/kiddora/docs/00-roadmap/epics-backlog.md)*

* **Sprint Goal**: *"Hiện thực hóa Phân hệ Khám phá Khóa học (Courses Hub & Smart Discovery) và Chi tiết Khóa học (Course Detail & Curriculum), tích hợp bộ lọc môn học ClayFilterBar, thẻ bài học xúc giác 3D, đồng bộ Mock & REST API danh mục khóa học chuẩn Freezed."*
* **Tổng Story Points**: **20 SP**
* **Trạng thái**: `PLANNING_AND_READY`

| Task ID | Hạng Mục Công Việc | Cổng | Sub-Agent Phụ Trách | SP | Tiêu Chuẩn Hoàn Thành (DoD) | Trạng Thái |
| :---: | :--- | :---: | :---: | :---: | :--- | :---: |
| **WBS-S5-01** | [KZN-01] Xây dựng Data Models `Course`, `Lesson`, `Subject` Freezed & Seed Data | Gate 0 | `tech-lead` / `backend-dev` | 3 | Entities chuẩn Freezed, Alembic migration 0002 cho courses/lessons, Mock Repository | `[ ] READY` |
| **WBS-S5-02** | Đồng bộ PRD, BDD Gherkin & Data Dictionary cho Khám phá Khóa học | Gate 1 | `ba` / `po` | 2 | Cập nhật `06-courses-discovery-and-hub`, Given-When-Then, 0 drift | `[ ] READY` |
| **WBS-S5-03** | Màn hình Khám Phá Khóa Học (Courses Hub, ClaySearchBar, Subject ClayFilterBar, CourseGrid) | Gate 4A | `flutter-core-dev` | 5 | Tái sử dụng UI Kit v2, 60 FPS, touch targets >= 48dp, 0 magic numbers | `[ ] READY` |
| **WBS-S5-04** | Màn hình Chi Tiết Khóa Học (Course Detail: Hero 3D Card, 3 Tabs: Lessons, About, Reviews) | Gate 4A | `flutter-core-dev` | 4 | Danh sách bài học xúc giác, nút Bắt đầu học, rating sao | `[ ] READY` |
| **WBS-S5-05** | FastAPI REST Endpoints (`GET /api/v1/courses`, `GET /api/v1/courses/{id}`, `/subjects`) | Gate 4B | `backend-dev` | 3 | Pydantic response models, filtering theo subject/age, Pytest suite | `[ ] READY` |
| **WBS-S5-06** | Ponytail Git Diff Review (Tối giản code, không tạo abstraction thừa) | Gate 5 | `code-reviewer` | 1 | File < 200 dòng, không magic numbers, 100% AppStrings/AppColors | `[ ] READY` |
| **WBS-S5-07** | Automated Widget Tests & Visual QA Matrix (Chống tràn 360×640, text scale 1.5x) | Gate 6 | `qa-tester` | 2 | 100% tests pass, 0 overflow, 60 FPS | `[ ] READY` |
| **WBS-S5-08** | Nghiệm thu và Ký duyệt Release Sprint 5 (v0.5.0-courses-hub) | Gate 7 | `po` / `tech-lead` | - | Biên bản Gate 7 & Release Tag `v0.5.0-courses-hub` | `[ ] READY` |
