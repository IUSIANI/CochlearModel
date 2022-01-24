% ======================================================================= %
%                              Patient
% ======================================================================= %
patient = 1;

% Electrodes
electrode = 6; % Stimulated Electrode Absolute numeration
activeElectrode = 0;  % Electrodes goes from -4 to 4. Commonly = 0
anchorElectrode = 2;  % Anchor commonly 0 or +2


% ======================================================================= %
%                             Model Params
% ======================================================================= %
% Stimulation current of the simulated electrode (Amperes).
I_Stimulation=-10^-3; 

% Distance between simulated neurons.
distanceBetweenNeurons = 0.21;   

% Boundary Radius [mm]
boundaryRadius = 20;

% Mean Material Conductivity [S/m]
meanMaterialConductivity = 0.3;

% Number of simulated neurons. [#]
nNeuronasSimuladas = 43;

% Electrode array position (0.2) [mm].
arrayPos = 0.2; 

% Propagation velocity [m/s]
vpropag = 15;

% Number of Electrodes [#]
numElectrodes = 9;

% Neuron length [mm]
longitudNeurona = 2.738*10^-3;


% ======================================================================= %
%                          Input current File
% ======================================================================= %
membraneCurrentDensityFile = 'default.csv'; % bEIF.csv default.csv


% ======================================================================= %
%                   Differential Evolution Algorithm
% ======================================================================= %
% Intermpolation method. options ['spline','cubic','linear']
% Only valid if anchorElectrode == 0 
InterpolationMethod = 'linear'; 

% Optimize:
%  'true' for optimization
%  'false' for load params
%   or 'manual' for setting [alpha, beta, jmin, jmax] manual
withOptimization = true; 

% ======================================================================= %
%                           Define death region.
% ======================================================================= %
numDeadVN = 0;







