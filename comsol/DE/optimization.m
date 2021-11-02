%% Parámetros del Optimizador
Model_struct.distanciaEntreNeuronas = distanceBetweenNeurons;
Model_struct.nNeuronasSimuladas = nNeuronasSimuladas;
Model_struct.currentDensityAtNeurons = currentDensityAtNeurons;
Model_struct.C_k = C_k;
Model_struct.V = V;
Model_struct.NRT_real_k_Amplitude = NRT_real_k_Amplitude_Select;
Model_struct.NRT_real_k_Rec_Elect = NRT_real_k_Rec_Elect_Select;
Model_struct.W = W;
Model_struct.anchorElectrode = anchorElectrode;

%% Optimizar parámetros
[FVr_x,S_y,I_nf] = deopt('objfun',S_struct, Model_struct);

%% Calcular Pesos.
[d, S] = calcDeltas(currentDensityAtNeurons, nNeuronasSimuladas, FVr_x(1), FVr_x(2), FVr_x(3), FVr_x(4), C_k);
[w_] = calcW_(d,S,W);