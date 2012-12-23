Feature: Fontification of YARD comments

  Background:
    Given I view a ruby file with yard-mode enabled
    When I go to beginning of buffer

  Scenario: YARD tags are fontified
    When I place the cursor before "@see"
    Then the face should be "yard-tag-face"

    When I place the cursor before "@param"
    Then the face should be "yard-tag-face"

    When I place the cursor before "@return"
    Then the face should be "yard-tag-face"

  Scenario: YARD directives are fontified
    When I place the cursor before "@!group"
    Then the face should be "yard-directive-face"

    When I place the cursor before "@!endgroup"
    Then the face should be "yard-directive-face"

  Scenario: YARD Type Specifiers are fontified
    When I place the cursor before "String"
    Then the face should be "yard-types-face"

  Scenario: YARD variable names are fontified when relevant
    When I place the cursor after "@return [Boolean, Array] "
    Then the face should be "font-lock-comment-face"
    When I place the cursor after "@param [String] "
    Then the face should be "yard-name-face"

  Scenario: ivars are not broken
    When I place the cursor before "@version"
    Then the face should be "font-lock-variable-name-face"
