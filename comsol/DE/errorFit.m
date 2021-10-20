function [error, NRTAmplitudAll, model] = errorFit(model, currentDensityAtNeurons, nNeuronasSimuladas, alpha, beta, jmin, jmax, C_k, WAll, V, NRT_real_k_Amplitude, NRT_real_k_Rec_Elect)
    

    error = 0;
    num_error = 0;    
    
    NRTAmplitudAll = cell(length(WAll),1);
    
    for selectAnchorIndex=1:length(WAll)
        W = WAll{selectAnchorIndex};
        
        %Create nerveWeight values based on current density
        [d,S]=calcDeltas(currentDensityAtNeurons, nNeuronasSimuladas, alpha, beta, jmin, jmax, C_k);


        % 
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

        %Obtenemos el error
        for k=1:length(C_k)
            for m=1:length(NRT_real_k_Amplitude)
                error = error + (NRTAmplitud(k,m) - NRT_real_k_Amplitude(k,m))^4;
                num_error = num_error+1;
            end
        end
        NRTAmplitudAll{selectAnchorIndex} = NRTAmplitud;
    end
    error = error / num_error;
end