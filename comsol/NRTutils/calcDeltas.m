function [d,S]=calcDeltas(currentDensityAtNeurons, nNeuronasSimuladas, alpha, beta, jmin, jmax, C_k, threshold)
    global longitudNeurona
    global numDeadVN

    if nargin <8
        threshold = 0;
    end
    
    %Create nerveWeight values based on current density
    d = zeros(nNeuronasSimuladas,length(C_k));

    x = linspace(longitudNeurona/1000, longitudNeurona, 1000);    
    for i=1:nNeuronasSimuladas
        for k=1:length(C_k)
            j=(currentDensityAtNeurons(i,:) * C_k(k));
            % j(j< threshold) = 0;

            try
                a = betainc(((j-jmin)/(jmax-jmin)), alpha, beta) /(longitudNeurona);
                probability = trapz(x,a);
            catch
                d = NaN(nNeuronasSimuladas, length(C_k));
                S = NaN(length(C_k),1);
                return
            end

            d(i, k) = probability(1);
        end
    end

    if (numDeadVN>0)
        %This is for dead region
        d([round(length(d)/2)-numDeadVN:round(length(d)/2)+numDeadVN],:)=0;
    end
    
    S = sum(d);
end