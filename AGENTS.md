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
  - Stitch Design System Asset: `assets/9652051346587888941` (`Tactile Clay Learning (Kiddora)`)

---

## 2. Tech Stack & Dependencies

- **Flutter / Dart**: Flutter 3.x, Dart `>=3.0.0 <4.0.0`
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

---

## 6. End-to-End Feature Delivery Lifecycle (8-Gate SOP & Multi Sub-Agents)

All feature development follows the **Four-Eyes Principle** with 9 specialized Sub-Agents:
- **Sub-Agent PO**: Roadmap, MoSCoW, Gate 1 & Gate 7 Sign-offs.
- **Gate 0: Tech Lead**: Architecture spikes, ADR, SLAs (Cold start <= 1.8s, 60 FPS, 0 memory leak).
- **Gate 1: BA**: PRD, User Stories BDD (Given-When-Then), Data Dictionary.
- **Gate 2: UI/UX Designer**: Tactile Claymorphism, Google Stitch MCP screens, 5 UI states.
- **Gate 3: QA Tester**: Test design, BDD Gherkin scenarios, 100% Traceability.
- **Gate 4: Dev FE**: Flutter Clean Architecture, Riverpod, Ponytail code.
- **Gate 5: Reviewer**: Ponytail git diff review, ruthlessly delete bloat.
- **Gate 6: QA Verify**: Automated tests, 0 memory leak, 60 FPS.
- **Gate 6.5: Security Auditor**: Child data privacy (COPPA), Parental Gate verification, zero leaks.
- **Gate 7: Release**: Production clearance and distribution.
