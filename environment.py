from behave import *
from utils.interface import Interface
import time

latency = 1
        
def before_all(context):
    """
    Initializes the simulation environment before all tests.
    This function sets up the simulation environment by specifying the 
    Simulink model name, creating an instance of the Interface class with 
    the model name, setting the SAGA configuration, and starting the model.
    Args:
        context: A Behave context object that stores data during the test run.
    """
    
    model_name = "wiper_mechanism_BDD/" #update your simulink model
    print(model_name)
    
    context.model = Interface(model_name)
    context.model.set_saga("")
    context.model.start_model()
    context.model.send_to_model("Key",0)  # Ensure the key is off before stopping
    context.model.send_to_model("Knob",0)  # Ensure the knob is off before stopping
    context.model.send_to_model("RainSensor",0)  # Ensure the rain sensor is off before stopping
    context.model.send_to_model("rain",0) # Ensure the rain is off before stopping

def before_scenario(context, scenario):
    # Configurações antes de cada cenário
    print(f"Starting scenario: {scenario.name}")

def after_scenario(context, scenario):
    # Limpeza após cada cenário
    print(f"Scenario finished: {scenario.name}")
    

def after_all(context):
    # Limpeza após todos os cenários
    print("All tests done!!!")
    context.model.send_to_model("Key",0)  # Ensure the key is off before stopping
    context.model.send_to_model("Knob",0)  # Ensure the knob is off before stopping
    context.model.send_to_model("RainSensor",0)  # Ensure the rain sensor is off before stopping
    context.model.send_to_model("rain",0) # Ensure the rain is off before stopping

    #stop the simulation and close simulink model
    context.model.stop_model()
    time.sleep(latency)
    context.model.quit()
