# Bản Đồ Lộ Trình Sản Phẩm Kiddora (Product Roadmap)

- **Quản lý bởi**: Sub-Agent Product Owner (PO) — *"The Strategic Tyrant"*
- **Nguồn gốc**: Phân tích toàn bộ **60 màn hình thiết kế** qua **14 Domain** tại `assets/design_references/screens/`
- **Phiên bản hiện tại**: `v0.4.0` ✅ Hoàn thành → **`v0.5.0`** 🔥 Đang thực hiện → `v1.0.0` 🎯 Supreme Release (Sprint 12)
- **Cập nhật lần cuối**: 2026-10-29 (re-baseline +1 sprint theo quyết định PO)
- **Tổng màn hình thiết kế**: 60 screens · **14 Domain** · **12 Sprint** (gồm Sprint 4 Auth E2E và Sprint 6 Learning Player)

---

## 🧭 Mô Hình Lộ Trình 3 Chân Trời (3-Horizon Framework)

```
+------------------------------------------------------------------------+
|  🟢 CHAN TROI 1: HISTORICAL (v0.1.0 - v0.4.0) - DA HOAN THANH        |
|  Sprint 1: Onboarding 3 Slides + AutoRoute + UI Kit Nen Tang (v0.1.0)  |
|  Sprint 2: Kid Profile v2 (Age Spinner, 12 Mascot Con Giap) (v0.2.0)   |
|  Sprint 3: Login + Student Home Dashboard + Today's Goals (v0.3.0)     |
|  Sprint 4: Fullstack E2E Auth, Onboarding & UI Kit v2 (v0.4.0)        |
+----------------------------------+-------------------------------------+
                                   |
                                   v
+------------------------------------------------------------------------+
|  🟡 CHAN TROI 2: NOW (v0.5.0 - v0.8.0) - SPRINT 5 -> 8               |
|  Sprint 5 (v0.5.0): Courses Hub · Search · Filter · Detail (6 man)    |
|  Sprint 6 (v0.6.0): Learning Player - 3 man hinh (demo noi dung)       |
|  Sprint 7 (v0.7.0): Live Interactive Classroom - 11 man hinh           |
|  Sprint 8 (v0.8.0): Tests & Quizzes Hub - 9 man hinh                  |
+----------------------------------+-------------------------------------+
                                   |
                                   v
+------------------------------------------------------------------------+
|  🟣 CHAN TROI 3: LATER (v0.9.0 - v1.0.0) - SPRINT 9 -> 12            |
|  Sprint 9  (v0.9.0): Gamification · Badges · Rewards · Streaks         |
|  Sprint 10 (v0.10.0): Chat Coach + Notifications Center               |
|  Sprint 11 (v0.11.0): Profile · Settings · Learning Journey           |
|  Sprint 12 (v1.0.0): Analytics · Parent Hub · App Store Release       |
+------------------------------------------------------------------------+
```

---

## 📊 Tổng Quan 14 Domain × 60 Màn Hình

