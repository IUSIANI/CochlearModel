clear all; close all; clc;


addpath('comsol')
run('init.m')

tic;
nNeuronasSimuladas = 43;

%% Seleccionar datos del paciente. |
NRT_real_k_Rec_Elect_Select = [-4, -3, -2, -1, 1, 2, 3, 4];
%NRT_real_k_Rec_Elect_Select = [-4, -2, 2, 4];
[NRT_real_k_Rec_Elect_Select, NRT_real_k_Amplitude_Select] = PatientData(patient, electrode, NRT_real_k_Rec_Elect_Select);

%% Ejecutar Modo Neurona - Calcular Bases.
try
    file_vbases_name = vbasesFile(nNeuronasSimuladas, numElectrodes, arrayPos, vpropag, mcdf);
    load(file_vbases_name,'V');
    fprintf('[+] Rundeopt.m >>\n\t[-] Potential (V) loaded from: %s\n\n', file_vbases_name)
catch
    fprintf('[+] Rundeopt.m >> File can not be loaded, file does not exist \"%s\"\n',file_vbases_name)
    fprintf('[+] Rundeopt.m >> Running \"comsol/models/Modo_Neurona.m\"\n\n')
    [V, ~] = Modo_Neurona(distanceBetweenNeurons, (nNeuronasSimuladas+1)/2, boundaryRadius, meanMaterialConductivity, arrayPos, vpropag); %Valores ya precalculado, volver a ejecutar si se cambian AP de la neurona
    save(file_vbases_name,'V')
end

%% Calcular los pesos W
fprintf("[+] Rundeopt.m >> Computing weights (W).\n\n")
[W] = calcWeights(anchorElectrode, V);

%% Ejecutar Modo Electrodo
try
    file_jbases_name = jbasesFile(nNeuronasSimuladas, numElectrodes, arrayPos,vpropag, mcdf);
    load(file_jbases_name);
    fprintf('[+] Rundeopt.m >>\n\t[-] Potential (V) loaded from: %s\n\n', file_jbases_name)
catch
    fprintf('[+] Rundeopt.m >> File can not be loaded, file does not exist \"%s\"\n',file_jbases_name)
    fprintf('[+] Rundeopt.m >> Running \"comsol/models/Modo_Electrodo.m\"\n\n')
    [currentDensityAtNeurons, ~] = Modo_Electrodo(I_Stimulation, distanceBetweenNeurons, (nNeuronasSimuladas+1)/2, boundaryRadius, meanMaterialConductivity, arrayPos);
    currentDensityAtNeurons = [currentDensityAtNeurons(end:-1:2,:),;currentDensityAtNeurons];
    save(file_jbases_name,'currentDensityAtNeurons')
end


%%
C_k = I_k / I_Stimulation; %Calculamos el ratio entre los valores reales de corriente de estimulación y el que se ha empleado en la simulación

% Optimizar
switch withOptimization
    case true
        run('optimization.m');

    case false %'predict'
        opt02 = load(optFiles(patient, electrode, anchorElectrode, "0.2"),'FVr_x','S','W');
        S = opt02.S;
        FVr_x = opt02.FVr_x;
        fprintf("[+] Rundeopt.m >> Loading patient %s electrode %s anchor %s arrayPos %s\n", num2str(patient), num2str(electrode), num2str(anchorElectrode), "0.2")
        [d, ~] = calcDeltas(currentDensityAtNeurons, nNeuronasSimuladas, opt02.FVr_x(1), opt02.FVr_x(2), opt02.FVr_x(3), opt02.FVr_x(4), C_k);
        [w_] = calcW_(d,opt02.S,opt02.W);
    
    case 'Manual'
        FVr_x = [8.16/2,209.87/2,0,702.13];
        [d, S] = calcDeltas(currentDensityAtNeurons, nNeuronasSimuladas, FVr_x(1), FVr_x(2), FVr_x(3), FVr_x(4), C_k);
        [w_] = calcW_(d,S,W);    
end


%% Cálculo de la NRTAmplitud
NRTAmplitud = calcNRTAmplitud(V,d,S,W);


%% Make plots
plotbetaDist(FVr_x)
plotCurrentDensityatNeurons(currentDensityAtNeurons)
plotWeights(W)
plotDelta(d)
plotW_(w_)
plotNRTAmplitud(NRTAmplitud)

%% SaveData: crear los saves
saveData()

fprintf("[+] Rundeopt.m >> Simulation Done succesfully!\n")
%% ELIMINAR
% waveOnElectrode=getWaveOnElectrodeFromBases(-2, V)
% vTotal=sum(waveOnElectrode.*w_(:,3),1)
% 
% max(vTotal)-min(vTotal)
% t = 0:0.02:5;
% NRTAmplitud = zeros(length(C_k),1);
% NRTwave = zeros(1,size(t,2));
% 
% ampV = getAmpOnElectrodeFromBases(-2, V);
% waveECAP = getWaveOnElectrodeFromBases(-2, V);
% 
% Calculate NRT values from simulation
% k=3;
% for i=1:nNeuronasSimuladas
%     NRTAmplitud(k,1) = NRTAmplitud(k,1) + ((d(i,k)/S(k)) * W(i,k) * ampV(i));
%     NRTwave(1,:)     = NRTwave(1,:)     + (((d(i,k)/S(k)) * W(i,k) * waveECAP(i,:)))*1.059;
% end
% NRTAmplitud
% max(NRTwave)-min(NRTwave)
% 
% figure; plot(NRTwave)
% t = 0:0.02:5;
% csvwrite(sprintf('resultados/outputs/nrt4_%s.csv',mcdf{1}),[t;NRTwave]')
% 
% system(sprintf('python3 python/mesh.py -f %s -s -dy %f',meshFile('output','mesh.mphtxt'), arrayPos-0.2))

% mphlaunch