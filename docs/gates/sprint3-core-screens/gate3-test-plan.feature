# Gate 3: Master Test Plan & BDD Gherkin Test Scenarios
# Feature: Sprint 3 — 3 Core Screens 1:1 Implementation
# Project: Kiddora (Kids Learning & Live Classes)
# Author: Sub-Agent QA/QC Tester — "The Paranoid Inquisitor"
# Status: APPROVED
# Date: 2026-10-22

@sprint3 @core_screens @visual_qa
Feature: Sprint 3 - 3 Core Screens Implementation (Login, Home Dashboard, Learning Goal)
  As a quality engineer,
  I want to thoroughly test the 3 core screens replicated 1:1 from the benchmark design,
  To ensure zero UI defects, flawless tactile interactions, and robust state updates.

  # =========================================================================
  # SCREEN 1: WELCOME BACK / LOGIN SCREEN
  # =========================================================================
  @login @screen1
  Scenario: Display Welcome Back screen with all visual elements
    Given the user is on the LoginScreen
    Then the user should see the back icon button
    And the user should see the Kiddora brand logo and tagline "Learn • Play • Achieve"
    And the user should see the title "Welcome Back!"
    And the user should see the subtitle "Let's continue your learning journey"
    And the user should see the 3D mascot boy waving with the smiling star
    And the user should see the email input field with a mail icon
    And the user should see the password input field with a lock icon and visibility toggle
    And the user should see the "Remember me" checkbox
    And the user should see the "Forgot Password?" button
    And the user should see the "Log In" primary tactile button
    And the user should see the social login buttons for Google, Apple, and Microsoft

  @login @password_toggle
  Scenario: Toggle password visibility
    Given the user enters "secretPass123" into the password field
    When the user taps the password visibility toggle icon
    Then the password text should be revealed in plain text
    When the user taps the password visibility toggle icon again
    Then the password text should be obscured

  @login @submission
  Scenario: Successful login navigation to Home Screen
    Given the user enters valid email "keil@kiddora.com" and password "Pass123!"
    When the user taps the "Log In" button
    Then the application should trigger haptic feedback
    And the user should be navigated to the HomeScreen

  # =========================================================================
  # SCREEN 2: STUDENT HOME / DASHBOARD SCREEN
  # =========================================================================
  @home @screen2
  Scenario: Display Student Home Dashboard with 1:1 layout elements
    Given the user is on the HomeScreen
    Then the user should see Keil's avatar and greeting "Hi, Keil!"
    And the user should see the subtitle "Great to see you again!"
    And the user should see the notification icon with badge "3"
    And the user should see the hero banner "Keep Learning Keep Growing!" with crown mascot
    And the user should see 4 quick stat cards: "My Progress", "Current Courses", "Upcoming Session", "My Badges"
    And the user should see the "Continue Learning" section with "Amazing Animals" course card
    And the user should see the "Upcoming Session" section with "Math Fun with Numbers" by Coach Sarah
    And the user should see the 5-item clay bottom navigation bar with "Home" selected

  @home @navigation_to_goal
  Scenario: Navigate to Today's Learning Goal screen from My Progress card
    Given the user is on the HomeScreen
    When the user taps the "My Progress" quick action card
    Then the user should be navigated to the TodayLearningGoalScreen

  # =========================================================================
  # SCREEN 3: TODAY'S LEARNING GOAL SCREEN
  # =========================================================================
  @goal @screen3
  Scenario: Display Today's Learning Goal with circular progress and task list
    Given the user is on the TodayLearningGoalScreen
    Then the user should see the title "Today's Learning Goal"
    And the user should see the subtitle "Small steps make big progress!"
    And the circular progress indicator should display "3 of 5" and "Tasks Completed"
    And the circular progress center should show the smiling 3D clay star
    And the task list should contain 5 tasks
    And tasks 1, 2, and 3 should display a green completed checkmark
    And tasks 4 and 5 should display an unchecked purple ring
    And the user should see the bottom motivation card "You can do it!" with thumbs-up mascot

  @goal @interactive_task_toggle
  Scenario: Dynamically update learning goal progress when tapping an incomplete task
    Given the user is on the TodayLearningGoalScreen
    And the current progress shows "3 of 5"
    When the user taps on task 4 "Read a story"
    Then task 4 checkbox should toggle to a green completed checkmark
    And the progress counter should dynamically update to "4 of 5"
    And haptic feedback should be triggered
