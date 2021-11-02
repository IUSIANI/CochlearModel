function [error, NRTAmplitud] = errorFit(currentDensityAtNeurons, nNeuronasSimuladas, alpha, beta, jmin, jmax, C_k, W, V, NRT_real_k_Amplitude, NRT_real_k_Rec_Elect)
    

    error = 0;
    num_error = 0;    
    
        
    %Create nerveWeight values based on current density
    [d,S]=calcDeltas(currentDensityAtNeurons, nNeuronasSimuladas, alpha, beta, jmin, jmax, C_k);

    NRTAmplitud = calcNRTAmplitud(V,d,S,W);

    %Obtenemos el error
    for k=1:length(C_k)
        for m=1:length(NRT_real_k_Amplitude)
            error = error + (NRTAmplitud(k,m) - NRT_real_k_Amplitude(k,m))^4;
            num_error = num_error+1;
        end
    end
error = error / num_error;
end