clear all; close all; clc;


addpath('comsol')
run('init.m')


tic;
nNeuronasSimuladas = 1;
%% Seleccionar datos del paciente. | Done.
NRT_real_k_Rec_Elect_Select = [-4, -3, -2, -1, 1, 2, 3, 4];
% NRT_real_k_Rec_Elect_Select = [-4, -2, 2, 4];
[NRT_real_k_Rec_Elect_Select, NRT_real_k_Amplitude_Select] = PatientData(patient, electrode, NRT_real_k_Rec_Elect_Select);

%% Ejecutar Modo Neurona - Calcular Bases.
try
    file_bases_name = basesFile(nNeuronasSimuladas, numElectrodes, arrayPos,vpropag, mcdf);
    load(file_bases_name);
    fprintf('[+] Rundeopt.m >>\n\t[-] Potential (V) loaded from: %s\n\n', file_bases_name)
catch
    fprintf('[+] Rundeopt.m >> File can not be loaded, file does not exist \"%s\"\n',file_bases_name)
    fprintf('[+] Rundeopt.m >> Running \"comsol/models/Modo_Neurona.m\"\n\n')
    [V, ~] = Modo_Neurona(distanceBetweenNeurons, (nNeuronasSimuladas+1)/2, boundaryRadius, meanMaterialConductivity, arrayPos, vpropag); %Valores ya precalculado, volver a ejecutar si se cambian AP de la neurona
    save(file_bases_name,'V')
end

%% Calcular los pesos W
fprintf("[+] Rundeopt.m >> Computing weights (W).\n\n")
[W] = calcWeights(anchorElectrode, V);
WAll = {W}; % Modificar DE

%% Ejecutar Modo Electrodo
[currentDensityAtNeurons, model] = Modo_Electrodo(I_Stimulation, distanceBetweenNeurons, (nNeuronasSimuladas+1)/2, boundaryRadius, meanMaterialConductivity, arrayPos);
currentDensityAtNeurons = [currentDensityAtNeurons(end:-1:2,:),;currentDensityAtNeurons];


%% Parámetros del Optimizador
C_k = I_k / I_Stimulation; %Calculamos el ratio entre los valores reales de corriente de estimulación y el que se ha empleado en la simulación

Model_struct.model = model;
Model_struct.distanciaEntreNeuronas = distanceBetweenNeurons;
Model_struct.nNeuronasSimuladas = nNeuronasSimuladas;
Model_struct.currentDensityAtNeurons = currentDensityAtNeurons;
Model_struct.C_k = C_k;
Model_struct.V = V;
Model_struct.NRT_real_k_Amplitude = NRT_real_k_Amplitude_Select;
Model_struct.NRT_real_k_Rec_Elect = NRT_real_k_Rec_Elect_Select;
Model_struct.W = WAll; % Modificar DE
Model_struct.anchorElectrode = anchorElectrode;

%% Optimizar parámetros
[FVr_x,S_y,I_nf] = deopt('objfun',S_struct, Model_struct);


%% Calcular Pesos.
[d, S] = calcDeltas(currentDensityAtNeurons, nNeuronasSimuladas, FVr_x(1), FVr_x(2), FVr_x(3), FVr_x(4), C_k);
[w_] = calcW_(d,S,W);


%% Cálculo de la NRTAmplitud | VOY POR AQUI
% Meter en función 

NRTAmplitud = zeros(length(C_k),length(NRT_real_k_Amplitude));
for m=1:length(NRT_real_k_Rec_Elect)
    ampV = getAmpOnElectrodeFromBases(NRT_real_k_Rec_Elect(m), V);

    %Calculate NRT values from simulation
    for k=1:length(C_k)
        for i=1:nNeuronasSimuladas
            if (S(k)==0)
                NRTAmplitud(k,m) = 0;
            else
                NRTAmplitud(k,m) = NRTAmplitud(k,m) + ((d(i,k)/S(k)) * W(i,k) * ampV(i));
            end
        end
    end
end

%% SaveData: crear los saves
saveData()

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
