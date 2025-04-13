from behave import *
import time

latency = 1

@given('the ignition is "{status}"')
def step_impl(context,status):
    context.ignition = status.replace('"','')
    if context.ignition == "on":
        context.model.send_to_model("Key",1)
    else:
        context.model.send_to_model("Key",0)
    time.sleep(1)
    if context.ignition == "on":
        context.model.send_to_model("Key",1)
    else:
        context.model.send_to_model("Key",0)
    time.sleep(1) 

@given('the knob is "{knob}"')
def step_impl(context,knob):
    context.knob = knob.replace('"','')
    if context.knob == "off":
        context.model.send_to_model("Knob",0)
    elif context.knob == "slow":
        context.model.send_to_model("Knob",1)
    elif context.knob == "medium":
        context.model.send_to_model("Knob",2)
    elif context.knob == "fast":
        context.model.send_to_model("Knob",3)
    else:
        print("Invalid knob position")
        context.model.send_to_model("Knob",4)
    time.sleep(1)
 

@given('the rain sensor is "{status}"')
def step_impl(context,status):
    context.rain_sensor = status.replace('"','')
    context.model.send_to_model("RainSensor",0 ) if status == "inactive" else context.model.send_to_model("RainSensor",1 )
 

@when('the rain sensor detects "{status}"')
def step_impl(context,status):
    context.rain_sensor = status
    context.model.send_to_model("rain",1 ) if status == "the rain" else context.model.send_to_model("rain",0 )
    time.sleep(1)
    context.model.send_to_model("RainSensor",1 ) if status == "the rain" else context.model.send_to_model("RainSensor",0 )
    time.sleep(1)

@when('the driver changes the knob position to "{knob}"')
def step_impl(context,knob):
    context.knob = knob.replace('"','')
    if context.knob == "slow":
        context.model.send_to_model("Knob",1)
    elif context.knob == "off":
        context.model.send_to_model("Knob",0)
    elif context.knob == "medium":
        context.model.send_to_model("Knob",2)
    elif context.knob == "fast":
        context.model.send_to_model("Knob",3)
    else:
        print("Invalid knob position")
        context.model.send_to_model("Knob",4)
    time.sleep(1)

 

@when('the driver turns the ignition "{status}"')
def step_impl(context,status):
    context.ignition = status.replace('"','')
    context.model.send_to_model("Key",1) if status == "on" else context.model.send_to_model("Key",0)
    time.sleep(1)
@then('the wiper mechanism feature should be "{status}"')
def step_impl(context,status):
    context.wiper_mechanism = status.replace('"','')
    context.result = context.model.get_from_model("log_wiper_output")
    time.sleep(latency)
    context.result = "inactive" if context.result == 0 else "active" if context.result == 1 else "invalid"
    time.sleep(latency)
    assert context.result == context.wiper_mechanism,f"Expected {status} but got {context.result}"

@given('the driver changes the key position to "{key_position}"')
def step_impl(context,key_position):
    context.key_position = key_position.replace('"','')
    context.model.send_to_model("Key",1) if key_position == "on" else context.model.send_to_model("Key",0)
    time.sleep(latency)
    
@when('the driver changes the key position to "{key_position}"')
def step_impl(context,key_position):
    context.key_position = key_position.replace('"','')
    context.model.send_to_model("Key",1) if key_position == "on" else context.model.send_to_model("Key",0)
    time.sleep(latency)

@then('the error DTC code should be "{DTC}"')
def step_impl(context,DTC):
    context.dtc = DTC.replace('"','')
    time.sleep(latency)
    context.result = context.model.get_from_model("log_DTC_msg")
    time.sleep(latency)
    assert context.result == DTC,f"Expected the error DTC code should be {DTC} but got {context.result}"
    time.sleep(latency)  # Wait for 1 second before checking the DTC code again

