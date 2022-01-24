function [probabilityEachNeuronToFire, model]  = Probability_CalculateProbabilityBetaFast(model, distanceBetweenNeurons, numNeurons, z, w, maxNormJ, C_k)
    
    %disp('Calculating probabilities');
    %model.sol('sol1').updateSolution;
    
    %Iterate on number of neurons
    probabilityEachNeuronToFire = zeros(numNeurons,length(C_k));
    
    %Generating the calls to Beta function for the case (k) to evaluate.
    eq = {};
    for k=1:length(C_k)
        eq{end+1} = ['betaDist((ec.normJ * ', num2str(C_k(k)),')/', num2str(maxNormJ*2),',', num2str(z),',', num2str(w),')/(2.738*10^-3)'];
    end
       
    for i=1:numNeurons
        model.result.dataset('pcN').set('exprz', num2str(distanceBetweenNeurons*(i-1)));
        tic
        [p1,p2,p3] = mphint2(model,eq,'line','dataset','pcN');
        toc
        probabilityEachNeuronToFire(i, 1) = p1(1);
        probabilityEachNeuronToFire(i, 2) = p2(1);
        probabilityEachNeuronToFire(i, 3) = p3(1);
    
    end
end