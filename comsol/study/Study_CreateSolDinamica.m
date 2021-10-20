function model  = Study_CreateSolDinamica(model)
    fprintf('\t[-] Creating dynamic study.\n');
    
    try
        model.study.create('std1');
    catch
        model.study.remove('std1');
        model.study.create('std1');
    end
    
    
    model.study('std1').create('time', 'Transient');
    
    model.study('std1').label('Study 2');
    model.study('std1').feature('time').label('Time Dependent');
    model.study('std1').feature('time').set('tunit', 'ms');
    model.study('std1').feature('time').set('tlist', 'range(0,0.02,5)');
    model.study('std1').feature('time').set('usertol', true);
    model.study('std1').feature('time').set('rtol', '0.000005');
    
    model = Solution_CreateSolDinamica(model);
end