# @when('the signal "{signal}" changes to "{value}"')
# def step_impl(context,signal,value):
#     context.signal = signal.replace('"','')
#     context.value = value.replace('"','')
#     if context.value == "off":
#         new_value = 0
#     elif context.value == "slow":
#         new_value = 1
#     elif context.value == "medium":
#         new_value = 2
#     elif context.value == "fast":
#         new_value = 3
#     else:
#         print("Invalid knob position")
#         new_value = 4
  
#     context.model.send_to_model(context.signal,new_value)
#     time.sleep(latency)

@given('the signal "{signal}" is "{value}"')
def step_impl(context,signal,value):
    context.signal = signal.replace('"','')
    context.value = value.replace('"','')
    if context.signal == "Knob":
        if context.value == "off":
            value = 0
        elif context.value == "slow":
            value = 1
        elif context.value == "medium":
            value = 2
        elif context.value == "fast":
            value = 3
        else:
            print("Invalid knob position")
            value = 4
        # Send the value to the model
        context.model.send_to_model(context.signal,value)
    elif context.signal == "RainSensor":   
        if context.value == "inactive":
            value = 0
        elif context.value == "active":
            value = 1
        else:
            print("Invalid rain sensor status")
            value = 2
        # Send the value to the model
        context.model.send_to_model(context.signal,value)
    time.sleep(latency)

@when('the signal "{signal}" changes to "{new_value}"')
def step_impl(context,signal,new_value):
    context.signal = signal.replace('"','')
    context.new_value = new_value.replace('"','')
    if context.signal == "Knob":
        if context.new_value == "slow":
            context.model.send_to_model(context.signal,1)
        elif context.new_value == "off":
            context.model.send_to_model(context.signal,0)
        else:
            context.model.send_to_model(context.signal,4)
            
    if context.signal == "RainSensor":
        if context.new_value == "active":
            context.model.send_to_model(context.signal,1)
        elif context.new_value == "inactive":
            context.model.send_to_model(context.signal,0)
        else:
            context.model.send_to_model(context.signal,2)


@given('the wiper mechanism is "inactive"')
def given_wiper_mechanism_is_inactive(context):
    context.wiper_mechanism = "inactive"
    context.model.send_to_model("Knob",0)
    context.model.send_to_model("RainSensor",0)
    time.sleep(latency)
    
@when('the driver adjusts the wiper speed to "{speed}"')
def step_impl(context,speed):
    context.speed = speed.replace('"','')
    if context.speed == "slow":
        context.model.send_to_model("Knob",1)
    elif context.speed == "medium":
        context.model.send_to_model("Knob",2)
    elif context.speed == "fast":
        context.model.send_to_model("Knob",3)
    else:
        context.model.send_to_model("Knob",4)


@then('the wiper speed should be "{speed}"')
def step_impl(context,speed):
    context.speed_result = speed.replace('"','')
    time.sleep(latency)
    context.result = context.model.get_from_model("log_speed_out")
    time.sleep(latency)
    if context.result == 0:
        context.result = "off"
    elif context.result == 1:
        context.result = "slow"
    elif context.result == 2:
        context.result = "medium"
    elif context.result == 3:
        context.result = "fast"
    elif context.result == 4:
        context.result = "invalid"        
    time.sleep(latency)
    assert context.result == context.speed_result,f"Expected the wiper speed should be {speed} but got {context.result}"
    
@given('the weather condition is "{rain_precipitation}"')
def step_impl(context,rain_precipitation):
    context.rain_precipitation = rain_precipitation.replace('"','')
    context.model.send_to_model("rain",1) if rain_precipitation == "rain" else context.model.send_to_model("rain",0)
    time.sleep(latency)
    
@then('after a delay of 1 second the error DTC code should be {DTC}')
def step_impl(context,DTC):
    context.dtc = DTC.replace('"','')
    time.sleep(latency*5)
    context.result = context.model.get_from_model("log_DTC_msg")
    assert context.result == context.dtc,f"Expected the error DTC code should be {context.dtc} but got {context.result}"
    # time.sleep(latency)  # Wait for 1 second before checking the DTC code again