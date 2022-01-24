clear all; close all; clc;

%% Init

addpath('comsol')
run('init.m')

file_vbases_name = vbasesFile(nNeuronasSimuladas, numElectrodes, arrayPos, vpropag, mcdf);
load(file_vbases_name,'V');
fprintf('[+] Rundeopt.m >>\n\t[-] Potential (V) loaded from: %s\n\n', file_vbases_name)

file_jbases_name = jbasesFile(nNeuronasSimuladas, numElectrodes, arrayPos,vpropag, mcdf);
load(file_jbases_name);
fprintf('[+] Rundeopt.m >>\n\t[-] Potential (V) loaded from: %s\n\n', file_jbases_name)
% 
% threshold = 0;
% patient = 1;
% electrode = 6;
% anchorElectrode = 0; % EL 0 NUNCA MÁS
% % 
% % % Cargamos datos paciente y generando una region muerta
% patient1 = load(optFiles(patient, electrode, anchorElectrode, "0.2"),'FVr_x','S','W','w_','threshold');
% 
% NRT_real_k_Rec_Elect_Select = [-4, -3, -2, -1, 1, 2, 3, 4];
% [NRT_real_k_Rec_Elect_Select, NRT_real_k_Amplitude_Select] = PatientData(patient, electrode, NRT_real_k_Rec_Elect_Select);
% 
% C_k = I_k / I_Stimulation; %Calculamos el ratio entre los valores reales de corriente de estimulación y el que se ha empleado en la simulación
% 
% [W] = calcWeights(anchorElectrode, V);
% [d, S] = calcDeltas(currentDensityAtNeurons, nNeuronasSimuladas, patient1.FVr_x(1), patient1.FVr_x(2), patient1.FVr_x(3), patient1.FVr_x(4), C_k);
% 
% d([round(length(d)/2)-5:round(length(d)/2)+5],:)=0;
% S = sum(d); 
% NRTAmplitud = calcNRTAmplitud(V,d,S,W);
% NRTAmplitud = NRTAmplitud + ( NRTAmplitud .* (((rand(size(NRTAmplitud))*2)-1)*0.1));
% 
% % plotNRTAmplitud(NRTAmplitud)
% % 
% % %% Save data
% [Xsorted, YRealsorted, YSimsorted, I] = sortInterp0(NRT_real_k_Rec_Elect, NRT_real_k_Amplitude, NRTAmplitud, anchorElectrode, InterpolationMethod);
% Electrodos = reshape(repmat(Xsorted,length(I_k), 1)', [],1); % Ok
% Intensidad = reshape(repmat(I_k, length(Xsorted),1),[],1); % Ok
% Paciente = repmat(patient,length(Intensidad),1); % Ok
% Opt = Paciente;
% Tipo = repmat(electrode,length(Intensidad),1); % Ok
% NRT_real = reshape(YRealsorted ,[],1); % Ok
% NRT_sim = reshape(YSimsorted,[],1);%
% 
% trained = ismember(Xsorted, NRT_real_k_Rec_Elect_Select);
% trained(find(Xsorted == anchorElectrode)) = true; 
% Trained = reshape(repmat(trained,length(I_k), 1)', [],1); % Ok
% rm = ~all(ismember(NRT_real_k_Rec_Elect,NRT_real_k_Rec_Elect_Select));
% RM=ones(size(Trained))*rm;
% Anchor = repmat(anchorElectrode, size(Electrodos));
% 
% data = [Electrodos,Intensidad,Paciente,Opt,Tipo,NRT_real,NRT_sim,Trained,RM,Anchor];
% T = array2table(data);
% T.Properties.VariableNames = {'Electrodos', 'Intensidad','Paciente','Opt','Tipo','NRT_real','NRT_sim','Trained','RM','Anchor'};
% writetable(T, sprintf('results/outputs/P%sE%sA%s_deathRegion_%s.xlsx',num2str(patient),num2str(electrode), num2str(anchorElectrode),''))
% csvwrite(sprintf('results/outputs/P%sE%sA%s_deathRegion_%s.csv',num2str(patient),num2str(electrode), num2str(anchorElectrode),''),data)
% csvwrite(sprintf('results/outputs/P%sE%sA%s_deathRegion_%s_weights.csv',num2str(patient),num2str(electrode), num2str(anchorElectrode),''),calcW_(d,S,W))
% 



% %% 
% NRT_real_k_Amplitude = NRTAmplitud;
load('NRT_real_k_Amplitude.mat'); 
NRT_real_k_Amplitude_Select = NRT_real_k_Amplitude;

%% Optimizamos con los datos generados y todas la VN vivas
anchorElectrode = 0;
[W] = calcWeights(anchorElectrode, V);
run('optimization.m');

NRTAmplitud = calcNRTAmplitud(V,d,S,W);
plotNRTAmplitud(NRTAmplitud)
plotDelta(d)


% Save data
[Xsorted, YRealsorted, YSimsorted, I] = sortInterp0(NRT_real_k_Rec_Elect, NRT_real_k_Amplitude, NRTAmplitud, anchorElectrode, InterpolationMethod);
Electrodos = reshape(repmat(Xsorted,length(I_k), 1)', [],1); % Ok
Intensidad = reshape(repmat(I_k, length(Xsorted),1),[],1); % Ok
Paciente = repmat(patient,length(Intensidad),1); % Ok
Opt = Paciente;
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

writetable(T, sprintf('results/outputs/P%sE%sA%s_deathRegion_%s.xlsx',num2str(patient),num2str(electrode), num2str(anchorElectrode),num2str(numDeadVN)))
csvwrite(sprintf('results/outputs/P%sE%sA%s_deathRegion_%s.csv',num2str(patient),num2str(electrode), num2str(anchorElectrode),num2str(numDeadVN)),data)
csvwrite(sprintf('results/outputs/P%sE%sA%s_deathRegion_%s_weights.csv',num2str(patient),num2str(electrode), num2str(anchorElectrode),num2str(numDeadVN)),calcW_(d,S,W))



%% Optimizamos con los datos generados y todas la VN vivas
numDeadVN = 6;
anchorElectrode = 0;
[W] = calcWeights(anchorElectrode, V);
run('optimization.m');
NRTAmplitud = calcNRTAmplitud(V,d,S,W);
plotNRTAmplitud(NRTAmplitud)
%plotDelta(d)
format shortg
rmse = sqrt(mean(reshape(( (NRT_real_k_Amplitude - NRTAmplitud)).^2,1,[])))*1e6


% Save data
[Xsorted, YRealsorted, YSimsorted, I] = sortInterp0(NRT_real_k_Rec_Elect, NRT_real_k_Amplitude, NRTAmplitud, anchorElectrode, InterpolationMethod);
Electrodos = reshape(repmat(Xsorted,length(I_k), 1)', [],1); % Ok
Intensidad = reshape(repmat(I_k, length(Xsorted),1),[],1); % Ok
Paciente = repmat(patient,length(Intensidad),1); % Ok
Opt = Paciente;
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

writetable(T, sprintf('results/outputs/P%sE%sA%s_deathRegion_%s.xlsx',num2str(patient),num2str(electrode), num2str(anchorElectrode),num2str(numDeadVN)))
csvwrite(sprintf('results/outputs/P%sE%sA%s_deathRegion_%s.csv',num2str(patient),num2str(electrode), num2str(anchorElectrode),num2str(numDeadVN)),data)
csvwrite(sprintf('results/outputs/P%sE%sA%s_deathRegion_%s_weights.csv',num2str(patient),num2str(electrode), num2str(anchorElectrode),num2str(numDeadVN)),calcW_(d,S,W))


%% Optimizamos con los datos generados y todas la VN vivas
numDeadVN = 6;
[W] = calcWeights(anchorElectrode, V);
run('optimization.m');
NRTAmplitud = calcNRTAmplitud(V,d,S,W);
plotNRTAmplitud(NRTAmplitud)
plotDelta(d)
fprintf("[+] deadRegion.m >> Simulation Done succesfully!\n")

% Save data
[Xsorted, YRealsorted, YSimsorted, I] = sortInterp0(NRT_real_k_Rec_Elect, NRT_real_k_Amplitude, NRTAmplitud, anchorElectrode, InterpolationMethod);
Electrodos = reshape(repmat(Xsorted,length(I_k), 1)', [],1); % Ok
Intensidad = reshape(repmat(I_k, length(Xsorted),1),[],1); % Ok
Paciente = repmat(patient,length(Intensidad),1); % Ok
Opt = Paciente;
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

writetable(T, sprintf('results/outputs/P%sE%sA%s_deathRegion_%s.xlsx',num2str(patient),num2str(electrode), num2str(anchorElectrode),num2str(numDeadVN)))
csvwrite(sprintf('results/outputs/P%sE%sA%s_deathRegion_%s.csv',num2str(patient),num2str(electrode), num2str(anchorElectrode),num2str(numDeadVN)),data)
csvwrite(sprintf('results/outputs/P%sE%sA%s_deathRegion_%s_weights.csv',num2str(patient),num2str(electrode), num2str(anchorElectrode),num2str(numDeadVN)),calcW_(d,S,W))


