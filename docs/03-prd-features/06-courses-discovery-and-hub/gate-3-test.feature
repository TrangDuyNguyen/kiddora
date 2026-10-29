# Gate 3: Master Test Plan & BDD Gherkin Test Scenarios (Tech Lead Approved)
# Feature: FEAT-06 — Courses Discovery Hub, Search & Filter Sheet (Domain 04)
# Project: Kiddora (Kids Learning & Live Classes)
# Author: Sub-Agent QA/QC Tester & Verified by Sub-Agent Tech Lead
# Status: APPROVED FOR IMPLEMENTATION
# Date: 2026-10-29

@sprint5 @feat06 @courses_hub @visual_qa
Feature: Courses Discovery Hub, Search & Multi-Criteria Filter (1:1 Benchmark)
  As a curious primary student or engaged parent,
  I want to browse popular courses, search by keywords, and filter by 4 criteria (category, age, level, duration),
  To easily discover engaging lessons that match my learning interests and grade level.

  # =========================================================================
  # SCREEN 1: COURSES HUB & EXPLORE (04_courses_01_explore_and_categories.png)
  # =========================================================================
  @courses_hub @screen_04_01
  Scenario: Display Courses Hub with header, circular search button, hero banner, vertical category cards, and popular grid
    Given the user switches to the "Courses" tab on the bottom navigation bar
    Then the user should see the title "Courses" and subtitle "Explore, Learn and Grow!"
    And the user should see the circular search icon button (>= 48×48dp) on the top right
    And the user should see the purple hero banner "A Brighter Future Starts Here!" with the waving mascot boy and star
    And the user should see 5 vertical category icon cards: "All", "Science", "Math", "Language", "Arts"
    And the "All" category card should be active by default with primary indigo styling
    And the user should see the "Popular Courses" section header with a "See All" button
    And the popular courses 2-column grid should display 4 tactile clay cards:
      | title                 | category          | lessons   | age       |
      | Amazing Animals       | Science           | 5 Lessons | Ages 7–10 |
      | Space Exploration     | Science           | 5 Lessons | Ages 8–12 |
      | Math Fun with Numbers | Mathematics       | 5 Lessons | Ages 7–10 |
      | Creative Drawing      | Arts & Creativity | 5 Lessons | Ages 7–12 |
    And each card should display a 3D illustration and a circular purple chevron button ">"

  @courses_hub @filter_by_subject
  Scenario: Filter course list when tapping on a category card
    Given the user is on the Courses Hub tab with "All" selected
    When the user taps on the "Science" category card
    Then the "Science" card should become highlighted with tactile bounce
    And the displayed courses should only contain subjects categorized under "Science"
    And "Math Fun with Numbers" should not be visible in the filtered results

  # =========================================================================
  # SCREEN 2: REAL-TIME COURSE SEARCH (04_courses_02_search_courses.png)
  # =========================================================================
  @courses_search @screen_04_02
  Scenario: Search courses with real-time query and display horizontal result cards
    Given the user taps the circular search icon button on the Courses Hub
    Then the user should navigate to the CourseSearchScreen
    And the user should see the title "Search Courses" and subtitle "Find the perfect course for you!"
    When the user enters "Space" into the search field
    Then the search result header should display "Search Results" with match count
    And each horizontal search result card should display a left 3D thumbnail, title, category, lessons count, age range, and right chevron ">"

  @courses_search @empty_state
  Scenario: Display friendly tactile empty state when query returns no match
    Given the user is on the CourseSearchScreen
    When the user types an unmatched keyword "xyz123456"
    Then the user should see the title "Không tìm thấy khóa học nào!"
    And the user should see the suggestion "Thử tìm kiếm với từ khóa khác như Toán, Khoa học nhé!"
    And the user should see a "Xóa tìm kiếm" tactile button

  # =========================================================================
  # SCREEN 3: FILTER COURSES SCREEN / SHEET (04_courses_03_filter_courses_sheet.png)
  # =========================================================================
  @courses_filter @screen_04_03
  Scenario: Open Filter Courses view, select across all 4 filter dimensions, and apply
    Given the user opens the Filter Courses view
    Then the user should see the header "Filter Courses" with a back button and a "Clear All" button
    And the user should see 4 filter sections:
      | section            | options                                                                             |
      | Program / Category | All, Science, Mathematics, Language, Arts & Creativity, Technology, Life Skills     |
      | Age Group          | All, 7 – 8, 9 – 10, 11 – 12                                                         |
      | Difficulty Level   | All, Beginner, Intermediate, Advanced                                               |
      | Course Duration    | All, Short (1–3 lessons), Medium (4–6 lessons), Long (7+ lessons)                   |
    When the user selects "Science", "7 – 8", "Beginner", and "Medium (4–6 lessons)"
    And the user taps the "Apply Filters" primary button
    Then the filter view should close and apply the selected filter criteria to the course list

  @courses_filter @clear_all
  Scenario: Reset all 4 filter dimensions with Clear All button
    Given the Filter Courses view is open with non-default selections
    When the user taps the "Clear All" button
    Then all 4 filter sections should reset to "All"

  # =========================================================================
  # SCREEN 4: ALL COURSES GRID VIEW (04_courses_04_all_courses_grid.png)
  # =========================================================================
  @all_courses_grid @screen_04_04
  Scenario: Display 2-column All Courses Grid with favorite heart buttons
    Given the user taps "See All" on the Popular Courses section
    Then the user should see the AllCoursesGridScreen with title "All Courses" and subtitle "Explore and find your favorite courses!"
    And the user should see horizontal category filter pills ("All", "Science", "Math", "Arts")
    And the 2-column grid should display all 6 catalog courses ("Amazing Animals", "Space Exploration", "Math Fun with Numbers", "Creative Drawing", "Our Planet", "Intro to Technology")
    And each course card should feature a top-right circular favorite heart button

  # =========================================================================
  # NON-FUNCTIONAL & VISUAL QA ERGONOMICS
  # =========================================================================
  @visual_qa @accessibility
  Scenario: Verify touch target ergonomics and text scale robustness
    Given the user device is configured with 1.5x font text scaling on a 360x640dp screen
    When any Courses screen is rendered
    Then all interactive targets must be >= 48x48dp
    And no RenderFlex overflow error must occur across any container or card
