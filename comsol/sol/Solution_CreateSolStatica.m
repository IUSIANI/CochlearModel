function model  = Solution_CreateSolStatica(model)
    fprintf('\t[-] Solving static study.\n');
    
    try
        model.sol.create('sol1');
    catch
        model.sol.remove('sol1');
        model.sol.create('sol1');
    end
    
    model.sol('sol1').study('std1');
    model.sol('sol1').create('st1', 'StudyStep');
    model.sol('sol1').feature('st1').set('study', 'std1');
    model.sol('sol1').feature('st1').set('studystep', 'stat');
    model.sol('sol1').create('v1', 'Variables');
    model.sol('sol1').feature('v1').set('control', 'stat');
    model.sol('sol1').create('s1', 'Stationary');
    model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
    model.sol('sol1').feature('s1').create('i1', 'Iterative');
    model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'cg');
    model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
    model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'amg');
    model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'i1');
    model.sol('sol1').feature('s1').feature.remove('fcDef');
    model.sol('sol1').attach('std1');
    model.sol('sol1').runAll;
end