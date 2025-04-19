# Feature: wiper mechanism
#     In order to see clearly when it is raining
#     As a driver
#     I want the wiper mechanism to clear the windshield

#     Background: test setup
#         Given the knob is "off"
#         And the rain sensor is "inactive"

#     @scenario_1 @happy_path
#     Scenario: Wipers are off - rain sensor detects rain
#         Given the ignition is "on"
#         When the rain sensor detects "the rain"
#         Then the wiper mechanism feature should be "active"

#     @scenario_2 @happy_path
#     Scenario: Wipers are off - knob is turned to "on"
#         Given the ignition is "on"
#         When the driver changes the knob position to "on"
#         Then the wiper mechanism feature should be "active"

#     @scenario_3 @happy_path
#     Scenario: Wipers are on - knob is turned to "off"
#         Given the ignition is "on"
#         And the knob is "on"
#         When the driver changes the knob position to "off"
#         Then the wiper mechanism feature should be "inactive"

#     @scenario_4 @happy_path
#     Scenario: Wipers are on - rain sensor detects no rain
#         Given the ignition is "on"
#         And the rain sensor is "active"
#         When the rain sensor detects "no rain"
#         Then the wiper mechanism feature should be "inactive"

#     @scenario_5 @output_wiper_output @happy_path
#     Scenario: Wipers are on - key is turned to "off"
#         Given the ignition is "on"
#         And the knob is "on"
#         When the driver turns the ignition "off"
#         Then the wiper mechanism feature should be "inactive"

#     @scenario_6 @unhappy_path
#     Scenario: Wipers are off - knob is turned to "off"
#         Given the ignition is "off"
#         And the knob is "off"
#         When the driver changes the knob position to "on"
#         Then the wiper mechanism feature should be "inactive"

#     @scenario_7 @unhappy_path
#     Scenario: Wipers are off - rain sensor detects no rain
#         Given the ignition is "off"
#         And the rain sensor is "inactive"
#         When the rain sensor detects "the rain"
#         Then the wiper mechanism feature should be "inactive"

#     @scenario_8 @unhappy_path
#     Scenario Outline: testing preconditions
#         Given the ignition is "<key_position>"
#         And the knob is "<knob_position>"
#         And the rain sensor is "<rain_sensor_status>"
#         When the driver changes the knob position to "<new_knob_position>"
#         And the driver changes the key position to "<new_key_position>"
#         Then the wiper mechanism feature should be "<expected_wiper_status>"

#         Examples:
#             | key_position | knob_position | rain_sensor_status | new_knob_position | new_key_position | expected_wiper_status |
#             | off          | off           | inactive           | on                | on               | active                |
#             | off          | off           | inactive           | on                | off              | inactive              |
#             | off          | off           | inactive           | off               | off              | inactive              |
#             | off          | off           | inactive           | off               | on               | inactive              |


#     @scenario_9 @unhappy_path
#     Scenario Outline: invalid inputs
#         Given the ignition is "on"
#         And the knob is "<knob_position>"
#         And the rain sensor is "<rain_sensor_status>"
#         When the signal "<signal>" changes to "invalid input"
#         Then the wiper mechanism feature should be "<expected_wiper_status>"
#         And the error DTC code should be "error: 0x00 invalid input"

#         Examples:
#             | knob_position | rain_sensor_status | signal     | expected_wiper_status |
#             | off           | inactive           | RainSensor | inactive              |
#             | on            | active             | Knob       | inactive              |


#     @scenario_10 @unhappy_path
#     Scenario Outline: healing failed signals
#         Given the ignition is "on"
#         And the signal "<signal>" is "<curr_value>"
#         When the signal "<signal>" changes to "<new_value>"
#         Then the wiper mechanism feature should be "active"
#         And the error DTC code should be "no error"

#         Examples:
#             | signal     | curr_value | new_value |
#             | RainSensor | inactive   | active    |
#             | Knob       | off        | on        |

#     @scenario_11 @unhappy_path
#     Scenario: Wipers are off - knob is turned to "on" - rain sensor detects no rain
#         Given the wiper mechanism is "inactive"
#         And the knob is "off"
#         And the ignition is "on"
#         When the driver changes the knob position to "on"
#         Then the wiper mechanism feature should be "active"


    
