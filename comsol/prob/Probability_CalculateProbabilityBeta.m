function [probabilityEachNeuronToFire, model]  = Probability_CalculateProbabilityBeta(model, distanceBetweenNeurons, numNeurons, z, w, maxNormJ, C_k)
    %disp('Calculating probabilities');
    model.sol('sol1').updateSolution;
    
    %Iterate on number of neurons
    probabilityEachNeuronToFire = zeros(numNeurons,length(C_k));
    for i=1:numNeurons
        for k=1:length(C_k)
            model.result.dataset('pcN').set('exprz', num2str(distanceBetweenNeurons*(i-1)));
            tic
            %['betaDist((ec.normJ * ', num2str(C_k(k)),')/', num2str(maxNormJ*2),',', num2str(z),',', num2str(w),')/(2.738*10^-3)']
            %out = mpheval(model,'ec.normJ','dataset','pcN','dataonly','on')
            probability = mphint2(model,['betaDist((ec.normJ * ', num2str(C_k(k)),')/', num2str(maxNormJ*2),',', num2str(z),',', num2str(w),')/(2.738*10^-3)'],'line','dataset','pcN');
            toc
            probabilityEachNeuronToFire(i, k) = probability(1);
        end
    end
end