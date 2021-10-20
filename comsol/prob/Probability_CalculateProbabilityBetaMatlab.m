function [probabilityEachNeuronToFire, model]  = Probability_CalculateProbabilityBetaMatlab(model, currentDensityAtNeurons, numNeurons, z, w, jmin, jmax, C_k)
    
    x=[2.738*10^-3/1000:2.738*10^-3/1000:2.738*10^-3];
    probabilityEachNeuronToFire = zeros(numNeurons,length(C_k));
    for i=1:numNeurons
        for k=1:length(C_k)
            j=(currentDensityAtNeurons(i,:) * C_k(k));
            a=betaDist(((j-jmin)/(jmax-jmin)),z,w) /(2.738*10^-3);
            probability = trapz(x,a);
            
            probabilityEachNeuronToFire(i, k) = probability(1);
        end
    end
end