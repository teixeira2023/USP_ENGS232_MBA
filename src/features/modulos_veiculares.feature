# Feature: Subsystem level scenarios

#     @1
#     Scenario Outline: signals sent from the vehicle module to the feature app

#         Given the key is "<vehicle_status>"
#         When the driver change the key status to "<desired_value>"
#         Then the vehicle_module should broadcast the signal can_signal_Key to the feature app
#         And the feature app should receive the can_key as "<signal_value>"

#         Examples:
#             | vehicle_status | desired_value | signal_value |
#             | off            | on            | on           |
#             | on             | off           | off          |

#     @2
#     Scenario Outline: signals sent from the knob module to the feature app

#         Given the key is "on"
#         And the knob is "<knob_status>"
#         When the driver change the knob position to "<desired_value>"
#         Then the knob_module should broadcast the signal lin_signal_Knob to the feature app
#         And the feature app should receive the lin_knob as "<signal_value>"

#         Examples:
#             | knob_status | desired_value | signal_value |
#             | off         | slow          | slow         |
#             | off         | fast          | fast         |
#             | off         | medium        | medium       |
#             | off         | fast          | fast         |
#             | slow        | off           | off          |
#             | medium      | off           | off          |
#             | fast        | off           | off          |
#             | fast        | slow          | slow         |
#             | fast        | medium        | medium       |
#             | medium      | slow          | slow         |
#             | medium      | fast          | fast         |
#             | slow        | medium        | medium       |
#             | slow        | fast          | fast         |

#     @3
#     Scenario Outline: signals sent from the rain sensor module to the feature app

#         Given the key is "on"
#         And the rain sensor is "<rain_status>"
#         When the rain sensor changes to "<desired_value>"
#         Then the rain_sensor_module should broadcast the signal can_signal_RainSensor to the feature app
#         And the feature app should receive the can_rain_sensor as "<signal_value>"

#         Examples:
#             | rain_status | desired_value | signal_value |
#             | inactive    | active        | active       |
#             | active      | inactive      | inactive     |






