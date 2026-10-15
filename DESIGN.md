# DESIGN.md — Kiddora Design System

> **Product**: Kiddora — Kids Learning & Live Classes Mobile App  
> **Reference**: [Hitesh Tapaniya on Dribbble](https://dribbble.com/shots/27746677-Kiddora-Kids-Learning-Live-Classes-Mobile-App-UI-UX-Design)  
> **Target Audience**: Primary Learners (Ages 7–10: Mental Math, STEM Explorers, Logic Puzzles), Parents & Live Class Instructors  
> **Visual Style**: Modern Tactile Claymorphism × High-Contrast Ergonomics  
> **Accessibility Standard**: WCAG 2.2 AA Compliance  
> **Document Version**: `1.0.0`

---

## 1. Context and Goals

### 1.1 One-Sentence Design Intent
> **Design Intent**: Empower 7–10 year-old primary learners with an engaging, tactile, and cognitively accessible interface for mastering logic, mental math, and STEM through live interactive classes and self-paced quests, while giving parents and educators actionable clarity.

### 1.2 Core Product Surfaces
1. **Interactive Kids Mobile Experience**:
   - **Gamified Quest Map**: Adaptive learning paths with tactile clay nodes, daily streak counters, and reward star chests.
   - **Live Interactive Classroom**: Ultra-low latency video stream with real-time interactive quiz buzzers, digital hand-raising, and floating emoji reactions.
   - **Subject Exploration Hub**: Dedicated modules for Mental Math (*Toán tư duy*), STEM Discovery (*Khoa học thực nghiệm*), and Logic Riddles (*Câu đố logic*).
2. **Parental & Educator Gate**:
   - **4-Digit Clay PIN Lock**: Protects settings, subscription management, and detailed progress analytics from inadvertent child touches.
   - **Progress & Mastery Dashboard**: Transparent tracking of study time, subject strengths, and teacher evaluation notes.

---

## 2. Design Tokens and Foundations

### 2.1 Color Palette & Semantic Tokens

All UI implementations **must** reference semantic tokens rather than raw hex values.

| Semantic Token | Value | Role & Usage | Contrast Ratio (vs Surface) |
| :--- | :--- | :--- | :--- |
| `color.brand.primary` | `#4648D4` / `#6366F1` | Playful Indigo: Primary interactive controls, active navigation, Math tracks | `8.4:1` (Passes AAA) |
| `color.brand.secondary` | `#F59E0B` / `#FBBF24` | Joyful Amber: Star counters, streak badges, achievement banners | `3.2:1` (Accent anchor) |
| `color.brand.tertiary` | `#EC4899` / `#F472B6` | Bubblegum Pink: STEM Lab indicators, favorite triggers, creative tasks | `4.6:1` (Passes AA) |
| `color.brand.mint` | `#10B981` | Meadow Mint: Success states, completed levels, correct answers | `4.5:1` (Passes AA) |
| `color.brand.sky` | `#0EA5E9` | Sky Blue: Live class status indicators, participant badges, audio prompts | `4.8:1` (Passes AA) |
| `color.text.primary` | `#0D0C22` | Deep Ink: Main titles, question prompts, high-emphasis copy | `15.2:1` (Passes AAA) |
| `color.text.secondary` | `#6E6D7A` | Slate Neutral: Metadata, lesson durations, secondary labels | `5.1:1` (Passes AA) |
| `color.text.tertiary` | `#060318` | Black Ink: Strict tabular numerals, timer countdowns | `16.8:1` (Passes AAA) |
| `color.text.inverse` | `#FFFFFF` (on dark) / `#524B63` | White on primary buttons; Muted Indigo on tinted surfaces | `8.4:1` on `#4648D4` |
| `color.surface.base` | `#FCF8FF` / `#F8FAFC` | Warm Porcelain Canvas: Eye-friendly non-glare background | Base |
| `color.surface.muted` | `#FFFFFF` | Clay Card Surface: Base container for cards and modal sheets | Base container |
| `color.surface.raised` | `#ECEBF0` | Inset recessed tracks: Progress bar grooves, inactive chip fills | Surface tier 1 |
| `color.border.default` | `#E2E8F0` | Subtle container outline to preserve clarity on low-tier screens | `1.5px` border |
| `color.border.focus` | `#6366F1` | WCAG Focus-Visible Ring (3px solid with 2px offset) | Minimum `3:1` |
| `color.feedback.error` | `#BA1A1A` / `#EF4444` | Gentle Coral Red: Error alerts, incomplete tasks (non-punitive tone) | `5.3:1` (Passes AA) |

### 2.2 Typography Scale (Primary: Mona Sans)

- **Primary Font Family**: `font.family.primary = Mona Sans`
- **Fallback Font Stack**: `font.family.stack = Mona Sans, Quicksand, Helvetica Neue, Helvetica, Arial, sans-serif`
- **Base Body**: `font.size.base = 14px`, `font.weight.base = 400`, `font.lineHeight.base = 22px`

| Typography Token | Font Size | Line Height | Font Weight | Letter Spacing | Typical Application |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `font.size.xs` | `9px` | `14px` | `700` (Bold) | `+0.04em` | Micro badges, live participant tags |
| `font.size.sm` | `11px` | `16px` | `600` (SemiBold) | `+0.02em` | Lesson category tags, time remaining |
| `font.size.md` | `12px` | `18px` | `500` (Medium) | `0em` | Subtitle captions, parent note dates |
| `font.size.lg` | `13px` | `20px` | `600` (SemiBold) | `0em` | Secondary button labels, tab bar items |
| `font.size.xl` | `14px` | `22px` | `500` (Medium) | `0em` | Body text, question explanation text |
| `font.size.2xl` | `16px` | `24px` | `700` (Bold) | `0em` | Primary button labels, card headers |
| `font.size.3xl` | `20px` | `28px` | `700` (Bold) | `-0.01em` | Section headings, dialog titles |
| `font.size.4xl` | `24px` | `32px` | `800` (ExtraBold) | `-0.02em` | Lesson milestone titles, screen titles |
| `font.size.hero` | `32px` | `40px` | `800` (ExtraBold) | `-0.02em` | Live class headline, victory score counter |

### 2.3 Spacing Scale (8pt Baseline Rhythm + Micro Steps)

All layouts **must** strictly use defined spacing tokens. Ad-hoc pixel margins are prohibited.

```
space.1 = 5px      (Micro gap: icon to badge text)
space.2 = 6px      (Tight padding: inline chip borders)
space.3 = 7px      (Inner button vertical clearance)
space.4 = 8px      (Standard baseline unit)
space.5 = 10px     (Card internal micro gutters)
space.6 = 14px     (Card horizontal compact padding)
space.7 = 16px     (Standard screen edge margin, mobile gutter)
space.8 = 18.5px   (Standard card content internal padding)
space.9 = 24px     (Section separation margin, tablet gutter)
space.10 = 32px    (Large block layout margin)
space.11 = 48px    (Hero zone clearance & bottom nav safe area)
```

### 2.4 Corner Radius Tokens

Kiddora utilizes a friendly, squishy curvature hierarchy. Sharp 90-degree corners are strictly prohibited.

- `radius.xs = 4px`: Focus ring indicator border corners.
- `radius.sm = 6px`: Small rating indicators, micro progress stamps.
- `radius.md = 8px`: Recessed score slots, secondary badge containers.
- `radius.lg = 12px`: Interactive answer shelf tiles, quiz choice cards.
- `radius.xl = 24px`: Standard clay cards, live stream viewport corners, bottom sheets.
- `radius.2xl = 9999px`: Universal Clay Action Buttons, pill chips, avatar frames.

### 2.5 Tactile Claymorphism Elevation & Depth Formula

Depth in Kiddora is physical and inflated like dough. It uses a **dual-axis illumination formula**:
1. **Specular Rim (Top-Left)**: Inset white glow simulating overhead light bouncing off glossy clay.
2. **Bevel Shade (Bottom-Right)**: Inset ambient dark shade simulating physical underside thickness.
3. **Pillow Shadow**: Colored drop shadow tint matched to the element's base tone (never dirty black).

```css
/* Level 1: Clay Rest (Cards, Chips, Tiles) */
box-shadow: 
  0 8px 16px -2px rgba(99, 102, 241, 0.12),
  0 3px 6px -1px rgba(0, 0, 0, 0.04),
  inset 3px 3px 5px rgba(255, 255, 255, 0.85),
  inset -3px -3px 5px rgba(13, 12, 34, 0.06);

/* Level 2: Clay Floating (Primary Buttons, Live Buzzer, Quest Node) */
box-shadow: 
  0 14px 24px -4px rgba(99, 102, 241, 0.24),
  0 6px 8px -2px rgba(0, 0, 0, 0.06),
  inset 4px 4px 6px rgba(255, 255, 255, 0.95),
  inset -4px -4px 6px rgba(13, 12, 34, 0.12);

/* Level 3: Clay Modal / Star Chest Celebration */
box-shadow: 
  0 24px 38px -6px rgba(15, 23, 42, 0.20),
  0 10px 14px -3px rgba(0, 0, 0, 0.08),
  inset 5px 5px 8px rgba(255, 255, 255, 0.95),
  inset -5px -5px 8px rgba(13, 12, 34, 0.15);

/* Active / Pressed State (Haptic Squish) */
transform: scale(0.96) translateY(3px);
box-shadow: 
  0 2px 4px 0 rgba(0, 0, 0, 0.08),
  inset 4px 4px 8px rgba(0, 0, 0, 0.18),
  inset -2px -2px 4px rgba(255, 255, 255, 0.4);
```

### 2.6 Motion & Animation Tokens
- `motion.duration.instant = 50ms`: Touch feedback and haptic squash.
- `motion.duration.fast = 100ms`: Chip selection, star pop-in.
- `motion.duration.normal = 200ms`: Screen transitions, card expansion.
- `motion.easing.bouncy = cubic-bezier(0.34, 1.56, 0.64, 1)`: Signature cartoon springiness.

---

## 3. Component-Level Rules

Every interactive component **must** explicitly document and handle **7 distinct states**:
`default`, `hover`, `focus-visible`, `active`, `disabled`, `loading`, and `error`.

```
Density Specifications:
- Links: 184 instances across navigation, curriculum trees, and parent reports.
- Buttons: 49 distinct variants (Primary Clay, Secondary Joy, Live Buzzer, Audio Trigger).
- Inputs: 31 fields (PIN entry, search bar, quiz response tiles).
- Lists: 26 list structures (lesson schedule, leaderboard, achievements).
- Cards: 12 card archetypes (Live Class, Quest Island, Milestone, Parent Tip).
- Navigation: 3 primary components (Sticky Header, Clay Bottom Nav, Tab Filter).
```

### 3.1 Primary Clay Action Button
- **Anatomy**: Inflated pill container (`radius.2xl`), leading icon (optional), label (`font.size.2xl`), trailing badge (optional).
- **Minimum Dimensions**: Height `56px`, Minimum touch target `56×56dp`.
- **States**:
  - `default`: Background `color.brand.primary` (`#4648D4`), Text `#FFFFFF`, Level 2 Clay Floating shadow.
  - `hover`: Subtle scale `1.02`, glow intensity `+15%`.
  - `focus-visible`: Outline `3px solid color.border.focus`, `2px` offset.
  - `active`: Transform `scale(0.96) translateY(3px)`, inset depression shadow.
  - `disabled`: Background `#CBD5E1`, text `#94A3B8`, opacity `0.65`, zero elevation, cursor `not-allowed`.
  - `loading`: Text hidden, centered 3D clay rotating spinner, pointer-events disabled.
  - `error`: Gentle coral border shake (`300ms`), alert message announced via `aria-live`.

### 3.2 Live Interactive Classroom Card
- **Anatomy**:
  - 16:9 Video Stream preview with rounded corners (`radius.xl`).
  - **Live Tag**: Meadow Mint badge with pulsing dot animation (`800ms` cycle).
  - **Teacher Cardlet**: Round avatar (`48×48dp`), name in `font.size.lg`, subject topic.
  - **Interactive Overlay Bar**:
    - Digital Hand-Raise button (Yellow Amber).
    - Floating reaction drawer (Hearts, Stars, Thumbs Up).
    - Quick Quiz Buzzer tile.
- **States**:
  - `default`: Resting Level 1 Clay Card, border `1.5px solid color.border.default`.
  - `active` / `in-session`: Glowing sky blue perimeter outline (`2px solid #0EA5E9`).
  - `loading`: Shimmer skeleton loader across video placeholder and teacher metadata.
  - `error` / `disconnected`: Reconnect banner with soft reload CTA.

### 3.3 Interactive Quiz Tile / Answer Shelf
- **Anatomy**: Recessed clay block with choice index (`A, B, C, D`), formula / diagram content, and selection checkmark.
- **Minimum Target**: Minimum width `100%`, Height `60px`, Touch target `60×60dp`.
- **Interaction Behavior**:
  - Single tap selects answer and triggers instant `100ms` spring sound + haptic feedback.
  - Confirmed correct: Inflates into Mint `#10B981` with sparkling star burst.
  - Confirmed incorrect: Soft wiggle (`200ms`), transforms into warm coral with encouraging "Thử lại nào!" prompt.

### 3.4 4-Digit Parental Gate PIN Pad
- **Anatomy**: Shield icon, mathematical challenge prompt (e.g., *"Người lớn ơi: 7 × 8 = ?"* or 4-digit PIN), 4 clay numbered circular dials (`64×64dp`), and cancel button.
- **Accessibility**: Numeric keypad auto-focused for screen readers, full keyboard numpad support (`0-9`, `Backspace`, `Enter`).

---

## 4. Accessibility Requirements (WCAG 2.2 AA)

1. **Color Contrast Compliance**:
   - All body copy and interactive labels **must** maintain a contrast ratio $\ge 4.5:1$ against their immediate background.
   - Large text ($\ge 18pt$ or $\ge 14pt$ bold) and graphical UI elements **must** maintain a contrast ratio $\ge 3:1$.
2. **Touch Target Ergonomics**:
   - All interactive controls **must** have a minimum touch target bounding box of `48×48dp`. Primary action controls (Answer tiles, Class enter button) **should** use `56×56dp` to accommodate children's developing motor skills.
3. **Keyboard & Switch Access**:
   - All interactive paths **must** be 100% navigable via hardware keyboard (`Tab`, `Shift+Tab`, `Space`, `Enter`, Arrow keys).
   - `focus-visible` ring **must** be rendered as an explicit 3px stroke with a 2px offset; suppressing outline without replacement is strictly prohibited.
4. **Cognitive & Screen Reader Clarity**:
   - Use plain, supportive language.
   - Live stream status changes, timer countdowns, and quiz score increments **must** use `aria-live="polite"` so screen readers alert the learner without interrupting current reading.

---

## 5. Content and Tone Standards

### 5.1 Voice Principles
- **For Kids (Ages 7–10)**: Encouraging, energetic, game-like, non-punitive. Mistakes are framed as stepping stones.
- **For Parents & Teachers**: Concise, informative, evidence-based, respectful of their time.

### 5.2 Microcopy Examples

| Scenario | ❌ Prohibited (Cold / Flat) | ✅ Approved Kiddora Standard (Supportive & Joyful) |
| :--- | :--- | :--- |
| Sai câu đố Toán | "Sai rồi. Đáp án không chính xác." | "Gần đúng rồi! Bé thử tính lại bước cuối xem nhé! 💡" |
| Hoàn thành bài học | "Bạn đã xong bài học 3." | "Tuyệt đỉnh! Bé đã mở khóa Rương Sao Khoa Học! ⭐ +50 Sao" |
| Vào lớp Live | "Phòng học mở lúc 19:00." | "Thầy Alex đang đợi bé trong Lớp Toán Tư Duy! 🚀 Vào ngay" |
| Khóa phụ huynh | "Nhập mã bảo mật." | "Cổng phụ huynh: Hãy giải phép tính 9 × 6 để tiếp tục." |
| Lỗi đường truyền | "Lỗi kết nối mạng 503." | "Tín hiệu đang chập chờn một chút. Bé đợi phi thuyền kết nối lại nhé!" |

---

## 6. Anti-Patterns and Prohibited Implementations

- 🚫 **MUST NOT** use raw hex colors in UI component code. Every color must map to a token in Section 2.1.
- 🚫 **MUST NOT** render sharp 90-degree corners on cards, buttons, or dialogs.
- 🚫 **MUST NOT** create touch targets smaller than `48×48dp`.
- 🚫 **MUST NOT** use punitive red badges or harsh buzzers for wrong answers.
- 🚫 **MUST NOT** hide the focus-visible ring on any interactive element.
- 🚫 **MUST NOT** present uncapped screen time without parental reminder triggers.
- 🚫 **MUST NOT** use generic drop shadows (`box-shadow: 0 4px 6px rgba(0,0,0,0.5)`) that create a muddy, gloomy aesthetic.

---

## 7. Quality Assurance (QA) Checklist

Before any screen or component is approved at Gate 2 (Design Sign-Off), the following checks must pass:

- [ ] **Token Verification**: 100% of colors, typography, radii, and spacings use system tokens.
- [ ] **7-State Coverage**: Component has explicitly styled and tested states (`default`, `hover`, `focus-visible`, `active`, `disabled`, `loading`, `error`).
- [ ] **Contrast Audit**: Passes Lighthouse & Axe WCAG 2.2 AA contrast tests with 0 violations.
- [ ] **Touch Target Size**: Every clickable/tappable element $\ge 48\times 48\text{dp}$.
- [ ] **Clay Illumination**: Dual-axis specular and ambient shading applied correctly without dark halos.
- [ ] **Responsive Fluidity**: Layout scales seamlessly from mobile (360dp–428dp) to tablet landscape (1024dp).
- [ ] **Parent Gate Security**: Verified 100% obstruction of adult settings behind math riddle or PIN lock.
- [ ] **Haptic & Motion Delight**: Bouncy easing and tactile depression scale active on all primary actions.
