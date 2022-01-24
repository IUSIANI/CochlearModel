clear all; close all; clc;

addpath('comsol')
run('init.m')

%% Select patient's data. |
NRT_real_k_Rec_Elect_Select = [-4, -3, -2, -1, 1, 2, 3, 4];
% NRT_real_k_Rec_Elect_Select = [-4, -2, 2, 4];
[NRT_real_k_Rec_Elect_Select, NRT_real_k_Amplitude_Select] = PatientData(patient, electrode, NRT_real_k_Rec_Elect_Select);

%% Run Neuron Mode - Calculate Bases.
try
    file_vbases_name = vbasesFile(nNeuronasSimuladas, numElectrodes, arrayPos, vpropag, mcdf);
    load(file_vbases_name,'V');
    fprintf('[+] Rundeopt.m >>\n\t[-] Potential (V) loaded from: %s\n\n', file_vbases_name)
catch
    fprintf('[+] Rundeopt.m >> File can not be loaded, file does not exist \"%s\"\n',file_vbases_name)
    fprintf('[+] Rundeopt.m >> Running \"comsol/models/Modo_Neurona.m\"\n\n')
    [V, ~] = Modo_Neurona(distanceBetweenNeurons, (nNeuronasSimuladas+1)/2, boundaryRadius, meanMaterialConductivity, arrayPos, vpropag); %Precalculated values. Run again if AP (Action Potential) neuros are changed.
    save(file_vbases_name,'V')
end

%% Calculate weights W.
fprintf("[+] Rundeopt.m >> Computing weights (W).\n\n")
[W] = calcWeights(anchorElectrode, V);

%% Run Electrode Mode.
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

%% Ratio between real values of stimulation current and which are used in the simulation.
C_k = I_k / I_Stimulation; 


%% Optimise.
switch withOptimization
    case true
        %[threshold, It] = calcThreshold(currentDensityAtNeurons);
        threshold = 0;
        run('optimization.m');
        opt02.w_ = NaN(size(d));

    case false %'predict' % Perimodiolar vs Lateral
        opt02 = load(optFiles(patient, electrode, anchorElectrode, "0.2"),'FVr_x','S','W','w_','threshold');
        S = opt02.S;
        threshold = opt02.threshold;
        FVr_x = opt02.FVr_x;
        fprintf("[+] Rundeopt.m >> Loading patient %s electrode %s anchor %s arrayPos %s\n", num2str(patient), num2str(electrode), num2str(anchorElectrode), "0.2")
        [d, ~] = calcDeltas(currentDensityAtNeurons, nNeuronasSimuladas, opt02.FVr_x(1), opt02.FVr_x(2), opt02.FVr_x(3), opt02.FVr_x(4), C_k, threshold);
        [w_] = calcW_(d, opt02.S, opt02.W);
        
        ws02 = load(patientwsFiles(patient,electrode, anchorElectrode, "0.2"),'distanceBetweenNeurons');
        distanceFocalization = calcFocalization(w_, ws02.distanceBetweenNeurons);

    case 'Manual'
        FVr_x = [4.07,102.86,0,702.01];
        [d, S] = calcDeltas(currentDensityAtNeurons, nNeuronasSimuladas, FVr_x(1), FVr_x(2), FVr_x(3), FVr_x(4), C_k);
        [w_] = calcW_(d,S,W);
        opt02.w_ = NaN(size(d));
  
end

%% Calculate NRTAmplitud.
NRTAmplitud = calcNRTAmplitud(V,d,S,W);

%% Make plots.

% Plot beta - Distribution
plotbetaDist(FVr_x)

% Plot Current Density at Neurons (J) - Electrode Mode
plotCurrentDensityatNeurons(currentDensityAtNeurons)

% Plot Weights W
plotWeights(W)

% Plot Deltas
plotDelta(d)

% Plot global Weights
plotW_(w_)


%% SaveData.
saveData()

%% Calculate RMSE, nRMSE and error (E).
format shortg

% Root mean square error (RMSE)
rmse = sqrt(mean(reshape(( (NRT_real_k_Amplitude - NRTAmplitud)).^2,1,[])))*1e6

% Range
range = max(reshape(NRT_real_k_Amplitude, 1,[])) - min(reshape(NRT_real_k_Amplitude, 1,[]));

% Normalized error: nRMSE = RMSE/Range
nrmse = rmse*1e-6/range

% n-th Error (p=4)
E = (sum(sum((NRT_real_k_Amplitude - NRTAmplitud).^4)).^(1/4))*1e6

fprintf("[+] Rundeopt.m >> Simulation Done succesfully!\n")