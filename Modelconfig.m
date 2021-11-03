% Patient
patient = 1;
electrode = 6; 

% Model
I_Stimulation=-10^-3; % Corriente de estimulación del electrodo simulado (Amperios)
distanceBetweenNeurons = 0.21;          %Distancia entre las neuronas simuladas
boundaryRadius = 20;
meanMaterialConductivity = 0.3;
nNeuronasSimuladas = 43;        %Numero Neuronas simuladas DESPUES SE HACE SIMETRIA
arrayPos = 0.2; % Separación de la guía de electrodos (0.2)   
vpropag = 15;
numElectrodes = 9;
longitudNeurona = 2.738*10^-3;

% Input current File
membraneCurrentDensityFile = 'default.csv'; % bEIF.csv default.csv

% Electrodes
activeElectrode = 0;  %Electrodes goes from -4 to 4
anchorElectrode = 0;  %Anchor commonly 0 or +2

% DE
InterpolationMethod = 'linear'; %Only valid if anchorElectrode == 0 options = 'spline','cubic','linear'
withOptimization = true; % 'true' for optimization 'false' for load params
warnings = 'off';