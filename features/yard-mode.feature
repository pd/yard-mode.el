Feature: yard-mode

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
    When I place the cursor after "@param ["
    Then the face should be "yard-types-face"
    When I place the cursor after "@param library ["
    Then the face should be "yard-types-face"
    When I place the cursor after "@yieldparam version ["
    Then the face should be "yard-types-face"
    When I place the cursor after "@option options ["
    Then the face should be "yard-types-face"

  Scenario: YARD variable names are fontified when relevant
    When I place the cursor after "@return [Boolean, Array] "
    Then the face should be "font-lock-comment-face"
    When I place the cursor after "@param [String] "
    Then the face should be "yard-name-face"
    When I place the cursor after "@param [String] version"
    Then the face should be "yard-name-face"
    When I place the cursor after "@param [String] version_"
    Then the face should be "yard-name-face"
    When I place the cursor after "@yieldparam "
    Then the face should be "yard-name-face"
    When I place the cursor after "@option "
    Then the face should be "yard-name-face"

  Scenario: YARD option names are fontified when relevant
    When I place the cursor after "@option options [String] "
    Then the face should be "yard-option-face"

  Scenario: ivars are not broken
    When I place the cursor before "@version"
    Then the face should be "font-lock-variable-name-face"

  Scenario: eldoc support
    When I enable eldoc-mode
    And I place the cursor after "@see"
    Then eldoc should be showing "@see name description"
    When I place the cursor after "@!group"
    Then eldoc should be showing "@!group description"
