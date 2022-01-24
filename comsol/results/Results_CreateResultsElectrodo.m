function [currentDensityAtNeurons, model]  = Results_CreateResultsElectrodo(model, distanceBetweenNeurons, numNeurons)
    %fprintf('\t[-] Solving model\n')
    
    model.result.label('Results');
    try
        model.result.dataset.create('dset2', 'Solution');
        model.result.dataset.create('pcN', 'ParCurve3D'); 
    catch
        model.result.dataset.remove('dset2');
        model.result.dataset.remove('pcN');
        model.result.dataset.create('dset2', 'Solution');
        model.result.dataset.create('pcN', 'ParCurve3D'); 
    end
    model.result.dataset('pcN').set('data', 'dset2');
    model.result.dataset('pcN').set('parmin1', 0.01);
    model.result.dataset('pcN').set('exprx', '-2.2307*(0.355591 - s)');
    model.result.dataset('pcN').set('expry', '0.09  + 0.5*(-1.02117 + 0.65725*sqrt(0.01 + 4.12373*(0.355591 - s)^2)+ 0.684478*(0.355591 - s) + 3.787*(0.355591 - s)^2)');


    %Iterate on number of neurons
    currentDensityAtNeurons = [];
    for i=0:(numNeurons-1)
       model.result.dataset('pcN').set('exprz', num2str(distanceBetweenNeurons*i));
       currentDensity=mphinterp(model,'ec.normJ','dataset','pcN');
       currentDensityAtNeurons = [currentDensityAtNeurons;currentDensity(1,:)];
    end
end
