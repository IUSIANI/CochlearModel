function [probabilityEachNeuronToFire, model]  = Probability_CalculateProbabilityPolyMatlab(model, currentDensityAtNeurons, numNeurons, A, B, C_k)
    
    x=[2.738*10^-3/1000:2.738*10^-3/1000:2.738*10^-3];
    probabilityEachNeuronToFire = zeros(numNeurons,length(C_k));

    for i=1:numNeurons
        for k=1:length(C_k)
            
            j = (currentDensityAtNeurons(10,:) * C_k(k));
            a = trapz(x,j);
            probability=poly(a, A(i), B(i));
            
            %probability=poly(C_k(k), A, B, C, D);
            
            probabilityEachNeuronToFire(i, k) = probability;
        end
    end
end