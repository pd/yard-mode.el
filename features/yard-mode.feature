Feature: Fontification of YARD comments

  Background:
    Given I view a ruby file with yard-mode enabled
    When I go to beginning of buffer

  Scenario: YARD tags are fontified
    When I place the cursor before "@see"
    Then the face should be "font-lock-doc-face"

    When I place the cursor before "@param"
    Then the face should be "font-lock-doc-face"

    When I place the cursor before "@return"
    Then the face should be "font-lock-doc-face"

  Scenario: ivars are not broken
    When I place the cursor before "@version"
    Then the face should be "font-lock-variable-name-face"
