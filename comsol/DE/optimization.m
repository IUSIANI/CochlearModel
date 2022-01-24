%% Optimiser parameters.
Model_struct.distanciaEntreNeuronas = distanceBetweenNeurons;
Model_struct.nNeuronasSimuladas = nNeuronasSimuladas;
Model_struct.currentDensityAtNeurons = currentDensityAtNeurons;
Model_struct.C_k = C_k;
Model_struct.V = V;
Model_struct.NRT_real_k_Amplitude = NRT_real_k_Amplitude_Select;
Model_struct.NRT_real_k_Rec_Elect = NRT_real_k_Rec_Elect_Select;
Model_struct.index  = NRT_real_k_Rec_Elect;
Model_struct.W = W;
Model_struct.anchorElectrode = anchorElectrode;
Model_struct.threshold = threshold;
Model_struct.Stol = Stol;
Model_struct.JMAX = max(max(currentDensityAtNeurons));
Model_struct.SThreshold = Model_struct.JMAX * Stol;
% Model_struct.SThreshold = 0.01;

switch S_struct.bound
    case 'auto'
        S_struct.FVr_minbound = [epsilon,    epsilon,    0,  Model_struct.JMAX+epsilon]; 
        S_struct.FVr_maxbound = [2000   ,       2000,    0, 2*Model_struct.JMAX];
end

%% Optimise parameters.
[FVr_x,S_y,I_nf] = deopt('objfun',S_struct, Model_struct);

%% Calculate weights.
[d, S] = calcDeltas(currentDensityAtNeurons, nNeuronasSimuladas, FVr_x(1), FVr_x(2), FVr_x(3), FVr_x(4), C_k, threshold);
[w_] = calcW_(d,S,W);