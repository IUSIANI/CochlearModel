clear all; close all; clc;


addpath('comsol')
run('init.m')

file_vbases_name = vbasesFile(nNeuronasSimuladas, numElectrodes, arrayPos, vpropag, mcdf);
load(file_vbases_name,'V');
fprintf('[+] Rundeopt.m >>\n\t[-] Potential (V) loaded from: %s\n\n', file_vbases_name)

file_jbases_name = jbasesFile(nNeuronasSimuladas, numElectrodes, arrayPos,vpropag, mcdf);
load(file_jbases_name);
fprintf('[+] Rundeopt.m >>\n\t[-] Potential (V) loaded from: %s\n\n', file_jbases_name)

% optPatient = 2;
% patient = 1;
% electrode = 6;
% anchorElectrode = 2;

optPatient = 1;
patient = 2;
electrode = 18;
anchorElectrode = 2;


patient1 = load(optFiles(optPatient, electrode, anchorElectrode, "0.2"),'FVr_x','S','W','w_','threshold');

NRT_real_k_Rec_Elect_Select = [-4, -3, -2, -1, 1, 2, 3, 4];
[NRT_real_k_Rec_Elect_Select, NRT_real_k_Amplitude_Select] = PatientData(patient, electrode, NRT_real_k_Rec_Elect_Select);

C_k = I_k / I_Stimulation; %Calculamos el ratio entre los valores reales de corriente de estimulación y el que se ha empleado en la simulación

[W] = calcWeights(anchorElectrode, V);
[d, ~] = calcDeltas(currentDensityAtNeurons, nNeuronasSimuladas, patient1.FVr_x(1), patient1.FVr_x(2), patient1.FVr_x(3), patient1.FVr_x(4), C_k);


NRTAmplitud = calcNRTAmplitud(V,d,patient1.S,W);

plotNRTAmplitud(NRTAmplitud)

%% ERROR
format shortg

rmse = sqrt(mean(reshape(( (NRT_real_k_Amplitude - NRTAmplitud)).^2,1,[])))*1e6
rango = max(reshape(NRT_real_k_Amplitude, 1,[])) - min(reshape(NRT_real_k_Amplitude, 1,[]));
nrmse = rmse*1e-6/rango
E = (sum(sum((NRT_real_k_Amplitude - NRTAmplitud).^4)).^(1/4))*1e6
fprintf("[+] cross.m >> Simulation Done succesfully!\n")

%% Prepare data
[Xsorted, YRealsorted, YSimsorted, I] = sortInterp0(NRT_real_k_Rec_Elect, NRT_real_k_Amplitude, NRTAmplitud, anchorElectrode, InterpolationMethod);
Electrodos = reshape(repmat(Xsorted,length(I_k), 1)', [],1); % Ok
Intensidad = reshape(repmat(I_k, length(Xsorted),1),[],1); % Ok
Paciente = repmat(patient,length(Intensidad),1); % Ok
Opt = repmat(optPatient,length(Intensidad),1);
Tipo = repmat(electrode,length(Intensidad),1); % Ok
NRT_real = reshape(YRealsorted ,[],1); % Ok
NRT_sim = reshape(YSimsorted,[],1);%

trained = ismember(Xsorted, NRT_real_k_Rec_Elect_Select);
trained(find(Xsorted == anchorElectrode)) = true; 
Trained = reshape(repmat(trained,length(I_k), 1)', [],1); % Ok
rm = ~all(ismember(NRT_real_k_Rec_Elect,NRT_real_k_Rec_Elect_Select));
RM=ones(size(Trained))*rm;
Anchor = repmat(anchorElectrode, size(Electrodos));

data = [Electrodos,Intensidad,Paciente,Opt,Tipo,NRT_real,NRT_sim,Trained,RM,Anchor];
T = array2table(data);
T.Properties.VariableNames = {'Electrodos', 'Intensidad','Paciente','Opt','Tipo','NRT_real','NRT_sim','Trained','RM','Anchor'};

writetable(T, patientcsvFiles(sprintf('%s%s',num2str(patient),num2str(optPatient)), electrode, anchorElectrode, arrayPos,'xlsx'))
csvwrite(patientcsvFiles(sprintf('%s%s',num2str(patient),num2str(optPatient)), electrode, anchorElectrode,arrayPos,'csv'),data)


