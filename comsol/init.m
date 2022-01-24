% ignore warnings
% warning('off','all')
format shortg

comsolfolder=fileparts(which(mfilename));
mainFolder = fileparts(comsolfolder);
addpath(fullfile(comsolfolder,'./DE'))
addpath(fullfile(comsolfolder,'./geom'))
addpath(fullfile(comsolfolder,'./materials'))
addpath(fullfile(comsolfolder,'./mesh'))
addpath(fullfile(comsolfolder,'./metrics'))
addpath(fullfile(comsolfolder,'./models'))
addpath(fullfile(comsolfolder,'./NRTutils'))
addpath(fullfile(comsolfolder,'./physics'))
addpath(fullfile(comsolfolder,'./plots'))
addpath(fullfile(comsolfolder,'./prob'))
addpath(fullfile(comsolfolder,'./results'))
addpath(fullfile(comsolfolder,'./sol'))
addpath(fullfile(comsolfolder,'./study'))
addpath(fullfile(comsolfolder,'./utils'))


%% Global vars
% global verbose
global I_k C_k I_Stimulation
global NRT_real_k_Rec_Elect NRT_real_k_Amplitude
global NRT_real_k_Rec_Elect_Select NRT_real_k_Amplitude_Select
global d S W W_
global longitudNeurona  method
global membraneCurrentDensityFile membraneCurrentDensityFolder mcdf
global anchorElectrode numDeadVN
%% FileNames
global vbasesFile jbasesFile patientwsFiles optFiles basesFile
global patientcsvFiles patientwFiles 
global mphElectrodo mphNeuron mphfolder
global meshfolder meshFile

basesFile = @(nNeuronasSimuladas, numElectrodos, arrayPos,vpropag, mcdf) sprintf('bases/NRT_%s_Neurons_%s_Electrodes_%s_%sm_s_%s.mat',num2str(nNeuronasSimuladas),num2str(numElectrodos), strrep(num2str(arrayPos),'.','_'),num2str(vpropag), mcdf{1});
vbasesFile = @(nNeuronasSimuladas, numElectrodos, arrayPos,vpropag, mcdf) sprintf('bases/vbases/NRT_%s_Neurons_%s_Electrodes_%s_%sm_s_%s.mat',num2str(nNeuronasSimuladas),num2str(numElectrodos), strrep(num2str(arrayPos),'.','_'),num2str(vpropag), mcdf{1});
jbasesFile = @(nNeuronasSimuladas, numElectrodos, arrayPos,vpropag, mcdf) sprintf('bases/jbases/NRT_%s_Neurons_%s_Electrodes_%s_%sm_s_%s.mat',num2str(nNeuronasSimuladas),num2str(numElectrodos), strrep(num2str(arrayPos),'.','_'),num2str(vpropag), mcdf{1});

% patient Files
patientwsFiles = @(pacient,electrode,anchorElectrode, arrayPos) sprintf('results/workspaces/ws_pacient_%s_electrode_%s_anchor_%s_arrayPos_%s.mat',num2str(pacient), num2str(electrode),num2str(anchorElectrode), num2str(arrayPos));
optFiles = @(pacient,electrode,anchorElectrode, arrayPos) sprintf('results/opt/opt_pacient_%s_electrode_%s_anchor_%s_arrayPos_%s.mat',num2str(pacient), num2str(electrode), num2str(anchorElectrode), num2str(arrayPos));
patientcsvFiles = @(patient,electrode,anchorElectrode,arrayPos, ext) sprintf('results/outputs/Patient_%s_Electrode_%s_anchor_%s_arrayPos_%s.%s',num2str(patient), num2str(electrode),num2str(anchorElectrode),num2str(arrayPos),ext);
patientwFiles = @(patient,electrode,anchorElectrode, arrayPos) sprintf('results/outputs/Patient_%s_Electrode_%s_anchor_%s_arrayPos_%s_weights.csv',num2str(patient), num2str(electrode),num2str(anchorElectrode), num2str(arrayPos));

% mph names
mphfolder = @(mcdf,arrayPos,modo)  sprintf('results/models/%s/%s/%s/', mcdf{1}, num2str(arrayPos), modo);
mphElectrodo = @(arrayPos,mcdf) sprintf('%s/ElectrodeMode_%s_%s.mph', mphfolder(mcdf, arrayPos, 'Electrodo') ,num2str(arrayPos), mcdf{1}); 
mphNeuron = @(numNeuron, arrayPos, mcdf) sprintf('%s/NeuronMode-%d_%s_%s.mph',mphfolder(mcdf, arrayPos, 'Neurona') ,numNeuron, num2str(arrayPos), mcdf{1}); 

% mesh folders
meshfolder = @(tipo) sprintf('results/mesh/%s',tipo);
meshFile = @(tipo, file) sprintf('%s/%s', meshfolder(tipo), file);

