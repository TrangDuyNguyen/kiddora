# AGENTS.md — Kiddora Project Guidelines

> This file provides context, architectural constraints, and development guidelines for AI coding assistants (Google Antigravity, Gemini, Cursor, Claude Code, GitHub Copilot).

---

## 1. Project Overview

- **Name**: Kiddora (`kiddora`)
- **Type**: Cross-platform Mobile App (iOS & Android)
- **Description**: Kids Learning & Live Classes Mobile App designed for primary learners (ages 7–10: Mental Math, STEM Explorers, Logic Puzzles) & Parents, featuring signature Tactile Claymorphism 3D UI and real-time live classroom interactions.
- **Key Reference Docs**:
  - Design System Guide: [`DESIGN.md`](./DESIGN.md)
  - Project Overview: [`README.md`](./README.md)
  - Google Stitch Project ID: `11612036710163643589`
  - Stitch Design System Asset: `assets/4f23066581b9416eb589a101d788b98a` (`Tactile Clay Learning (Kiddora)`)
  - Stitch Design System Seed Asset: `assets/9652051346587888941`

---

## 2. Tech Stack & Dependencies

- **Flutter / Dart Baseline**: Flutter `3.29.x` (Channel `stable`), Dart `3.7.x` (`>=3.7.0 <4.0.0`).
- **Dependency Locking Policy (SSOT)**:
  - `pubspec.lock` và `backend/requirements.txt` là duy nhất và bắt buộc đồng bộ 100% giữa mọi máy (macOS Client & Windows Host Server).
  - **Cấm tuyệt đối**: Không tự ý chạy `flutter pub upgrade` hoặc cài đặt thư viện đòi hỏi Dart SDK vượt quá baseline (`3.7.x`).
  - Mọi máy đều phải sử dụng chung kênh Flutter `stable`. Khi kéo code về chỉ dùng `flutter pub get`.
- **State Management**: `flutter_riverpod: ^2.6.1`, `riverpod_annotation: ^2.6.1`, `riverpod_generator: ^2.6.3`
- **Routing**: `auto_route: ^9.2.2`, `auto_route_generator: ^9.0.0`
- **Data Modeling**: `freezed: ^3.0.2`, `json_serializable: ^6.9.4`
- **UI & Graphics**: `google_fonts: ^6.2.1` (Mona Sans, Quicksand), `fl_chart: ^0.70.2`, `cached_network_image: ^3.4.1`, `lottie: ^3.3.1`

---

## 3. Directory Structure & Architecture Rules

Kiddora uses **Feature-First Clean Architecture**:

```
lib/
├── core/                         # Cross-cutting concerns & foundational layer
│   ├── constants/                # App strings, numerical constraints (app_strings.dart, app_values.dart)
│   ├── router/                   # AutoRoute setup (app_router.dart, app_router.gr.dart)
│   ├── theme/                    # Tactile Clay tokens (app_colors.dart, app_theme.dart)
│   └── utils/                    # Calculations, sound effects, validation logic
├── features/                     # Business domain modules
│   ├── classroom/                # Live interactive classroom, buzzer, reaction emojis
│   ├── exploration/              # Subject hubs (Math Magic, STEM Explorer, Logic Riddles)
│   ├── onboarding/               # Kid profile setup, age selector, clay avatar picker
│   ├── parent_hub/               # PIN protection math riddle, screen time, progress insights
│   └── quests/                   # Gamified learning path, daily streaks, reward chests
├── shared/                       # Reusable design system components
│   └── ui_kit/                   # Central Tactile Claymorphic UI Kit
│       ├── surfaces/             # ClayCard, ClaySheet
│       ├── buttons/              # ClayButton, ClayBuzzerButton, ClayIconButton
│       ├── inputs/               # ClayPinPad, ClaySearchBar
│       ├── indicators/           # StarCounterBadge, StreakFlame, ClayProgressBar
│       └── navigation/           # ClayBottomNav
├── app.dart                      # Root MaterialApp / AutoRoute configuration
└── main.dart                     # App initialization (ProviderScope)
```

### Layer Constraints
1. **Domain (`features/<feature>/domain`)**:
   - Pure Dart entities and value objects.
   - Use `@freezed` for immutable models.
   - Zero Flutter UI dependencies.
2. **Data (`features/<feature>/data`)**:
   - DTOs / serialization with `json_serializable`.
   - Local storage & API datasources.
