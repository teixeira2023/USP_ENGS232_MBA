Feature: wiper mechanism
    In order to see clearly when it is raining
    As a driver
    I want the wiper mechanism to clear the windshield

    Background: test setup
        Given the knob is "off"
        And the rain sensor is "inactive"

    @1
    Scenario: Wipers are off - knob is turned to "on"
        Turn on the wipers when the knob is turned to on
        Given the ignition is "on"
        When the driver changes the knob position to "slow"
        Then the wiper mechanism feature should be "active"

    @2
    Scenario Outline: Wipers are on - knob is turned to "off"
        turn off the wipers when the knob is turned to off
        Given the ignition is "on"
        And the knob is "<knob>"
        When the driver changes the knob position to "off"
        Then the wiper mechanism feature should be "inactive"
        Examples:
            | knob   |
            | slow   |
            | medium |
            | fast   |

    @3
    Scenario Outline: Wipers are on - key is turned to "off"
        turn off the wipers when the key is turned to off
        Given the ignition is "on"
        And the knob is "<knob>"
        When the driver turns the ignition "off"
        Then the wiper mechanism feature should be "inactive"

        Examples:
            | knob   |
            | slow   |
            | medium |
            | fast   |


    @4
    Scenario Outline: Wiper speed is adjusted
        Adjust the wiper speed to the desired speed
        Given the ignition is "on"
        And the knob is "off"
        When the driver adjusts the wiper speed to "<speed>"
        Then the wiper speed should be "<speed>"

        Examples:
            | speed  |
            | slow   |
            | medium |
            | fast   |