folders = {'results/images';'results/mesh';'results/models';'results/opt';'results/outputs';'results/workspaces'};
folders = fullfile(pwd, folders);
for f=1:length(folders)
    folder = folders{f};
    if ~exist(folder, 'dir')
       mkdir(folder)
    end
end

%% Version 2
global FilesName 
FilesName.bases = @(nNeuronasSimuladas, numElectrodos, arrayPos,vpropag, mcdf) sprintf('bases/NRT_%s_Neurons_%s_Electrodes_%s_%sm_s_%s.mat',num2str(nNeuronasSimuladas),num2str(numElectrodos), strrep(num2str(arrayPos),'.','_'),num2str(vpropag), mcdf{1});
FilesName.vbasesFile = @(nNeuronasSimuladas, numElectrodos, arrayPos,vpropag, mcdf) sprintf('bases/vbases/NRT_%s_Neurons_%s_Electrodes_%s_%sm_s_%s.mat',num2str(nNeuronasSimuladas),num2str(numElectrodos), strrep(num2str(arrayPos),'.','_'),num2str(vpropag), mcdf{1});
FilesName.jbasesFile = @(nNeuronasSimuladas, numElectrodos, arrayPos,vpropag, mcdf) sprintf('bases/jbases/NRT_%s_Neurons_%s_Electrodes_%s_%sm_s_%s.mat',num2str(nNeuronasSimuladas),num2str(numElectrodos), strrep(num2str(arrayPos),'.','_'),num2str(vpropag), mcdf{1});
% patient Files
FilesName.patientws = @(pacient,electrode,anchorElectrode, arrayPos) sprintf('results/workspaces/ws_pacient_%s_electrode_%s_anchor_%s_arrayPos_%s.mat',num2str(pacient), num2str(electrode),num2str(anchorElectrode), num2str(arrayPos));
FilesName.opt = @(pacient,electrode,anchorElectrode, arrayPos) sprintf('results/opt/opt_pacient_%s_electrode_%s_anchor_%s_arrayPos_%s.mat',num2str(pacient), num2str(electrode), num2str(anchorElectrode), num2str(arrayPos));
FilesName.patientcsv = @(patient,electrode,anchorElectrode,arrayPos, ext) sprintf('results/outputs/Patient_%s_Electrode_%s_anchor_%s_arrayPos_%s.%s',num2str(patient), num2str(electrode),num2str(anchorElectrode),num2str(arrayPos),ext);
FilesName.patientw = @(patient,electrode,anchorElectrode, arrayPos) sprintf('results/outputs/Patient_%s_Electrode_%s_anchor_%s_arrayPos_%s_weights.csv',num2str(patient), num2str(electrode),num2str(anchorElectrode), num2str(arrayPos));
% mph names
FilesName.mphfolder = @(mcdf,arrayPos,modo)  sprintf('results/models/%s/%s/%s/', mcdf{1}, num2str(arrayPos), modo);
FilesName.mphElectrodo = @(arrayPos,mcdf) sprintf('%s/ElectrodeMode_%s_%s.mph', mphfolder(mcdf, arrayPos, 'Electrodo') ,num2str(arrayPos), mcdf{1}); 
FilesName.mphNeuron = @(numNeuron, arrayPos, mcdf) sprintf('%s/NeuronMode-%d_%s_%s.mph',mphfolder(mcdf, arrayPos, 'Neurona') ,numNeuron, num2str(arrayPos), mcdf{1}); 
% mesh folders
FilesName.meshfolder = @(tipo) sprintf('results/mesh/%s',tipo);
FilesName.meshFile = @(tipo, file) sprintf('%s/%s', meshfolder(tipo), file);

%%
fprintf("[+] comsol/init.m >> Loading config files\n")
run(fullfile(mainFolder,'DEconfig.m'))
fprintf("\t[-] \'DEconfig.m\' loaded succefully\n")
run(fullfile(mainFolder,'Modelconfig.m'))
fprintf("\t[-] \'Modelconfig.m\' loaded succefully\n\n")
addpath(fullfile(mainFolder,'data'))

%% Get CurrentInput file
if isempty(membraneCurrentDensityFile)
	[membraneCurrentDensityFile, membraneCurrentDensityFolder] = uigetfile('.csv','Seleccione un fichero de corriente de entrada',fullfile(mainFolder, 'currentInputs', 'default.csv'));
else
    membraneCurrentDensityFolder =  '/home/local/dca/mjhernandez/Escritorio/Modelo Coclea/currentInputs/';
end

fprintf("[+] comsol/init.m >>\n\t[-] Membrane Current Density file: \'%s\'\n",membraneCurrentDensityFile)
mcdf = strsplit(membraneCurrentDensityFile,'.');

warning(warnings,'all')
clear comsolfolder mainFolder