3. **Presentation (`features/<feature>/presentation`)**:
   - Riverpod `@riverpod` controllers / Notifiers (`AsyncNotifier`).
   - Screens annotated with `@RoutePage()`.
   - UI widgets consuming providers via `ConsumerWidget` or `ConsumerStatefulWidget`.
4. **Shared (`shared/ui_kit`)**:
   - Reusable design system components implementing Tactile Claymorphism.
   - Purely visual components with zero domain-specific coupling.

---

## 4. UI & Design System Rules (Tactile Claymorphism × WCAG 2.2 AA)

> [!IMPORTANT]
> Always adhere to the tokens defined in `DESIGN.md`.

- **Strict Subject / Semantic Color Association**:
  - 🩵 **Primary Indigo (`#4648D4` / `#6366F1`)**: Mental Math (*Toán tư duy*) + Primary interactive controls (FAB, active navigation). Contrast ratio `8.4:1` (WCAG AAA).
  - 🌟 **Joyful Amber (`#F59E0B` / `#FBBF24`)**: Star rewards, streak counters, Live quiz buzzer.
  - 🍓 **STEM Pink (`#EC4899`)**: STEM Explorers (*Khoa học thực nghiệm*) + favorites and creative tasks.
  - 🥑 **Meadow Mint (`#10B981`)**: Success states, completed lessons, correct answers, Live stream active.
  - ☁️ **Sky Blue (`#0EA5E9`)**: Informational tags, online classmates count.
  - 🥛 **Warm Canvas**: Porcelain Canvas `#FCF8FF` / `#F8FAFC`, Pure White Clay Cards `#FFFFFF`.
- **Tactile Clay Illumination Formula**:
  - Upper-left specular highlight: `inset 3px 3px 5px rgba(255, 255, 255, 0.85)`
  - Lower-right compression shading: `inset -3px -3px 5px rgba(13, 12, 34, 0.06)`
  - Active pressed state (haptic squish): `scale(0.96) translateY(3px)`
- **Ergonomics & Accessibility**:
  - Touch targets: Minimum **48×48dp** (recommended **56×56dp** for primary actions).
  - High-visibility focus indicator: `3px solid #6366F1` with `2px` offset.
  - 7 explicit component states: `default`, `hover`, `focus-visible`, `active`, `disabled`, `loading`, `error`.

---

## 5. Coding & Development Conventions (Ponytail Clean Code)

1. **YAGNI First**: Never write speculative code or unused abstractions.
2. **Reusability**: Use shared widgets from `lib/shared/ui_kit/` before writing custom widgets.
3. **File Length Limits**:
   - Hard cap: **500 lines** per file.
   - Target size: `< 200 lines`.
   - Widget build nesting: Maximum **5 levels** deep.
4. **State Management**: Prefer code-generation Riverpod (`@riverpod`). Keep side-effects inside Notifier methods.
5. **Code Generation**: Run `make gen` (`dart run build_runner build --delete-conflicting-outputs`).
6. **Testing**: Run `flutter test` before completing tasks.
7. **Zero-Tolerance Clean Code (Nghiêm Cấm Tuyệt Đối)**:
   - **Cấm Magic Numbers & Raw Colors**: Tuyệt đối không dùng số tự do (raw numbers) cho padding, margin, width, height, radius, font size, duration, elevation. Bắt buộc $100\%$ sử dụng token từ `AppValues` (`lib/core/constants/app_values.dart`). Không dùng mã màu hex thô (`Color(0xFF...)`) trực tiếp trong UI, bắt buộc khai báo và dùng từ `AppColors` (`lib/core/constants/app_colors.dart`).
   - **Cấm Emoji Trong Chuỗi & Mã Nguồn**: Không được chèn emoji (`✨`, `🚀`, `👍`, `🎉`, v.v.) vào chuỗi giao diện hoặc code logic. Mọi biểu tượng cảm xúc, minh họa phải là icon (`IconData`), SVG hoặc 3D asset minh họa chuyên biệt.
   - **Cấm Hard Text (Hardcoded Strings)**: Tuyệt đối không viết text thô (hardcoded string literals) trực tiếp trong các file presentation / widgets. $100\%$ chuỗi văn bản (tiêu đề, nhãn nút, placeholder, thông báo, câu hỏi, mô tả) phải được định nghĩa tập trung trong `AppStrings` (`lib/core/constants/app_strings.dart`).

---

## 6. End-to-End Feature Delivery Lifecycle (8-Gate SOP & 12 Specialized Sub-Agents)

