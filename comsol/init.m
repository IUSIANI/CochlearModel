% ignore warnings
warning('off','all')


comsolfolder=fileparts(which(mfilename));
mainFolder = fileparts(comsolfolder);
addpath(fullfile(comsolfolder,'./DE'))
addpath(fullfile(comsolfolder,'./geom'))
addpath(fullfile(comsolfolder,'./materials'))
addpath(fullfile(comsolfolder,'./mesh'))
addpath(fullfile(comsolfolder,'./models'))
addpath(fullfile(comsolfolder,'./NRTutils'))
addpath(fullfile(comsolfolder,'./physics'))
addpath(fullfile(comsolfolder,'./Aplots')) % ELIMINAR
% addpath(fullfile(comsolfolder,'./plots')) % ARREGLAR
addpath(fullfile(comsolfolder,'./prob'))
addpath(fullfile(comsolfolder,'./results'))
addpath(fullfile(comsolfolder,'./sol'))
addpath(fullfile(comsolfolder,'./study'))
addpath(fullfile(comsolfolder,'./utils'))

%% Global vars
% global verbose
global I_k C_k NRT_real_k_Rec_Elect NRT_real_k_Amplitude
global NRT_real_k_Rec_Elect_Select NRT_real_k_Amplitude_Select
global d S W W_
global longitudNeurona  method
global membraneCurrentDensityFile membraneCurrentDensityFolder mcdf


%% FileNames
global basesFile patientwsFiles optFiles
global patientcsvFiles patientwFiles 

basesFile = @(nNeuronasSimuladas, numElectrodos, arrayPos,vpropag, mcdf) sprintf('bases/NRT_%s_Neurons_%s_Electrodes_%s_%sm_s_%s.mat',num2str(nNeuronasSimuladas),num2str(numElectrodos), strrep(num2str(arrayPos),'.','_'),num2str(vpropag), mcdf{1});

patientwsFiles = @(pacient,electrode,anchorElectrode) sprintf('results/workspaces/ws_pacient_%s_electrode_%s_anchor_%s.mat',num2str(pacient), num2str(electrode),num2str(anchorElectrode));
optFiles = @(pacient,electrode,anchorElectrode) sprintf('results/opt/opt_pacient_%s_electrode_%s_anchor_%s.mat',num2str(pacient), num2str(electrode), num2str(anchorElectrode));
patientcsvFiles = @(patient,electrode,anchorElectrode, ext) sprintf('results/outputs/Patient_%s_Electrode_%s_anchor_%s.%s',num2str(patient), num2str(electrode),num2str(anchorElectrode),ext);
patientwFiles = @(patient,electrode,anchorElectrode) sprintf('results/outputs/Patient_%s_Electrode_%s_anchor_%s_weights.csv',num2str(patient), num2str(electrode),num2str(anchorElectrode));

%% Get CurrentInput file
% [membraneCurrentDensityFile, membraneCurrentDensityFolder] = uigetfile('.csv','Seleccione un fichero de corriente de entrada',fullfile(mainFolder, 'currentInputs', 'default.csv'));

% ELIMINAR
membraneCurrentDensityFolder = [mainFolder, '/currentInputs'];
membraneCurrentDensityFile = 'comsol.csv';
%

mcdf = strsplit(membraneCurrentDensityFile,'.');

run(fullfile(mainFolder,'DEconfig.m'))
run(fullfile(mainFolder,'Modelconfig.m'))
addpath(fullfile(mainFolder,'data'))

clear comsolfolder mainFolder
