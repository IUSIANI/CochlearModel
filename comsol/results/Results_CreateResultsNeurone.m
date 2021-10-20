function [V, model]  = Results_CreateResultsNeurone(model, electrodePos)
   
    %fprintf('\t[-] Solving model');

    model.result.label('Results');
    try
        model.result.dataset.create('cpt1', 'CutPoint3D');
    catch
        model.result.dataset.remove('cpt1');
        model.result.dataset.create('cpt1', 'CutPoint3D');
    end
    model.result.dataset('cpt1').label('Cut Point 3D 1');
    model.result.dataset('cpt1').set('pointx', 0);
    model.result.dataset('cpt1').set('pointy', 'arrayPos-.31');
    model.result.dataset('cpt1').set('pointz', electrodePos);

    V = mphinterp(model,'V','dataset','cpt1')';
    
end
