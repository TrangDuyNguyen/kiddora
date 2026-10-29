# Gate 3: Master Test Plan & BDD Gherkin Test Scenarios
# Feature: FEAT-07 — Course Detail & Lessons Curriculum (Domain 05)
# Project: Kiddora (Kids Learning & Live Classes)
# Author: Sub-Agent QA/QC Tester — "The Paranoid Inquisitor"
# Status: APPROVED FOR IMPLEMENTATION
# Date: 2026-10-29

@sprint5 @feat07 @course_detail @visual_qa
Feature: Course Detail Overview, 3-Tab Segment & Lessons Curriculum
  As a motivated kid learner or caring parent,
  I want to view complete course information, explore the detailed curriculum, and read parent reviews,
  To feel confident and excited before starting the learning journey.

  # =========================================================================
  # SCREEN 1: COURSE OVERVIEW & ABOUT (05_course_detail_01_overview_about.png)
  # =========================================================================
  @course_detail @screen_05_01
  Scenario: Display Course Detail Overview with Hero 3D banner and feature highlights
    Given the user taps on the course card "Amazing Animals" from Courses Hub
    Then the user should be navigated to the CourseDetailScreen
    And the top app bar should show a back icon button (>= 48×48dp) and a favorite bookmark button
    And the user should see the Hero 3D course illustration card
    And the user should see the course title "Amazing Animals"
    And the user should see the category chip "Science" with pink/mint accent
    And the user should see the rating badge "4.8" with 5 gold clay stars and review count "(320 reviews)"
    And the user should see the 4 tactile feature highlight circles:
      | icon            | label               |
      | video_cam       | Fun Videos          |
      | quiz_bubble     | Interactive Quizzes |
      | document_sheet  | Activity Sheets     |
      | badge_medal     | Earn Badges         |
    And the user should see the 3-segment clay tab bar: "Lessons", "About", "Reviews"
    And the user should see the sticky thumb-zone bottom button "Start Learning" in Primary Indigo

  @course_detail @switch_to_about_tab
  Scenario: Switch to About tab and read course description and learning objectives
    Given the user is on the CourseDetailScreen
    When the user taps on the "About" segment tab
    Then the tab switch animation should complete smoothly within 16ms
    And the content view should display:
      | section               | content requirement                                             |
      | Course Description    | Engaging overview of wildlife, animal habitats, and biology    |
      | What You Will Learn   | List of key takeaways (identifying animals, diet, environment) |
      | Recommended Age       | "Recommended for kids ages 7 to 10"                            |
      | Instructor / Coach    | Coach Sarah profile avatar with verified educator badge        |

  # =========================================================================
  # SCREEN 2: LESSONS CURRICULUM LIST (05_course_detail_02_curriculum_lessons.png)
  # =========================================================================
  @course_curriculum @screen_05_02
  Scenario: Display curriculum lesson list with numbered tiles and duration badges
    Given the user is on the CourseDetailScreen with "Lessons" tab active
    Then the user should see the total lessons indicator "5 Lessons • 1 hr 15 mins total"
    And the lessons list should contain:
      | index | title                     | duration | status    |
      | 01    | Meet the Animals          | 10 mins  | Unlocked  |
      | 02    | Animals & Their Habitats  | 15 mins  | Unlocked  |
      | 03    | What Animals Eat (Diet)   | 15 mins  | Locked    |
      | 04    | Animal Families & Babies  | 20 mins  | Locked    |
      | 05    | Amazing Animal Facts Quiz | 15 mins  | Locked    |
    And unlocked lesson tiles should show a tactile play icon and distinct highlight
    And locked lesson tiles should show a subtle clay lock icon
    And the user should see the bonus badge reward card "Complete all lessons to earn the Animal Friend Badge!"

  @course_curriculum @tap_unlocked_lesson
  Scenario: Tapping an unlocked lesson triggers learning action
    Given the user is viewing the Lessons tab on CourseDetailScreen
    When the user taps on lesson 1 "Meet the Animals"
    Then the app should trigger haptic feedback
    And the system should prepare the lesson player navigation

  @course_curriculum @tap_locked_lesson
  Scenario: Tapping a locked lesson shows helpful encouragement
    Given the user is viewing the Lessons tab on CourseDetailScreen
    When the user taps on locked lesson 3 "What Animals Eat (Diet)"
    Then the app should show a gentle toast or dialog: "Hoàn thành các bài trước để mở khóa bài này nhé!"
    And the lesson should remain locked without breaking navigation

  # =========================================================================
  # SCREEN 2 (TAB 3): PARENT REVIEWS TAB
  # =========================================================================
  @course_reviews @reviews_tab
  Scenario: Switch to Reviews tab and view community feedback
    Given the user is on the CourseDetailScreen
    When the user taps on the "Reviews" segment tab
    Then the view should display the average rating summary (4.8 / 5.0)
    And the user should see review cards with reviewer avatar, date, star rating, and text comments

  # =========================================================================
  # CTA & NON-FUNCTIONAL PERFORMANCE
  # =========================================================================
  @course_detail @sticky_cta
  Scenario: Sticky Start Learning CTA button remains accessible during scroll
    Given the user is on the CourseDetailScreen with long curriculum list
    When the user scrolls down to the bottom of the curriculum list
    Then the [Start Learning] button should remain pinned at the bottom thumb zone
    And the content list should have bottom padding to prevent the CTA from obscuring the last lesson
    And tapping [Start Learning] triggers haptic feedback and launches lesson 1