All feature development follows the **Four-Eyes Principle** with 12 specialized Sub-Agents & Dual-Track Gate 4 execution:
- **Sub-Agent PO**: Roadmap, MoSCoW, OKRs, Gate 1 & Gate 7 Sign-offs.
- **Sub-Agent PM**: WBS breakdown, Fibonacci Story Points, Risk Log, Capacity tracking, Project status reporting.
- **Sub-Agent Scrum Master (SM)**: Sprint ceremonies facilitation (Planning, Daily, Review, Retro, Refinement), Impediment removal, Velocity optimization, Agile coaching.
- **Gate 0: Tech Lead**: Architecture spikes, ADR, SLAs (Cold start <= 1.8s, 60 FPS, 0 memory leak).
- **Gate 0 & Operations: DevOps & Infra (`devops-infra`)**: Docker Compose 6 services, Caddy v2 SSL/TLS reverse proxy, PostgreSQL backups, LiveKit SFU ports, MinIO buckets, VPS deployment readiness.
- **Gate 1: BA**: PRD, User Stories BDD (Given-When-Then), Data Dictionary synchronization.
- **Gate 2: UI/UX Designer**: Tactile Claymorphism, Google Stitch MCP screens, 5 UI states, 4pt grid.
- **Gate 3: QA Tester & Visual QA**: Test design, BDD Gherkin scenarios, 100% Traceability, Visual Test Matrix.
- **Gate 4A: Dev FE (`flutter-expert` / `flutter-core-dev`)**: Flutter Clean Architecture, Riverpod, Ponytail code, widget tests.
- **Gate 4B: Dev BE (`backend-dev`)**: FastAPI (Python 3.12+), Feature-First Modular Monolith (`backend/app/modules/`), SQLAlchemy 2.0 Async ORM, Alembic migrations, Redis caching, Celery worker, MinIO S3, LiveKit WebRTC, Pytest suite.
- **Gate 5: Reviewer (`code-reviewer`)**: Ponytail git diff review (FE & BE), ruthlessly delete bloat & over-engineering.
- **Gate 6: QA Verify & Visual QA**: Automated tests (100% real pass FE & BE), 0 memory leak, 60 FPS, 0 RenderFlex overflow / visual defects via Flutter Preview MCP & Vision AI, API contract verification.
- **Gate 6.5: Security Auditor (`security-auditor`)**: Child data privacy (COPPA), Parental Gate verification, Container & Secrets audit, Zero-Trust network rules.
- **Gate 7: Release**: Production clearance, DevOps infrastructure verification, Git release tag.

### Real-Time Mission Control Dashboard
- Command: `make dashboard` or `./scripts/dashboard.sh`
- Neobrutalism web UI binds to `http://127.0.0.1:8765` for real-time sub-agent tracking, multi-sprint management, and human-in-the-loop approvals without invisible work.

---

## 7. Kỷ Luật Bất Khả Xâm Phạm: Đồng Bộ Hóa Tài Liệu (Continuous Doc-Sync & Zero Drift)

> [!IMPORTANT]
> **Code đổi là Doc phải đổi (Backward Sync)**: Mỗi khi có bất kỳ sự thay đổi nào về tính năng (logic nghiệp vụ, giao diện UI, route điều hướng, trạng thái Riverpod, data model thực thể, validation rules hoặc phạm vi scope), BẮT BUỘC $100\%$ phải cập nhật đồng thời vào hệ thống tài liệu `docs/` ngay trong cùng commit / task:
> 1. **Doc Tính Năng (`docs/03-prd-features/<feature-name>/`)**: Bắt buộc cập nhật `prd-*.md`, `user-stories.md` (BDD Given-When-Then) và `ui-ux-screen-specs.md` (5 UI states & tokens).
> 2. **Sổ Yêu Cầu Thay Đổi (`docs/05-change-management/change-request-log.md`)**: Ghi nhận mã CR mới với lý do và tác động.
> 3. **Từ Điển Dữ Liệu (`docs/04-specifications/data-dictionary.md`)**: Cập nhật ngay khi thay đổi, thêm hoặc xóa trường dữ liệu entity.
> 4. **Quản Lý Vận Hành (`docs/00-project-management/`)**: Cập nhật trạng thái `wbs-task-matrix.md` và `sprint-backlog.md` nếu phạm vi hoặc Definition of Done (DoD) thay đổi.
> 5. **Cấm Tuyệt Đối Báo Cáo "Xong" Khi Chưa Cập Nhật Doc**: Không được báo cáo hoàn thành tính năng nếu tài liệu đặc tả chưa khớp $100\%$ với mã nguồn thực tế.

