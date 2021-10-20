function model  = Study_CreateSolStatic(model)
    fprintf('\t[-] Creating static study\n');
    
    model.study.create('std1');
    model.study('std1').create('stat', 'Stationary');
    model.study('std1').feature('stat').activate('es', true);

    model.study('std1').feature('stat').set('notlistsolnum', 1);
    model.study('std1').feature('stat').set('notsolnum', '1');
    model.study('std1').feature('stat').set('listsolnum', 1);
    model.study('std1').feature('stat').set('solnum', '1');

    model = Solution_CreateSolStatica(model);
end