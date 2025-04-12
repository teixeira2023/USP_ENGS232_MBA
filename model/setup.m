% #############################################################################################
% Matlab/Simulink and Python Integration
% #############################################################################################

% #############################################################################################
% 1. set the current directory of the project
% #############################################################################################
currentDir = pwd;
disp(["1. the current dir is: ",currentDir]);

% #############################################################################################
% 2.get the model name automatically 
% #############################################################################################
folder = strcat(pwd,"/Model/simulink"); % Substitua pelo caminho da sua pasta

files = dir(fullfile(folder, '*.slx')); % Encontra todos os arquivos .slx na pasta

if ~isempty(files)
  fileName = files(1).name; % Pega o nome do primeiro arquivo .slx encontrado
  disp(['2. SLX file name: ', fileName]);
else
  disp('failed in step 2. No .slx file were found in the current folder.');
end
 

% #############################################################################################
% 3. add the current directory to matlab path
% #############################################################################################
cd(currentDir); % back to the current directory
addpath(genpath(currentDir)); % Use genpath if you have subfolders
disp(["3. path added succesfully. Path: ",path]);

% #############################################################################################
% 4. set the model name
% #############################################################################################
model = strcat(strrep(fileName, '.slx', ''),"/");
disp(["model name = ",model]);

% #############################################################################################
% 5. load the system and run the model
% #############################################################################################
% use this command when the simulink must be opened in foreground
open_system(model);
% use this command when the simulink must be opened in background
% load_system(model); 

% #############################################################################################
% 6. start the ML/py integration
% #############################################################################################
try
    matlab.engine.shareEngine;
    disp('6. MATLAB engine shared successfully.');
catch ME
    disp(['6. Error sharing MATLAB engine: ', ME.message]);
    % Add more sophisticated error handling here, such as re-trying the connection or exiting gracefully.
end

% #############################################################################################
% 7.Run Behave
% #############################################################################################
% coverage = 0;
% system("cd Scenarios/features && coverage run -m behave &");
