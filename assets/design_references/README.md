# Kiddora Visual Benchmark & Design References

> Source: [Kiddora - Kids Learning & Live Classes Mobile App UI/UX Design on Dribbble](https://dribbble.com/shots/27746677-Kiddora-Kids-Learning-Live-Classes-Mobile-App-UI-UX-Design) by Hitesh Tapaniya.

These high-resolution assets serve as the visual benchmark ("Kim chỉ nam") for Kiddora's UI/UX, 3D clay illustrations, and layout hierarchy.

## Assets in this Directory

| File | Description | Visual Archetype & Key Tokens |
| :--- | :--- | :--- |
| [`kiddora_full_shot.png`](./kiddora_full_shot.png) | Full 1448×1086 3-screen composite shot | Complete Onboarding & Value Proposition Flow |
| [`kiddora_onboarding_1_welcome.png`](./kiddora_onboarding_1_welcome.png) | Screen 1: Welcome & Motivation | Brand Logo, Joyful Star badge, Clay Boy character, Bottom Clay Card |
| [`kiddora_onboarding_2_discover.png`](./kiddora_onboarding_2_discover.png) | Screen 2: Self-paced Exploration | Floating subject clay tiles (Math/Art/STEM), Clay Girl with laptop |
| [`kiddora_onboarding_3_live_coaches.png`](./kiddora_onboarding_3_live_coaches.png) | Screen 3: Live Classroom Experience | Classroom viewport, Live Coach avatar, Video badge, Feature chips |

## Visual Architecture Extraction

### 1. Typography & Hierarchy
- **Header Font**: Rounded geometric sans (Quicksand / Mona Sans). ExtraBold 700-800 with tight letter-spacing.
- **Color Accent in Text**: Selective single-word color highlights (e.g. *"Learn with **Live** Coaches"* in Sky Blue `#0EA5E9`).
- **Body & Captions**: Slate Neutral `#6E6D7A`, line height 1.4-1.5 for effortless child legibility.

### 2. Clay Card Architecture
- **White Porcelain Surface**: Pure white `#FFFFFF` card with `radius.xl = 24px` resting on Warm Porcelain background `#FCF8FF`.
- **Dual-layer Tactile Depth**: Specular white top rim and soft violet/indigo drop shadow (`rgba(99, 102, 241, 0.12)`).
- **Navigation Cluster**:
  - 3-step pill pagination (active: Playful Indigo pill `#6366F1`, inactive: soft pastel circles).
  - Floating Action Button: Circular `56×56dp` pill button with right arrow icon (`->`), elevated with Level 2 floating shadow.

### 3. Feature Proposition Chips (3-Column Grid)
- Circle clay icon badge (`48×48dp`) with pastel background container.
- Two-line concise microcopy below each badge.
- Color mappings:
  - 🎓 Purple/Indigo `#6366F1`: "Interactive Courses"
  - 🎮 Coral/Pink `#EC4899`: "Fun Activities" / "Ask Questions"
  - 📊 Mint `#10B981`: "Track Your Progress"
  - 👥 Sky Blue `#0EA5E9`: "Live Sessions"
  - ⭐ Amber `#F59E0B`: "Learn from Experts"
