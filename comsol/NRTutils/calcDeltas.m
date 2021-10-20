function [d,S]=calcDeltas(currentDensityAtNeurons, nNeuronasSimuladas, alpha, beta, jmin, jmax, C_k)
	global longitudNeurona

	%Create nerveWeight values based on current density
	d = zeros(nNeuronasSimuladas,length(C_k));

	x = linspace(longitudNeurona/1000, longitudNeurona, 1000);

	for i=1:nNeuronasSimuladas
	    for k=1:length(C_k)
	        j=(currentDensityAtNeurons(i,:) * C_k(k));
	        try
	            a = betainc(((j-jmin)/(jmax-jmin)), alpha, beta) /(longitudNeurona);
	            probability = trapz(x,a);
	        catch
	            probability = 0;
	        end

	        d(i, k) = probability(1);
	    end
	end

    S = sum(d);
end