import matlab.engine

# connect to matlab session
class Interface:
    """
    Documentation:
    -------------
    A class to interface with MATLAB Simulink models using the MATLAB Engine API for Python.
    Attributes:
    -----------
    model_name : str
        The name of the Simulink model to be controlled.
    eng : matlab.engine.MatlabEngine
        The MATLAB engine instance.
    saga : str
        A custom attribute to store additional information.
    Methods:
    --------
    __init__(self, model_name):
        Initializes the Interface with the given model name and connects to the MATLAB engine.
    start_model(self):
        Starts the Simulink model simulation.
    stop_model(self):
        Stops the Simulink model simulation.
    quit(self):
        Quits the MATLAB engine session.
    set_saga(self, saga):
        Sets the saga attribute.
    send_to_model(self, variableName, payload, var_type='Value'):
        Sends data to the Simulink model.
    get_from_model(self, variableName):
        Retrieves data from the Simulink model.
    """
    def __init__(self, model_name):
        self.eng = matlab.engine.connect_matlab()
        self.model_name = model_name
        self.saga = ""
       
    def start_model(self):
        name = self.model_name[:-1]
        
        # open simulink model (use this option to open up the model in the simulink window)
        self.eng.open_system(name, nargout=0)
        
        # load model (use this option to run in second plan)
        # self.eng.load_system(name, nargout=0)
        
        # start simulation 
        self.eng.set_param(name, "SimulationCommand", "start", nargout=0)
        
    def stop_model(self):
        name = self.model_name[:-1]
        # stop simulation 
        self.eng.set_param(name, "SimulationCommand", "stop", nargout=0)
        self.eng.eval("coverage = 1", nargout=0)
        
        # close simulink model (use this option if you want to close the model)
        # self.eng.close_system(name, nargout=0)
        
        # quit matlab.engine session
    def quit(self):
        self.eng.quit() 

    def set_saga(self, saga):
        self.saga = saga
        
    # matlab functions
    def send_to_model(self, variableName, payload, var_type='Value'):
        self.eng.set_real_time_data(variableName, payload, var_type, nargout=0)

    def get_from_model(self,variableName):
        return self.eng.get_real_time_data(variableName, nargout=1)
 
