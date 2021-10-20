function model  = Solution_CreateSolDinamica(model)
    fprintf('\t[-] Solving dynamic study.\n');
    
    try
        model.sol.create('sol1');
    catch
        model.sol.remove('sol1');
        model.sol.create('sol1');
    end
    
    model.sol('sol1').study('std1');
    model.sol('sol1').attach('std1');
    model.sol('sol1').create('st1', 'StudyStep');
    model.sol('sol1').create('v1', 'Variables');
    model.sol('sol1').create('t1', 'Time');
    model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
    model.sol('sol1').feature('t1').create('i1', 'Iterative');
    model.sol('sol1').feature('t1').feature('i1').create('mg1', 'Multigrid');
    model.sol('sol1').feature('t1').feature.remove('fcDef');

    model.sol('sol1').attach('std1');
    model.sol('sol1').label('Solution 2');
    model.sol('sol1').feature('v1').label('Dependent Variables 1');
    model.sol('sol1').feature('v1').set('clist', 'range(0,0.02,5)');
    model.sol('sol1').feature('t1').label('Time-Dependent Solver 1');
    model.sol('sol1').feature('t1').set('tunit', 'ms');
    model.sol('sol1').feature('t1').set('tlist', 'range(0,0.02,5)');
    model.sol('sol1').feature('t1').set('rtol', '0.000005');
    model.sol('sol1').feature('t1').feature('i1').label('Iterative 1');
    model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'cg');
    model.sol('sol1').feature('t1').feature('i1').feature('ilDef').label('Incomplete LU');
    model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('prefun', 'amg');
    model.sol('sol1').runAll;
end

