# Kiddora Visual Benchmark & Design References

> **Source**: [Kiddora — Kids Learning & Live Classes Mobile App UI/UX Design on Dribbble](https://dribbble.com/shots/27746677-Kiddora-Kids-Learning-Live-Classes-Mobile-App-UI-UX-Design) by Hitesh Tapaniya.  
> **Benchmark Standard**: Tactile Claymorphism 3D UI × WCAG 2.2 AA Child-First Ergonomics.

Tài liệu này và thư mục tài nguyên này là **"Kim chỉ nam"** duy nhất cho toàn bộ triết lý thiết kế giao diện, tỷ lệ thành phần, bảng màu phân cấp, và trải nghiệm tương tác của ứng dụng di động **Kiddora**.

---

## 📂 1. Cấu Trúc Thư Mục Tài Nguyên (Directory Structure)

```
assets/design_references/
├── README.md                            # Tài liệu phân tích triết lý thiết kế & mục lục 60 màn hình
├── composites/                          # 20 bản vẽ gốc tổng hợp (Composite Shots 1448×1086, 3 phones/shot)
│   ├── 00_kiddora_onboarding_full_shot.png
│   ├── 49079682_cf4360f739645de5bb2012ba771687b5.png
│   ├── 49079683_c3b0db9faf72c12ddd60695dd7fc2ab1.png
│   └── ... (20 composite PNGs)
└── screens/                             # 60 màn hình di động độ phân giải cao đã được bóc tách riêng lẻ (406×950)
    ├── 01_onboarding_01_welcome.png
    ├── 01_onboarding_02_discover.png
    ├── 01_onboarding_03_live_coaches.png
    ├── 02_auth_01_welcome_back_login.png
    ├── 03_home_01_student_dashboard.png
    ├── ... (60 screens classified by domain)
    └── 14_analytics_02_test_progress_analysis.png
```

---

## 📱 2. Mục Lục Toàn Bộ 60 Màn Hình Đã Bóc Tách (Screen Catalog)

Mỗi màn hình được crop chính xác theo hệ tọa độ chuẩn Figma ($406 \times 950\text{ dp}$):
- **Phone 1 (Trái)**: `x: 82, y: 65, w: 406, h: 950`
- **Phone 2 (Giữa)**: `x: 520, y: 65, w: 406, h: 950`
- **Phone 3 (Phải)**: `x: 960, y: 65, w: 406, h: 950`

### 2.1. Domain 01: Onboarding & Giới Thiệu Thương Hiệu (Brand Introduction)
| Tên File Màn Hình | Tên Màn Hình & Tiêu Đề | Thành Phần Trực Quan Nổi Bật |
| :--- | :--- | :--- |
| [`01_onboarding_01_welcome.png`](./screens/01_onboarding_01_welcome.png) | Welcome & Brand Slogan (*"Fun Learning for a Brighter Tomorrow"*) | Logo Kiddora, Huy hiệu ngôi sao vàng, Linh vật bé trai đất sét vẫy tay, Thẻ đáy sứ bo tròn bo 24px, Nút tròn FAB chuyển tiếp (`->`). |
| [`01_onboarding_02_discover.png`](./screens/01_onboarding_02_discover.png) | Self-Paced Exploration (*"Discover & Learn"*) | Bé gái đất sét học laptop, Các khối môn học nổi 3D (Toán, Vẽ, STEM), 3 chip tính năng (Interactive Courses, Fun Activities, Track Progress). |
| [`01_onboarding_03_live_coaches.png`](./screens/01_onboarding_03_live_coaches.png) | Live Coaching (*"Learn with Live Coaches"*) | Khung lớp học trực tuyến, Avatar giáo viên có badge Video, 3 chip tính năng (Live Sessions, Ask Questions, Learn from Experts). |

### 2.2. Domain 02: Xác Thực & Bảo Mật (Authentication)
| Tên File Màn Hình | Tên Màn Hình & Tiêu Đề | Thành Phần Trực Quan Nổi Bật |
| :--- | :--- | :--- |
| [`02_auth_01_welcome_back_login.png`](./screens/02_auth_01_welcome_back_login.png) | Login Screen (*"Welcome Back!"*) | Header linh vật vẫy tay, Ô nhập Email/Username, Password đất sét bo cong, Checkbox "Remember me", Nút Đăng nhập Indigo 3D, Nút MXH (Google, Apple, Facebook). |

### 2.3. Domain 03: Màn Hình Chính & Mục Tiêu Học Tập (Home & Goals)
| Tên File Màn Hình | Tên Màn Hình & Tiêu Đề | Thành Phần Trực Quan Nổi Bật |
| :--- | :--- | :--- |
| [`03_home_01_student_dashboard.png`](./screens/03_home_01_student_dashboard.png) | Student Dashboard (*"Hi, Keil! Great to see you again!"*) | Banner chào đón vương miện đất sét, 3 thẻ tóm tắt nhanh (Tiến độ, Khóa học đang học, Buổi học sắp tới), Thẻ "Continue Learning" (Amazing Animals), Thẻ Live Class sắp bắt đầu với nút [Join], Bottom Nav đất sét. |
| [`03_home_02_todays_learning_goals.png`](./screens/03_home_02_todays_learning_goals.png) | Daily Goals (*"Today's Learning Goal"*) | Vòng tròn tiến độ 3D *"3 of 5 Tasks Completed"*, Danh sách nhiệm vụ gamified có checkbox (Xem bài giảng, Làm quiz, Vào live class, Đọc truyện, Kiếm 10 điểm), Banner động viên bé trai giơ ngón cái. |

### 2.4. Domain 04: Danh Mục Khóa Học & Tìm Kiếm (Courses & Discovery)
| Tên File Màn Hình | Tên Màn Hình & Tiêu Đề | Thành Phần Trực Quan Nổi Bật |
| :--- | :--- | :--- |
| [`04_courses_01_explore_and_categories.png`](./screens/04_courses_01_explore_and_categories.png) | Courses Hub (*"Explore, Learn and Grow!"*) | Thanh tìm kiếm bo tròn, Hàng chip môn học (All, Science, Math, Language, Arts), Lưới thẻ Popular Courses (Amazing Animals, Math Fun with Numbers, Space Exploration, Creative Drawing). |
| [`04_courses_02_search_courses.png`](./screens/04_courses_02_search_courses.png) | Search Results (*"Search Results (12)"*) | Ô tìm kiếm có từ khóa `"Space"`, Danh sách kết quả dạng thẻ nổi xúc giác với thông tin số bài học, độ tuổi và nút mũi tên chi tiết. |
| [`04_courses_03_filter_courses_sheet.png`](./screens/04_courses_03_filter_courses_sheet.png) | Filter Courses Bottom Sheet | Bộ lọc đa tiêu chí bằng chip đất sét: Ngành học (Program/Category), Độ tuổi (7–8, 9–10, 11–12), Cấp độ (Beginner, Intermediate, Advanced), Thời lượng bài học, Nút [Clear All] và [Apply Filters]. |
| [`04_courses_04_all_courses_grid.png`](./screens/04_courses_04_all_courses_grid.png) | All Courses Grid View | Lưới 2 cột hiển thị toàn bộ khóa học kèm hình minh họa 3D, phân loại môn học, số bài giảng và nhãn lứa tuổi (Ages 7–10, 8–12). |

### 2.5. Domain 05: Chi Tiết Khóa Học (Course Detail)
| Tên File Màn Hình | Tên Màn Hình & Tiêu Đề | Thành Phần Trực Quan Nổi Bật |
| :--- | :--- | :--- |
| [`05_course_detail_01_overview_about.png`](./screens/05_course_detail_01_overview_about.png) | Course Overview (*"Amazing Animals"*) | Banner khóa học, Đánh giá 4.8 sao (320 reviews), Đoạn mô tả sinh động, 4 icon tính năng nổi (Fun Videos, Interactive Quizzes, Activity Sheets, Earn Badges), Nút CTA lớn [Start Learning]. |
| [`05_course_detail_02_curriculum_lessons.png`](./screens/05_course_detail_02_curriculum_lessons.png) | Lessons Curriculum List | Bộ 3 tab (Lessons, About, Reviews), Danh sách từng bài học kèm thời lượng (Meet the Animals 10 min, Animals & Habitats 15 min, v.v.), Thẻ nhắc nhở huy hiệu đặc biệt. |

### 2.6. Domain 06: Trải Nghiệm Tự Học & Tiến Độ (Self-Paced Learning)
| Tên File Màn Hình | Tên Màn Hình & Tiêu Đề | Thành Phần Trực Quan Nổi Bật |
| :--- | :--- | :--- |
| [`06_learning_01_continue_lesson_player.png`](./screens/06_learning_01_continue_lesson_player.png) | Continue Lesson Player (*"Pick up where you left off"*) | Thẻ tiến độ khóa học hiện tại (60%), Nút CTA [Continue Lesson], Thẻ xem trước bài học tiếp theo (Birds Around Us), Lời động viên học tập. |
| [`06_learning_02_course_progress_tracker.png`](./screens/06_learning_02_course_progress_tracker.png) | Course Modules Progress Tracker | Thanh tiến độ dạng vạch chia nhỏ, Danh sách trạng thái từng module (Đã hoàn thành, Đang học, Bị khóa). |
| [`06_learning_03_course_completed_celebration.png`](./screens/06_learning_03_course_completed_celebration.png) | Course Completed Celebration (*"Well Done!"*) | Màn hình vinh danh hoàn thành khóa học, Huy hiệu động, Thống kê thành tích và 2 nút lựa chọn (Khóa học tiếp theo / Về trang chủ). |

### 2.7. Domain 07: Lớp Học Trực Tuyến Live Classes (Live Interactive Classes)
| Tên File Màn Hình | Tên Màn Hình & Tiêu Đề | Thành Phần Trực Quan Nổi Bật |
| :--- | :--- | :--- |
| [`07_live_01_upcoming_session_card.png`](./screens/07_live_01_upcoming_session_card.png) | Upcoming Live Class Card | Thẻ nổi bật buổi học sắp bắt đầu cùng Coach, Thông tin giờ học và đếm ngược. |
| [`07_live_02_sessions_hub_live_now.png`](./screens/07_live_02_sessions_hub_live_now.png) | Live Sessions Hub (*"Live Now"*) | Banner sự kiện trực tiếp đang diễn ra (Space Exploration for Kids), Bộ lọc lịch học. |
| [`07_live_03_upcoming_sessions_schedule.png`](./screens/07_live_03_upcoming_sessions_schedule.png) | Live Schedule & Calendar | Lịch trình các buổi live class theo ngày, tuần với avatar giáo viên và môn học. |
| [`07_live_04_session_quick_card.png`](./screens/07_live_04_session_quick_card.png) | Session Quick Access Card | Thẻ thẻ truy cập nhanh vào phòng học trực tuyến. |
| [`07_live_05_waiting_room_countdown.png`](./screens/07_live_05_waiting_room_countdown.png) | Waiting Room (*"Class starts in 05:28"*) | Đồng hồ đếm ngược phút:giây, Thẻ giáo viên Coach Sarah, Danh sách "What to expect?", Badge 12 bạn học đang chờ trong phòng. |
| [`07_live_06_classroom_stream_interactive.png`](./screens/07_live_06_classroom_stream_interactive.png) | Live Interactive Video Classroom | Thanh Live badge, Thời gian 00:15:24, Số người tham gia (812), Khung video giảng bài, Khung PIP giáo viên, Hàng avatar học sinh (You, Aarav, Priya), Tab Chat/Q&A/Participants, Luồng tin nhắn thời gian thực, Nút điều khiển Mic/Cam/Share/More. |
| [`07_live_07_session_completed_summary.png`](./screens/07_live_07_session_completed_summary.png) | Live Session Completion Summary | Chúc mừng hoàn thành, Thẻ thống kê (45 min tham gia, Hoàn thành lớp, Học được 5 điều mới), Trích dẫn truyền cảm hứng, Nút [Next Session] và [Back to Courses]. |
| [`07_live_08_session_detail_agenda.png`](./screens/07_live_08_session_detail_agenda.png) | Live Session Detail & Agenda | Chi tiết giáo trình buổi học trực tiếp, Mục tiêu bài giảng, Giáo viên hướng dẫn. |
| [`07_live_09_session_history.png`](./screens/07_live_09_session_history.png) | Live Session History | Lịch sử các buổi học đã tham gia (Completed), đã bỏ lỡ (Missed) theo tháng. |
| [`07_live_10_reschedule_session_modal.png`](./screens/07_live_10_reschedule_session_modal.png) | Reschedule Session Sheet | Giao diện đổi lịch học với bộ chọn ngày giờ đất sét tròn. |
| [`07_live_11_cancel_session_dialog.png`](./screens/07_live_11_cancel_session_dialog.png) | Cancel Session Confirmation Dialog | Hộp thoại xác nhận hủy buổi học với 2 nút quyết định rõ ràng. |

### 2.8. Domain 08: Kiểm Tra, Câu Hỏi & Đánh Giá (Tests & Quizzes)
| Tên File Màn Hình | Tên Màn Hình & Tiêu Đề | Thành Phần Trực Quan Nổi Bật |
| :--- | :--- | :--- |
| [`08_tests_01_practice_tests_hub.png`](./screens/08_tests_01_practice_tests_hub.png) | Practice Tests Hub | Trung tâm luyện đề: Thống kê số bài đã làm (12 Tests), Điểm cao nhất, Điểm trung bình (72%), Đề thi đề xuất. |
| [`08_tests_02_test_categories.png`](./screens/08_tests_02_test_categories.png) | Test Subject Categories | Lựa chọn môn học thi thử (Toán, Khoa học, Ngôn ngữ, Nghệ thuật) dạng thẻ 3D. |
| [`08_tests_03_quiz_preview_card.png`](./screens/08_tests_03_quiz_preview_card.png) | Quiz Preview Card | Thẻ xem trước nội dung bộ câu hỏi Amazing Animals Quiz. |
| [`08_tests_04_start_test_instructions.png`](./screens/08_tests_04_start_test_instructions.png) | Test Instructions (*"Start Your Test"*) | Thông tin đề thi: 10 câu hỏi, 10 phút, lứa tuổi 7–10, Các quy định làm bài trước khi bấm Bắt đầu. |
| [`08_tests_05_taking_test_question.png`](./screens/08_tests_05_taking_test_question.png) | Taking Test Question View | Giao diện trả lời câu hỏi 3/10: Nội dung câu hỏi chữ lớn, 4 ô đáp án đất sét nổi xúc giác với phản hồi chọn haptic. |
| [`08_tests_06_in_progress_milestone.png`](./screens/08_tests_06_in_progress_milestone.png) | Test Progress Milestone | Thẻ cổ vũ tiến độ làm bài thi khi bé hoàn thành phân nửa chặng đường. |
| [`08_tests_07_review_answers_before_submit.png`](./screens/08_tests_07_review_answers_before_submit.png) | Review Answers Screen | Bảng rà soát câu trả lời: Danh sách 10 câu, trạng thái đã chọn đáp án, cho phép chạm để sửa trước khi nộp. |
| [`08_tests_08_test_submitted_dialog.png`](./screens/08_tests_08_test_submitted_dialog.png) | Test Submitted Dialog | Hộp thoại chúc mừng đã nộp bài thi thành công. |
| [`08_tests_09_test_result_and_score.png`](./screens/08_tests_09_test_result_and_score.png) | Test Results & Score Card | Bảng điểm kết quả thi, Số câu đúng/sai, Thời gian hoàn thành, Nút Xem giải thích và Làm lại. |

### 2.9. Domain 09: Gamification, Huy Hiệu & Phần Thưởng (Badges & Rewards)
| Tên File Màn Hình | Tên Màn Hình & Tiêu Đề | Thành Phần Trực Quan Nổi Bật |
| :--- | :--- | :--- |
| [`09_gamification_01_my_badges_overview.png`](./screens/09_gamification_01_my_badges_overview.png) | My Badges Overview | Tổng quan bộ sưu tập huy hiệu của bé, Phân loại theo cấp bậc. |
| [`09_gamification_02_achievement_badges_showcase.png`](./screens/09_gamification_02_achievement_badges_showcase.png) | Achievement Badges Showcase | Tủ trưng bày cúp và danh hiệu đã đạt được trong quá trình học. |
| [`09_gamification_03_course_badges_catalog.png`](./screens/09_gamification_03_course_badges_catalog.png) | Course Badges 2×3 Grid | Lưới 6 huy hiệu đất sét nổi (Science Explorer, Math Master, Global Learner, Creative Mind, Animal Friend, Tech Beginner) với nhãn Completed / In Progress / Locked. |
| [`09_gamification_04_badge_detail_sheet.png`](./screens/09_gamification_04_badge_detail_sheet.png) | Badge Detail Sheet (*"Animal Friend"*) | Huy hiệu 3D lớn ở trung tâm, Lời tựa, Bảng 4 chỉ số (Khóa học, Ngày nhận, Độ hiếm: Common, Số bạn cùng đạt: 12,450+), 3 điều kiện nhận thưởng, Nút [Share Badge]. |
| [`09_gamification_05_badge_earned_celebration.png`](./screens/09_gamification_05_badge_earned_celebration.png) | New Badge Earned Celebration Dialog | Hộp thoại ăn mừng huy hiệu mới với pháo hoa ngôi sao, Cúp huy hiệu 3D, Trích dẫn ý nghĩa, Nút [View My Badges] và [Continue Learning]. |
| [`09_gamification_06_brave_learner_badge_dialog.png`](./screens/09_gamification_06_brave_learner_badge_dialog.png) | Brave Learner Badge Completion Dialog | Hộp thoại mở khóa danh hiệu Dũng Cảm Học Tập sau khi kết thúc khóa học. |
| [`09_gamification_07_rewards_collection.png`](./screens/09_gamification_07_rewards_collection.png) | Rewards Collection & Points | Kho đổi thưởng: Điểm tích lũy (1,250 Points), Đổi quà tặng, Vật phẩm kỹ thuật số. |
| [`09_gamification_08_learning_streak_counter.png`](./screens/09_gamification_08_learning_streak_counter.png) | Learning Streak Flame Counter | Ngọn lửa chuỗi ngày học liên tục (Streak Flame), Lịch tích điểm theo ngày. |

### 2.10. Domain 10: Trò Chuyện & Tương Tác Thầy Trò (Chat & Messaging)
| Tên File Màn Hình | Tên Màn Hình & Tiêu Đề | Thành Phần Trực Quan Nổi Bật |
| :--- | :--- | :--- |
| [`10_chat_01_messages_inbox.png`](./screens/10_chat_01_messages_inbox.png) | Messages Inbox | Hộp thư tin nhắn chung kết nối giữa bé, thầy cô và nhóm bạn học. |
| [`10_chat_02_coach_chat_directory.png`](./screens/10_chat_02_coach_chat_directory.png) | Coach Chat Directory | Danh bạ liên hệ thầy cô và bạn học trực tuyến với trạng thái Online. |
| [`10_chat_03_direct_messaging_coach.png`](./screens/10_chat_03_direct_messaging_coach.png) | Direct Messaging with Coach | Khung chat 1-1 với giáo viên (Ms. Sara Ahmed), Lời khuyên bài vở và hướng dẫn trực quan. |
| [`10_chat_04_quick_notification_overlay.png`](./screens/10_chat_04_quick_notification_overlay.png) | Chat Notification Toast Overlay | Banner thông báo nổi khi có tin nhắn hoặc lời nhắc mới từ lớp học. |

### 2.11. Domain 11: Trung Tâm Thông Báo (Notifications)
| Tên File Màn Hình | Tên Màn Hình & Tiêu Đề | Thành Phần Trực Quan Nổi Bật |
| :--- | :--- | :--- |
| [`11_notifications_01_center_list.png`](./screens/11_notifications_01_center_list.png) | Notifications Center List | Danh sách thông báo phân nhóm: Nhắc nhở lớp học sắp diễn ra, Khóa học mới, Huy hiệu đạt được, Tin nhắn giáo viên, Kết quả bài thi. |
| [`11_notifications_02_session_reminder_detail.png`](./screens/11_notifications_02_session_reminder_detail.png) | Session Reminder Detail | Chi tiết thông báo: Buổi học Live sắp bắt đầu trong 30 phút, Link vào phòng và tài liệu chuẩn bị. |

### 2.12. Domain 12: Hồ Sơ Trẻ Em & Lộ Trình (Student Profile & Journey)
| Tên File Màn Hình | Tên Màn Hình & Tiêu Đề | Thành Phần Trực Quan Nổi Bật |
| :--- | :--- | :--- |
| [`12_profile_01_keil_adam_stats.png`](./screens/12_profile_01_keil_adam_stats.png) | Student Profile (*"Keil Adam"*) | Avatar đất sét, Cấp độ Level 2, Điểm thưởng (43,250 Points), Chuỗi 12 ngày Streak, 8 Khóa học, 5 Huy hiệu, Lối vào Cổng Phụ huynh (Parent/Guardian) và Cài đặt. |
| [`12_profile_02_user_profile_hitesh.png`](./screens/12_profile_02_user_profile_hitesh.png) | User Profile Overview | Tổng quan tài khoản cá nhân, Danh hiệu Curious Learner. |
| [`12_profile_03_edit_profile_form.png`](./screens/12_profile_03_edit_profile_form.png) | Edit Profile Form | Biểu mẫu đổi Tên gọi, Đổi Linh vật 3D, Độ tuổi và Sở thích học tập. |
| [`12_profile_04_learning_journey_hub.png`](./screens/12_profile_04_learning_journey_hub.png) | Learning Journey Hub | Bản đồ hành trình học tập tổng hợp của bé từ lúc nhập học. |
| [`12_profile_05_my_sessions_tab.png`](./screens/12_profile_05_my_sessions_tab.png) | My Sessions Tab | Tab quản lý toàn bộ các buổi học Live (Sắp tới, Đã học, Đã hủy). |
| [`12_profile_06_my_tests_tab.png`](./screens/12_profile_06_my_tests_tab.png) | My Tests Tab | Tab thống kê toàn bộ các bài thi đã thực hiện và lịch sử điểm số. |

### 2.13. Domain 13: Cài Đặt & Hỗ Trợ (Settings & Support)
| Tên File Màn Hình | Tên Màn Hình & Tiêu Đề | Thành Phần Trực Quan Nổi Bật |
| :--- | :--- | :--- |
| [`13_settings_01_preferences_hub.png`](./screens/13_settings_01_preferences_hub.png) | Settings & Preferences Hub | Trung tâm thiết lập ứng dụng: Tài khoản, Âm thanh haptic, Chế độ màn hình, An toàn trẻ nhỏ. |
| [`13_settings_02_notification_toggles.png`](./screens/13_settings_02_notification_toggles.png) | Notification Settings Toggles | Các công tắc gạt đất sét nổi để bật/tắt thông báo lịch học, kết quả thi, tin nhắn. |
| [`13_settings_03_help_support_faq.png`](./screens/13_settings_03_help_support_faq.png) | Help & Support FAQ | Cổng trợ giúp, Các câu hỏi thường gặp cho cha mẹ và bé, Liên hệ giáo viên. |

### 2.14. Domain 14: Phân Tích & Tiến Bộ Học Tập (Insights & Analytics)
| Tên File Màn Hình | Tên Màn Hình & Tiêu Đề | Thành Phần Trực Quan Nổi Bật |
| :--- | :--- | :--- |
| [`14_analytics_01_monthly_learning_progress.png`](./screens/14_analytics_01_monthly_learning_progress.png) | Monthly Learning Progress | Vòng tròn phân tích tổng tiến độ học tập trong tháng (75%), Biểu đồ thời gian học. |
| [`14_analytics_02_test_progress_analysis.png`](./screens/14_analytics_02_test_progress_analysis.png) | Test Progress Performance Analysis | Biểu đồ năng lực theo từng môn học (Toán, Khoa học, Xã hội), Tỷ lệ câu hỏi trả lời chính xác. |

---

## 🎨 3. Triết Lý Thiết Kế Kiddora (Core Design Philosophy)

### 3.1. Tactile Claymorphism 3D — Trực Giác Xúc Giác Đất Sét
Trẻ em học tập hiệu quả nhất khi được tương tác với những sự vật có cảm giác chạm thực tế (chunky, soft, pressable). Kiddora loại bỏ hoàn toàn phong cách phẳng khô khan (flat design) và thay bằng ngôn ngữ **Tactile Claymorphism 3D**:
1. **Ánh sáng phản quang cạnh trên (Specular Highlight)**: `inset 3px 3px 5px rgba(255, 255, 255, 0.85)` mô phỏng viền đất sét sáng mịn.
2. **Bóng nén đáy dưới (Compression Shading)**: `inset -3px -3px 5px rgba(13, 12, 34, 0.06)` tạo độ khối dập nổi 3D.
3. **Phản hồi xúc giác cơ học (Haptic Squish)**: Khi chạm vào các nút hoặc thẻ, thành phần lún xuống `scale(0.96) translateY(3px)` kết hợp rung `HapticFeedback.lightImpact()`.

### 3.2. Hệ Màu Ngữ Nghĩa & Phân Cấp Môn Học (Color System)
- 🩵 **Primary Indigo (`#4648D4` / `#6366F1`)**: Môn Toán tư duy (*Mental Math*) + Các nút tương tác hành động chính (FAB, Tab điều hướng đang chọn). Tương phản đạt chuẩn WCAG AAA ($8.4:1$).
- 🌟 **Joyful Amber (`#F59E0B` / `#FBBF24`)**: Phần thưởng ngôi sao, Chuỗi ngày học (Streak Flame), Huy hiệu, Nút bấm chuông Quiz (Buzzer).
- 🍓 **STEM Pink (`#EC4899`)**: Môn Khoa học & Thí nghiệm (*STEM Explorers*), Khám phá sáng tạo, Mục yêu thích.
- 🥑 **Meadow Mint (`#10B981`)**: Trạng thái thành công, Bài học hoàn thành, Đáp án đúng, Chỉ báo lớp học trực tiếp đang phát sóng (Live Stream Active).
- ☁️ **Sky Blue (`#0EA5E9`)**: Nhãn thông tin, Số lượng học sinh đang online, Thẻ thời lượng bài học.
- 🥛 **Porcelain Canvas (`#FCF8FF` / `#F8FAFC`)**: Nền màu sứ ấm áp dịu mắt, thẻ nổi đất sét trắng tinh khôi `#FFFFFF`.

### 3.3. Công Thái Học Cho Trẻ Nhỏ 7–10 Tuổi (Ergonomics & Accessibility)
- **Kích thước vùng chạm (Touch Targets)**: Tối thiểu **$48 \times 48\text{ dp}$** (khuyến nghị **$56 \times 56\text{ dp}$** cho các hành động chính) để tay trẻ nhỏ không chạm nhầm.
- **Typography Thân Thiện**: Quicksand / Mona Sans dạng hình học bo tròn (rounded geometric), trọng lượng chữ đậm ExtraBold 700–800, khoảng cách dòng thoáng (1.4–1.5).
- **Tuyệt Đối Không Magic Numbers**: $100\%$ kích thước, padding, radius, font size phải lấy từ `AppValues`.
- **Tuyệt Đối Không Raw Colors & Raw Strings**: Màu lấy từ `AppColors`, toàn bộ chuỗi văn bản lấy từ `AppStrings`.
- **Tuyệt Đối Không Emoji**: Sử dụng icon vector chuẩn (`IconData`) và asset đất sét 3D chuyên biệt.
