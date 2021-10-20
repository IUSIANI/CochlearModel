function [probabilityEachNeuronToFire, model]  = Probability_CalculateProbabilityLineMatlab(model, currentDensityAtNeurons, numNeurons, A, B, jmin, jmax, C_k)
    
    probabilityEachNeuronToFire = zeros(numNeurons,length(C_k));
    for i=1:numNeurons
        for k=1:length(C_k)
            probability = (C_k(k) * A * 0.45643) + B;
            probabilityEachNeuronToFire(i, k) = probability(1);
        end
    end
end