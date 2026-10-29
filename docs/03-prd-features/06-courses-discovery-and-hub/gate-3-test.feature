# Gate 3: Master Test Plan & BDD Gherkin Test Scenarios
# Feature: FEAT-06 — Courses Discovery Hub, Search & Filter Sheet (Domain 04)
# Project: Kiddora (Kids Learning & Live Classes)
# Author: Sub-Agent QA/QC Tester — "The Paranoid Inquisitor"
# Status: APPROVED FOR IMPLEMENTATION
# Date: 2026-10-29

@sprint5 @feat06 @courses_hub @visual_qa
Feature: Courses Discovery Hub, Search & Multi-Criteria Filter Sheet
  As a curious primary student or engaged parent,
  I want to browse popular courses, search by keywords, and filter by subject, age, and difficulty,
  To easily discover engaging lessons that match my learning interests and grade level.

  # =========================================================================
  # SCREEN 1: COURSES HUB & EXPLORE (04_courses_01_explore_and_categories.png)
  # =========================================================================
  @courses_hub @screen_04_01
  Scenario: Display Courses Hub with all header, search bar, chips, and popular cards
    Given the user navigates to the Courses tab on the bottom navigation
    Then the user should see the header greeting "Explore, Learn and Grow!"
    And the user should see the clay search bar with hint "Search courses, topics..." and filter icon button
    And the user should see the horizontal subject filter bar with chips: "All", "Science", "Math", "Language", "Arts"
    And the "All" chip should be active by default with primary indigo styling
    And the user should see the "Popular Courses" section header
    And the popular courses grid should display at least 4 tactile clay cards:
      | title                 | category | lessons | age      |
      | Amazing Animals       | Science  | 5       | Ages 7-10 |
      | Math Fun with Numbers | Math     | 8       | Ages 6-8  |
      | Space Exploration     | Science  | 6       | Ages 8-12 |
      | Creative Drawing      | Arts     | 4       | Ages 6-10 |
    And each card should display a 3D illustration, category badge, and rounded star rating

  @courses_hub @filter_by_subject
  Scenario: Filter course list when tapping on a subject chip
    Given the user is on the CoursesHubScreen with "All" selected
    When the user taps on the "Science" subject chip
    Then the "Science" chip should become highlighted with tactile bounce
    And the previous "All" chip should return to default surface style
    And the displayed courses should only contain subjects categorized under "Science"
    And "Math Fun with Numbers" should not be visible in the filtered results

  # =========================================================================
  # SCREEN 2: REAL-TIME COURSE SEARCH (04_courses_02_search_courses.png)
  # =========================================================================
  @courses_search @screen_04_02
  Scenario: Search courses with real-time query and display match results
    Given the user is on the CoursesHubScreen
    When the user enters "Space" into the search field
    Then the screen should transition to the CourseSearchScreen
    And the search result counter should display "Search Results (12)"
    And the result list should display tactile cards matching "Space"
    And each search result card should show:
      | element       | requirement                       |
      | Title         | "Space Exploration for Kids"     |
      | Subtitle      | "Learn about planets and rockets" |
      | Lessons badge | "6 Lessons • 45 mins"             |
      | Age badge     | "Ages 8-12"                       |
      | Arrow button  | Right arrow chevron with min 48dp |

  @courses_search @empty_state
  Scenario: Display friendly tactile empty state when query returns no match
    Given the user is on the CourseSearchScreen
    When the user types an unmatched keyword "xyz123456"
    Then the screen should display a friendly clay mascot illustration
    And the user should see the title "Không tìm thấy khóa học nào!"
    And the user should see the suggestion "Thử tìm kiếm với từ khóa khác như Toán, Khoa học nhé!"
    And the user should see a "Xóa tìm kiếm" tactile button

  # =========================================================================
  # SCREEN 3: FILTER BOTTOM SHEET (04_courses_03_filter_courses_sheet.png)
  # =========================================================================
  @courses_filter_sheet @screen_04_03
  Scenario: Open filter sheet, select multiple criteria, and apply
    Given the user is on the CoursesHubScreen
    When the user taps the filter icon button on the search bar
    Then the clay filter bottom sheet should slide up smoothly from the bottom
    And the user should see the title "Filter Courses" with a close "×" button (min 48×48dp)
    And the user should see 3 filter sections:
      | section   | options                                     |
      | Program   | Science, Math, Arts, Language, Coding       |
      | Age Group | Ages 6-8, Ages 9-10, Ages 11-12             |
      | Level     | Beginner, Intermediate, Advanced            |
    When the user selects "Science", "Ages 9-10", and "Beginner"
    And the user taps the "Apply Filters" primary button
    Then the bottom sheet should close
    And the courses list should update to display only courses matching all 3 criteria

  @courses_filter_sheet @clear_all
  Scenario: Reset all selected filters with Clear All button
    Given the filter sheet is open with "Science" and "Ages 6-8" selected
    When the user taps the "Clear All" secondary button
    Then all filter chips should reset to unselected state
    And the "Apply Filters" button should reflect default query

  # =========================================================================
  # SCREEN 4: ALL COURSES GRID VIEW (04_courses_04_all_courses_grid.png)
  # =========================================================================
  @all_courses_grid @screen_04_04
  Scenario: Display 2-column responsive grid view of all catalog courses
    Given the user taps "See All" on the popular courses section
    Then the user should see the AllCoursesGridScreen with a 2-column grid layout
    And each course card should have an aspect ratio of approximately 0.78
    And cards should not overflow vertically or horizontally on a 360×640dp viewport
    When the user scrolls down through the course grid
    Then scroll frame rate should maintain a smooth 60 FPS with RepaintBoundary optimization

  # =========================================================================
  # NON-FUNCTIONAL & VISUAL QA ERGONOMICS
  # =========================================================================
  @visual_qa @accessibility
  Scenario: Verify touch target ergonomics and text scale robustness
    Given the user device is configured with 1.5x font text scaling on a 360x640dp screen
    When any Courses screen is rendered
    Then all tap targets (chips, close button, arrows, search icon) must be >= 48x48dp
    And no RenderFlex overflow error must occur across any container or sheet
    And contrast ratio for course titles and badges must satisfy WCAG 2.2 AA (>= 4.5:1)
