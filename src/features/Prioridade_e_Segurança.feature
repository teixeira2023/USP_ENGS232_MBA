
Feature: wiper mechanism
    In order to see clearly when it is raining
    As a driver
    I want the wiper mechanism to clear the windshield

    @1
    Scenario: knob has priority over rain sensor
        Given the ignition is "on"
        And the knob is "off"
        And the rain sensor is "inactive"
        When the driver changes the knob position to "slow"
        Then the wiper mechanism feature should be "active"
        And the error DTC code should be "no_error"
        And the wiper speed should be "slow"
    @2
    Scenario: Wipers are off - knob is turned to "off"
        Given the ignition is "off"
        And the knob is "off"
        When the driver changes the knob position to "slow"
        Then the wiper mechanism feature should be "inactive"
    @3
    Scenario: Wipers are off - rain sensor detects no rain
        Given the ignition is "off"
        And the rain sensor is "inactive"
        When the rain sensor detects "the rain"
        Then the wiper mechanism feature should be "inactive"

    @4
    Scenario Outline: testing preconditions
        Given the ignition is "<key_position>"
        And the knob is "<knob_position>"
        And the rain sensor is "<rain_sensor_status>"
        And the weather condition is "<rain_precipitation>"
        When the driver changes the key position to "<new_key_position>"
        Then the wiper mechanism feature should be "<expected_wiper_status>"
        And the wiper speed should be "<expected_wiper_speed>"
        And the error DTC code should be "<expected_error_code>"

        Examples:
            | key_position | knob_position | rain_sensor_status | rain_precipitation | new_key_position | expected_wiper_status | expected_wiper_speed | expected_error_code |
            | off          | off           | inactive           | no rain            | on               | inactive              | off                  | no_error            |
            | off          | slow          | inactive           | no rain            | on               | active                | slow                 | no_error            |
            | off          | fast          | inactive           | no rain            | on               | active                | fast                 | no_error            |
            | off          | medium        | inactive           | no rain            | on               | active                | medium               | no_error            |
            | on           | off           | inactive           | no rain            | off              | inactive              | off                  | no_error            |
            | on           | slow          | inactive           | no rain            | off              | inactive              | slow                 | no_error            |
            | on           | fast          | inactive           | no rain            | off              | inactive              | fast                 | no_error            |
            | on           | medium        | inactive           | no rain            | off              | inactive              | medium               | no_error            |
            | on           | off           | active             | rain               | off              | inactive              | off                  | no_error            |



    @5
    Scenario Outline: invalid inputs
        Given the ignition is "on"
        And the knob is "<knob_position>"
        And the rain sensor is "<rain_sensor_status>"
        When the signal "<signal>" changes to "invalid"
        Then the wiper mechanism feature should be "<expected_wiper_status>"
        And the error DTC code should be "error"

        Examples:
            | knob_position | rain_sensor_status | signal     | expected_wiper_status |
            | off           | inactive           | RainSensor | inactive              |
            | slow          | active             | Knob       | inactive              |


    @6
    Scenario Outline: healing failed signals
        Given the ignition is "on"
        And the signal "<signal>" is "invalid"
        When the signal "<signal>" changes to "<new_value>"
        Then the error DTC code should be "<dtc_initial>"
        And after a delay of 1 second the error DTC code should be "<dtc_final>"
        And the wiper mechanism feature should be "<expected_wiper_status>"

        Examples:
            | signal | new_value | dtc_initial | dtc_final | expected_wiper_status |
            | Knob   | off       | healed      | no_error  | inactive              |
            | Knob   | slow      | healed      | no_error  | active                |


    @7
    Scenario Outline: Healing failed signals with rain sensor
        Given the ignition is "on"
        And the signal "<signal>" is "invalid"
        When the signal "<signal>" changes to "<new_value>"
        Then the error DTC code should be "<dtc_initial>"
        And after a delay of 1 second the error DTC code should be "<dtc_final>"
        When the rain sensor detects "<value>"
        Then the wiper mechanism feature should be "<expected_wiper_status>"

        Examples:
            | signal     | new_value | dtc_initial | dtc_final | expected_wiper_status | value    |
            | RainSensor | inactive    | healed      | no_error  | inactive              | no rain  |
            | RainSensor | active    | healed      | no_error  | active                | the rain |