| Domain | Tên | Số Màn Hình | Sprint | Phiên Bản | Trạng Thái |
|--------|-----|:-----------:|:------:|:---------:|:----------:|
| 01 | Onboarding (Welcome · Discover · Live Coaches) | 3 | S1 | v0.1.0 | ✅ Done |
| 02 | Auth & Onboarding E2E (Login · Register · Kid Profile Sync) | 1+1+1 | S1-S4 | v0.4.0 | ✅ Done |
| 03 | Home (Student Dashboard · Today's Goals · Logout Dialog) | 2 | S3-S4 | v0.4.0 | ✅ Done |
| 04 | Courses (Explore · Search · Filter · Grid) | 4 | S5 | v0.5.0 | 🔥 NOW |
| 05 | Course Detail (Overview · Curriculum) | 2 | S5 | v0.5.0 | 🔥 NOW |
| 06 | Learning (Lesson Player · Tracker · Celebration) | 3 | S6 | v0.6.0 | 🟡 NEXT |
| 07 | Live Classroom (11 màn hình đầy đủ) | 11 | S7 | v0.7.0 | 🟡 NEXT |
| 08 | Tests & Quizzes (9 màn hình đầy đủ) | 9 | S8 | v0.8.0 | 🟡 NEXT |
| 09 | Gamification (Badges · Rewards · Streak) | 8 | S9 | v0.9.0 | 🟣 LATER |
| 10 | Chat (Inbox · Coach Directory · DM) | 4 | S10 | v0.10.0 | 🟣 LATER |
| 11 | Notifications (Center · Reminder Detail) | 2 | S10 | v0.10.0 | 🟣 LATER |
| 12 | Profile (Stats · Edit · Learning Journey · Tabs) | 6 | S11 | v0.11.0 | 🟣 LATER |
| 13 | Settings (Preferences · Notifications · Help) | 3 | S11 | v0.11.0 | 🟣 LATER |
| 14 | Analytics (Monthly Progress · Test Analysis) | 2 | S12 | v1.0.0 | 🟣 LATER |
| **TOTAL** | | **60** | **12** | | |

---

## ✅ Chân Trời 1: Historical Releases (v0.1.0 – v0.4.0 + Hardening)

### `v0.1.0` — Sprint 1 · Onboarding & UI Kit Foundation (22 SP)
**Màn hình thực hiện**: `01_onboarding_01`, `01_onboarding_02`, `01_onboarding_03`
- Onboarding 3 slides tương tác: Welcome → Discover → Live Coaches
- Cấu trúc AutoRoute 9.x, OnboardingGuard kiểm tra lần đầu khởi chạy
- UI Kit nền tảng Tactile Claymorphism: `ClayCard`, `ClayButton`, `StarCounterBadge`
- ✅ Ký duyệt: `docs/gates/sprint1-onboarding/release-tag.txt`

### `v0.2.0` — Sprint 2 · Kid Profile Enhancement (5 SP)
**Màn hình thực hiện**: Kid Avatar Picker (Onboarding flow)
- Age Wheel Spinner 3D (6–12 tuổi), Quick Nickname Chips 1-tap
- 12 Mascot Con Giáp 3D, haptic squish 60 FPS
- ✅ Ký duyệt: `docs/gates/sprint2-profile-enhancement/release-tag.txt`

### `v0.3.0` — Sprint 3 · Core Screens (13 SP)
**Màn hình thực hiện**: `02_auth_01`, `03_home_01`, `03_home_02`
- Login Screen (nhớ mật khẩu, nút Indigo 3D)
- Student Home Dashboard (Keil, khóa học đang học, Live Class card)
- Today's Learning Goals (vòng tiến độ 3D, danh sách nhiệm vụ)
- ✅ Ký duyệt: `docs/gates/sprint3-core-screens/release-tag.txt`

### Hardening & Foundations (8 SP)
- `RegisterScreen` COPPA-compliant + kiểm soát độ mạnh mật khẩu
- `SplashScreen` đồng bộ Native Splash + route động
- Refactor: 0 magic numbers · 0 emojis in code · 100% `AppStrings`
- Ingest & phân loại 60 màn hình Dribbble benchmark qua 14 domains

### `v0.4.0` — Sprint 4 · Fullstack E2E Auth, Onboarding & User Sync (15 SP) + UI Kit v2 (CR-013, 26 SP)
- FastAPI + PostgreSQL + Alembic `0001`, Register/Login/Kid Profile nối API thật, Guest Mode
- Shared UI Kit v2: `ClayDialog`, `ClayFilterBar`, `ClayScreenHeader`, `ClayListTile`, `ClayBottomNav` 5 tab
- ✅ Ký duyệt: `docs/gates/sprint4-auth-onboarding/release-tag.txt` · Git tag `v0.4.0-auth-onboarding-e2e`

---

## 🔥 Chân Trời 2 — NOW: v0.5.0 (Sprint 5)

### `v0.5.0` — Sprint 5 · Courses Hub + Course Detail

> **PO Verdict**: Đây là bridge kinh tế sống còn. Nếu học sinh không tìm được khóa học thì app là mảnh giấy lộn. Nội dung bài học và asset ở mức **demo**; sản xuất nội dung thật là hạng mục lớn của các Sprint sau.

**Màn hình thực hiện** (6 screens): `04_*` · `05_*` — song ngữ Việt–Anh (CR-015)

#### EPIC-COURSE-01: Khám Phá & Lưới Khóa Học (Domain 04)

| Screen | Feature | Priority |
|--------|---------|---------|
| `04_courses_01_explore_and_categories` | Header + nút kính lúp, hero banner, 5 thẻ môn học, Popular Courses + See All | M |
| `04_courses_02_search_courses` | Màn tìm kiếm, kết quả dạng thẻ ngang, trạng thái rỗng | M |
| `04_courses_03_filter_courses_sheet` | Màn lọc 4 chiều: môn, tuổi, cấp độ, thời lượng; Clear All / Apply | S |
| `04_courses_04_all_courses_grid` | Lưới 2 cột 6 khóa học, nút tim yêu thích (cục bộ) | M |

#### EPIC-COURSE-02: Chi Tiết Khóa Học (Domain 05)

| Screen | Feature | Priority |
|--------|---------|---------|
| `05_course_detail_01_overview_about` | Ảnh bìa, 3 pill thông số, sao, About, 4 ô tính năng, nút Start Learning | M |
| `05_course_detail_02_curriculum_lessons` | 3 tab Lessons/About/Reviews, 5 bài học (demo), banner huy hiệu | M |

**Story Points cam kết**: 23 SP (PO chấp nhận rủi ro trễ, CR-016). Song ngữ chờ ADR-005, chưa nằm trong 23 SP.
**Thứ tự cắt nếu trễ**: nhóm lọc Duration, rồi màn Filter, rồi màn Search.
**Definition of Done**: 60 FPS · 0 overflow · 5 UI states · Gate 6 QA sign-off

---

## 🟡 Chân Trời 2 — NEXT: v0.6.0 (Sprint 6)

### `v0.6.0` — Sprint 6 · Learning Player (Domain 06)

> **PO Verdict**: Hoàn tất vòng lặp "tìm khóa học, vào học". Nội dung bài học vẫn ở mức demo; không phình thêm hệ thống authoring nội dung.

**Màn hình thực hiện** (3 screens): `06_learning_01` → `06_learning_03`

| Screen | Feature | Priority |
|--------|---------|---------|
| `06_learning_01_continue_lesson_player` | Thẻ tiến độ, nút Continue Lesson, xem trước bài tiếp theo | M |
| `06_learning_02_course_progress_tracker` | Tracker tiến độ module, trạng thái hoàn thành/đang học/khóa | S |
| `06_learning_03_course_completed_celebration` | Màn ăn mừng hoàn thành, huy hiệu, 2 nút lựa chọn | S |

**Story Points ước tính sơ bộ**: ~10 SP (PM xác nhận ở Sprint 6 Planning)
**Dung lượng còn lại dự kiến dùng cho**: bảng `user_progress` cá nhân hóa, di chuyển chuỗi cũ sang song ngữ theo ADR-005, và phần tràn từ Sprint 5.

---

## 🟡 Chân Trời 2 — NEXT: v0.7.0 (Sprint 7)

### `v0.7.0` — Sprint 7 · Live Interactive Classroom

> **PO Verdict**: Domain 07 là USP (Unique Selling Point) không thể copy dễ dàng. 11 màn hình = phức tạp nhất dự án. Đã được Tech Lead chuẩn hóa tại ADR-004 với LiveKit SFU WebRTC tự host. Không rush, không trade-off chất lượng stream.

**Màn hình thực hiện** (11 screens): `07_live_01` → `07_live_11`

| Screen | Feature | Priority | Ghi Chú |
|--------|---------|---------|---------|
| `07_live_02_sessions_hub_live_now` | Danh sách sessions đang live + sắp tới, join button | M | Entry point chính |
| `07_live_01_upcoming_session_card` | Card phiên học sắp diễn ra, countdown, coach info | M | |
| `07_live_03_upcoming_sessions_schedule` | Lịch các phiên sắp tới, filter theo môn | M | |
| `07_live_05_waiting_room_countdown` | Phòng chờ, countdown đếm ngược, avatar học sinh | M | |
| `07_live_06_classroom_stream_interactive` | **CORE**: Video stream Coach, hàng avatar HS, Chat/Q&A tabs, Mic/Camera/Leave/Share | M | Phức tạp nhất |
| `07_live_07_session_completed_summary` | Tóm tắt phiên học, điểm tham gia, badge | M | |
| `07_live_08_session_detail_agenda` | Chi tiết agenda phiên học, danh sách chủ đề | S | |
| `07_live_04_session_quick_card` | Quick action card từ Home | S | |
| `07_live_09_session_history` | Lịch sử các phiên đã tham gia | S | |
| `07_live_10_reschedule_session_modal` | Modal đổi lịch phiên học | C | |
| `07_live_11_cancel_session_dialog` | Dialog xác nhận huỷ phiên | C | |

**Story Points ước tính**: 34 SP
**Backend**: LiveKit Server (Self-hosted WebRTC SFU, đã chuẩn hóa tại ADR-004)
**SLAs**: Video latency < 300ms · Chat delivery < 100ms · 60 FPS UI layer

---

## 🟡 Chân Trời 2 — NEXT: v0.8.0 (Sprint 8)

### `v0.8.0` — Sprint 8 · Tests & Quizzes Hub

> **PO Verdict**: Luyện đề = lý do phụ huynh trả tiền. 9 màn hình bao trọn vẹn vòng đời một bài kiểm tra. Phải implement đủ, không cắt. Nhưng cũng không phình thêm AI grading hay essay ở sprint này.

**Màn hình thực hiện** (9 screens): `08_tests_01` → `08_tests_09`

| Screen | Feature | Priority |
|--------|---------|---------|
| `08_tests_01_practice_tests_hub` | Trung tâm luyện đề, thống kê tổng, quick start | M |
| `08_tests_02_test_categories` | Phân loại đề theo môn, độ khó | M |
| `08_tests_03_quiz_preview_card` | Preview bài thi: số câu, thời gian, level | M |
| `08_tests_04_start_test_instructions` | Hướng dẫn làm bài, luật thi, nút bắt đầu | M |
| `08_tests_05_taking_test_question` | Giao diện câu hỏi trắc nghiệm, timer, progress bar | M |
| `08_tests_06_in_progress_milestone` | Milestone giữa bài (đạt 50%), motivational pop-up | S |
| `08_tests_07_review_answers_before_submit` | Xem lại câu trả lời trước nộp bài | M |
| `08_tests_08_test_submitted_dialog` | Dialog xác nhận nộp bài thành công | M |
| `08_tests_09_test_result_and_score` | Kết quả: điểm số, bảng phân tích đúng/sai, chia sẻ | M |

**Story Points ước tính**: 26 SP

---

## 🟣 Chân Trời 3 — LATER: v0.9.0 (Sprint 9)

### `v0.9.0` — Sprint 9 · Gamification Engine

> **PO Verdict**: Badges + Streaks + Rewards là động lực giữ chân D7/D30. Rewards Collection với điểm đổi quà là differentiator thương mại. 8 màn hình, nhưng chú ý hệ thống điểm phải được architect sạch từ đầu.

**Màn hình thực hiện** (8 screens): `09_gamification_01` → `09_gamification_08`

| Screen | Feature | Priority |
|--------|---------|---------|
| `09_gamification_01_my_badges_overview` | Tổng quan huy hiệu đã đạt, progress next badge | M |
| `09_gamification_02_achievement_badges_showcase` | Showcase thành tích, badges collection | M |
| `09_gamification_03_course_badges_catalog` | Catalog huy hiệu theo khóa học | S |
| `09_gamification_04_badge_detail_sheet` | Chi tiết huy hiệu: điều kiện, mô tả | S |
| `09_gamification_05_badge_earned_celebration` | Màn ăn mừng đạt badge mới (animation 3D) | M |
| `09_gamification_06_brave_learner_badge_dialog` | Dialog đặc biệt badge Brave Learner | S |
| `09_gamification_07_rewards_collection` | **KEY**: My Points · Redeem Rewards (Digital·Physical·Special) | M |
| `09_gamification_08_learning_streak_counter` | Chuỗi ngày học liên tiếp, ngọn lửa Streak | M |

**Story Points ước tính**: 21 SP

---

## 🟣 Chân Trời 3 — LATER: v0.10.0 (Sprint 10)

### `v0.10.0` — Sprint 10 · Chat + Notifications

> **PO Verdict**: Chat Coach là safety net cho phụ huynh, xây trust. Notifications là retention tool. Cả 2 không thể thiếu cho commercial release. Implement đủ 6 màn hình, không scope creep thêm group chat hay voice note.

**Màn hình thực hiện** (6 screens): `10_chat_*` + `11_notifications_*`

| Screen | Feature | Priority |
|--------|---------|---------|
| `10_chat_01_messages_inbox` | Inbox tin nhắn, unread badge, search | M |
| `10_chat_02_coach_chat_directory` | Danh bạ coach, online status, search | M |
| `10_chat_03_direct_messaging_coach` | DM với coach, bubble chat, attachment | M |
| `10_chat_04_quick_notification_overlay` | Overlay thông báo nhanh khi trong app | S |
| `11_notifications_01_center_list` | Trung tâm thông báo: tất cả loại, read/unread | M |
| `11_notifications_02_session_reminder_detail` | Chi tiết reminder phiên học, deep link | S |

**Story Points ước tính**: 18 SP
**Backend**: FCM Direct HTTP v1 API + FastAPI WebSocket & Redis Pub/Sub (ADR-004)

---

## 🟣 Chân Trời 3 — LATER: v0.11.0 (Sprint 11)

### `v0.11.0` — Sprint 11 · Profile + Settings

> **PO Verdict**: Profile là gương soi tiến độ của học sinh — phụ huynh sẽ check hàng ngày. Settings phải đủ nhưng không rườm rà. 9 màn hình clean.

**Màn hình thực hiện** (9 screens): `12_profile_*` + `13_settings_*`

| Screen | Feature | Priority |
|--------|---------|---------|
| `12_profile_01_keil_adam_stats` | Stats overview: lessons, hours, badges, courses | M |
| `12_profile_02_user_profile_hitesh` | Profile card public view | S |
| `12_profile_03_edit_profile_form` | Form chỉnh sửa hồ sơ, avatar, nickname | M |
| `12_profile_04_learning_journey_hub` | Hub hành trình học tập tổng thể | M |
| `12_profile_05_my_sessions_tab` | Tab lịch sử phiên Live đã tham gia | M |
| `12_profile_06_my_tests_tab` | Tab lịch sử bài thi và điểm số | M |
| `13_settings_01_preferences_hub` | Hub cài đặt: ngôn ngữ, âm thanh, hiển thị | M |
| `13_settings_02_notification_toggles` | Toggle chi tiết từng loại thông báo | M |
| `13_settings_03_help_support_faq` | FAQ, liên hệ hỗ trợ, về ứng dụng | S |

**Story Points ước tính**: 23 SP

---

## 🟣 Chân Trời 3 — LATER: v1.0.0 (Sprint 12)

### `v1.0.0` — Sprint 12 · Analytics + Parent Hub + Supreme Release

> **PO Verdict**: Analytics tháng là KPI đẳng cấp, phụ huynh nhìn vào đây để quyết định renew. Parent Hub PIN-protected là bắt buộc cho COPPA. Sprint 10 = finish line thương mại. KHÔNG release nếu còn 1 bug S1/S2/S3 chưa đóng.

**Màn hình thực hiện** (2 screens core + Parent Hub): `14_analytics_*`

| Screen / Module | Feature | Priority |
|--------|---------|---------|
| `14_analytics_01_monthly_learning_progress` | My Progress: % tổng, Lessons/Hours/Badges/Courses, Course Progress bars | M |
| `14_analytics_02_test_progress_analysis` | Phân tích điểm thi theo thời gian, breakdown môn | M |
| **Parent Hub (PIN-protected)** | PIN riddle toán, giám sát thời gian màn hình, báo cáo tiến độ con | M |
| **App Store Optimization** | App Store (iOS) + Google Play (Android) metadata, screenshots, rating prompts | M |
| **Performance Hardening** | Cold start <= 1.8s · 60 FPS toàn bộ · 0 memory leak · Crashlytics | M |

**Story Points ước tính**: 29 SP

**Gate 7 Release Checklist** (PO không ký duyệt nếu thiếu bất kỳ mục nào):
- [ ] QA Gate 6 sign-off hoàn tất 100%
- [ ] 0 bug S1 (Blocker) · S2 (Critical) · S3 (Major)
- [ ] Security Audit Gate 6.5 pass (COPPA, Parent Gate, 0 data leak)
- [ ] Performance: Cold start <= 1.8s · UI >= 60 FPS · AI latency <= 2.5s
- [ ] App Store / Play Store metadata approved

---

## 📅 Timeline Tổng Quan (Sprint Order; ngày tháng chờ PM tính lại theo velocity đo được)

```
Sprint 1  ✅  v0.1.0   Onboarding + UI Kit
Sprint 2  ✅  v0.2.0   Kid Profile
Sprint 3  ✅  v0.3.0   Login · Home · Goals
Sprint 4  ✅  v0.4.0   Fullstack E2E Auth · Onboarding · UI Kit v2
Sprint 5  🔥  v0.5.0   Courses Hub + Course Detail (6 màn, song ngữ)
Sprint 6  🟡  v0.6.0   Learning Player (3 màn, demo)
Sprint 7  🟡  v0.7.0   Live Classroom
Sprint 8  🟡  v0.8.0   Tests & Quizzes
Sprint 9  🟣  v0.9.0   Gamification
Sprint 10 🟣  v0.10.0  Chat + Notifications
Sprint 11 🟣  v0.11.0  Profile + Settings
Sprint 12 🟣  v1.0.0   Analytics + Parent Hub + 🚀
```

> **Lưu ý của PM/SM**: mốc "Tháng 4/2027" cũ cho v1.0.0 **không còn đáng tin**. Roadmap cũ có 10 sprint; nay thành 12 (thêm Sprint 4 Auth và Sprint 6 Learning Player). Mốc ngày mới sẽ được tính sau khi có velocity Sprint 5.

---

## 🎯 OKRs Chiến Lược (Mục Tiêu Đo Lường)

| Objective | Key Result | Target |
|-----------|-----------|--------|
| Acquisition | Downloads tháng đầu phát hành | >= 10,000 |
| Activation | Học sinh hoàn thành bài học đầu tiên | >= 70% |
| Retention | D7 Retention sau onboarding | >= 40% |
| Retention | D30 Retention (streak >= 7 ngày) | >= 25% |
| Revenue | Parent renew sau tháng dùng thử | >= 30% |
| Quality | App Store Rating | >= 4.7 sao |
| Performance | Cold start time | <= 1.8s |
| Performance | UI Frame Rate | 60 FPS |

---

## 🚫 Won't-Have (Bị Loại Khỏi v1.0.0)

> PO tuyên bố: Các hạng mục sau **KHÔNG** có trong phạm vi v1.0.0. Mọi yêu cầu thêm vào sẽ bị reject thẳng thừng.

- Group video chat học sinh với nhau (không phải live class)
- AI-generated essay grading (chưa đủ dữ liệu training)
- Social feed / chia sẻ bài học lên mạng xã hội
- Marketplace giáo viên tự đăng khóa học
- Offline video download (Phase 2)
- ~~Multi-language UI (chỉ Tiếng Anh v1.0.0)~~ — **HỦY khỏi Won't-Have ngày 29/10/2026**: PO chốt song ngữ Việt–Anh từ Sprint 5 (CR-015, ADR-005)
- Web app version

---

*Cập nhật bởi Sub-Agent PO "The Strategic Tyrant" · Căn cứ theo 60 design screens · `assets/design_references/screens/` · 2026-10-22*
