%Variables de entrada
patient = 1;
electrode = 6; 
distanceBetweenNeurons = 0.21;          %Distancia entre las neuronas simuladas
boundaryRadius = 20;
meanMaterialConductivity = 0.3;
I_Stimulation=-10^-3;           %Corriente de estimulación del electrodo simulado (Amperios)
nNeuronasSimuladas = 43;        %Numero Neuronas simuladas DESPUES SE HACE SIMETRIA
arrayPos = 0.20; % Separación de la guía de electrodos   
vpropag = 15;
numElectrodes = 9; 
longitudNeurona = 2.738*10^-3;
membraneCurrentDensityFile = 'default.csv'; % bEIF.csv default.csv
activeElectrode = 0;  %Electrodes goes from -4 to 4
anchorElectrode = 0;  %Anchor commonly 0 or +2

InterpolationMethod = 'linear'; %Only valid if anchorElectrode == 0



