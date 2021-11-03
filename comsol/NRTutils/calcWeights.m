function [W] = calcWeights(anchorElectrode, V)
    global I_k NRT_Interp_0
    global NRT_real_k_Rec_Elect_Select NRT_real_k_Amplitude_Select
    global InterpolationMethod
    
    ampV = getAmpOnElectrodeFromBases(anchorElectrode, V);%;max(VAnchor,[],2)-min(VAnchor,[],2);
    [numNeurons,~] = size(ampV);

    %Weigth calculation to interpolate NRT data
    for k=1:length(I_k)
        if isempty(find(NRT_real_k_Rec_Elect_Select==anchorElectrode))
            NRT_anchor = interp1(NRT_real_k_Rec_Elect_Select,NRT_real_k_Amplitude_Select(k,:),anchorElectrode,InterpolationMethod);
        else
            NRT_anchor = NRT_real_k_Amplitude_Select(k,find(NRT_real_k_Rec_Elect_Select==anchorElectrode));
        end
    
        for i=1:numNeurons
            W(i,k) = NRT_anchor/ampV(i);
        end
    end
end