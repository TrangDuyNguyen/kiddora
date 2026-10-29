# Gate 3: Master Test Plan & BDD Gherkin Test Scenarios (Tech Lead Approved)
# Feature: FEAT-07 — Course Detail Overview & Lessons Curriculum (Domain 05)
# Project: Kiddora (Kids Learning & Live Classes)
# Author: Sub-Agent QA/QC Tester & Verified by Sub-Agent Tech Lead
# Status: APPROVED FOR IMPLEMENTATION
# Date: 2026-10-29

@sprint5 @feat07 @course_detail @visual_qa
Feature: Course Detail Overview & 3-Tab Lessons Curriculum (1:1 Benchmark)
  As a motivated kid learner or caring parent,
  I want to view the course overview with 4 feature highlights and explore the 5-lesson curriculum,
  To feel confident and excited before starting the learning journey.

  # =========================================================================
  # SCREEN 1: COURSE OVERVIEW & ABOUT (05_course_detail_01_overview_about.png)
  # =========================================================================
  @course_detail @screen_05_01
  Scenario: Display Course Detail Overview with Hero 3D dinosaur, 3 metadata pills, 4 feature icons, and Start Learning CTA
    Given the user taps on the course card "Amazing Animals" from Courses Hub
    Then the user should be navigated to the CourseDetailScreen
    And the top area should show the 3D dinosaur illustration with a floating circular back button and favorite heart button
    And the white rounded bottom sheet body should display the title "Amazing Animals"
    And the user should see the subtitle "Discover the wonderful world of animals and their habitats!"
    And the user should see 3 metadata pills: "Science", "Ages 7–10", "5 Lessons"
    And the user should see the star rating "4.8" and "(320 reviews)"
    And the user should see the section header "About This Course" and description paragraph
    And the user should see 4 feature highlight cards: "Fun Videos", "Interactive Quizzes", "Activity Sheets", "Earn Badges"
    And the user should see the primary bottom button "Start Learning"

  # =========================================================================
  # SCREEN 2: LESSONS CURRICULUM LIST (05_course_detail_02_curriculum_lessons.png)
  # =========================================================================
  @course_curriculum @screen_05_02
  Scenario: Navigate to Curriculum view and display 3-segment tabs, 5 numbered lessons, and special badge banner
    Given the user is on the CourseDetailScreen for "Amazing Animals"
    When the user taps the "Start Learning" button
    Then the user should see the compact header with thumbnail, title "Amazing Animals", and subtitle "5 Lessons • Science"
    And the user should see the 3-segment clay tab bar: "Lessons", "About", "Reviews" with "Lessons" active
    And the lessons list should display 5 tactile lesson cards:
      | index | title                      | duration | status    |
      | 1     | Meet the Animals           | 10 min   | Completed |
      | 2     | Animals and Their Habitats | 12 min   | Unlocked  |
      | 3     | Food and Eating Habits     | 10 min   | Locked    |
      | 4     | Animal Life Cycles         | 15 min   | Locked    |
      | 5     | How We Can Help            | 10 min   | Locked    |
    And lesson 1 should show a green circular checkmark badge
    And lesson 2 should show a purple circular chevron badge ">"
    And lessons 3, 4, and 5 should show a grey circular lock icon
    And at the bottom of the list the user should see the golden trophy reward banner "Complete all lessons to earn a special badge!"

  @course_curriculum @switch_tabs
  Scenario: Switch between Lessons, About, and Reviews tabs smoothly
    Given the user is on the Curriculum view with "Lessons" tab active
    When the user taps on the "About" tab
    Then the view should display the course description and learning takeaways
    When the user taps on the "Reviews" tab
    Then the view should display the rating summary "4.8" and parent review cards

  @course_curriculum @tap_locked_lesson
  Scenario: Tapping a locked lesson shows gentle encouragement
    Given the user is viewing the Lessons tab
    When the user taps on locked lesson 3 "Food and Eating Habits"
    Then the app should show a friendly message "Con hãy hoàn thành các bài học trước để mở khóa bài này nhé!"

  @course_curriculum @tap_unlocked_lesson_demo
  Scenario: Tapping an unlocked lesson shows demo notice (lesson player is out of scope)
    Given the user is viewing the Lessons tab
    When the user taps on unlocked lesson 2 "Animals and Their Habitats"
    Then haptic feedback should be triggered
    And the app should show the demo notice "Bài học này đang ở chế độ xem thử. Nội dung đầy đủ sẽ sớm ra mắt!"
    And no video player should open

  @visual_qa @placeholder_assets
  Scenario: Illustrations may be placeholders but layout must match benchmark
    Given course and lesson thumbnails use placeholder assets
    Then layout, spacing, labels and states must match the benchmark
    And a different illustration must not be counted as a visual defect
