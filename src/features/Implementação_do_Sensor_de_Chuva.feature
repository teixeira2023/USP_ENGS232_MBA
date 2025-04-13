Feature: wiper mechanism
    In order to see clearly when it is raining
    As a driver
    I want the wiper mechanism to clear the windshield

    Background: test setup
        Given the knob is "off"
        And the rain sensor is "inactive"

    @scenario_1 @happy_path
    Scenario: Wipers are off - rain sensor detects rain
        Given the ignition is "on"
        And the knob is "off"
        And the rain sensor is "active"
        When the rain sensor detects "the rain"
        Then the wiper mechanism feature should be "active"
 

    @scenario_4 @happy_path
    Scenario: Wipers are on - rain sensor detects no rain
        Given the ignition is "on"
        And the rain sensor is "active"
        When the rain sensor detects "no rain"
        Then the wiper mechanism feature should be "inactive"