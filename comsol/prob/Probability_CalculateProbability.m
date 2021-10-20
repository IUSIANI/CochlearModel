function [probabilityEachNeuronToFire, model]  = Probability_CalculateProbability(model, distanceBetweenNeurons, numNeurons, u, sigma)
    %disp('Calculando probabilidades');
    % global longitudNeurona
    %Iteramos sobre el numero de neuronas
    probabilityEachNeuronToFire = zeros(numNeurons,length(C_k));
    for i=1:numNeurons
        for k=1:length(C_k)
            model.result.dataset('pcN').set('exprz', num2str(distanceBetweenNeurons*(i-1)));
            probability = mphint2(model,['(1/2)*(1+erf(( (ec.normJ * ', num2str(C_k),')-',num2str(u),')/(sqrt(2)*',num2str(sigma),')))/(2.738*10^-3)'],'line','dataset','pcN');
            probabilityEachNeuronToFire(i, k) = probability(1);
        end
    end
end