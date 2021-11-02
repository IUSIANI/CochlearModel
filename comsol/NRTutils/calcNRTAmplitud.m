 function [NRTAmplitud] = calcNRTAmplitud(V,d,S,W)
    global NRT_real_k_Amplitude NRT_real_k_Rec_Elect
    global C_k 
    
    nNeuronasSimuladas = size(W,1);
    
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
    
    %% PRUEBAS
%     for m=1:length(NRT_real_k_Rec_Elect)
%         ampV = getAmpOnElectrodeFromBases(NRT_real_k_Rec_Elect(m), V);
%         NRTAmplitud2(:,m) = sum(d/S.*W*ampV');
%     end
%     disp(NRTAmplitud == NRTAmplitud2)
    
end