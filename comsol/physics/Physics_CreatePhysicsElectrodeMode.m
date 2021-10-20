function model  = Physics_CreatePhysicsElectrodeMode(model, stimulationCurrent, boundaryRadius)

    fprintf('\t[-] Adding Physics.\n');

    model.component('comp1').physics.create('ec', 'ConductiveMedia', 'geom1');
    
    model.component('comp1').physics('ec').create('fp12', 'FloatingPotential', 2);
    model.component('comp1').physics('ec').feature('fp12').selection.set([77 92]);
    model.component('comp1').physics('ec').create('fp4', 'FloatingPotential', 2);
    model.component('comp1').physics('ec').feature('fp4').selection.set([78 93]);
    model.component('comp1').physics('ec').create('fp3', 'FloatingPotential', 2);
    model.component('comp1').physics('ec').feature('fp3').selection.set([79 94]);
    model.component('comp1').physics('ec').create('fp2', 'FloatingPotential', 2);
    model.component('comp1').physics('ec').feature('fp2').selection.set([80 95]);
    model.component('comp1').physics('ec').create('fp1', 'FloatingPotential', 2);
    model.component('comp1').physics('ec').feature('fp1').selection.set([81 96]);
    
    
    model.component('comp1').physics('ec').create('fp6', 'FloatingPotential', 2);
    model.component('comp1').physics('ec').feature('fp6').selection.set([83 98]);
    model.component('comp1').physics('ec').create('fp7', 'FloatingPotential', 2);
    model.component('comp1').physics('ec').feature('fp7').selection.set([84 99]);
    model.component('comp1').physics('ec').create('fp8', 'FloatingPotential', 2);
    model.component('comp1').physics('ec').feature('fp8').selection.set([85 100]);
    model.component('comp1').physics('ec').create('fp9', 'FloatingPotential', 2);
    model.component('comp1').physics('ec').feature('fp9').selection.set([86 101]);
    model.component('comp1').physics('ec').create('fp10', 'FloatingPotential', 2);
    model.component('comp1').physics('ec').feature('fp10').selection.set([87 102]);

    model.component('comp1').physics('ec').create('ncd1', 'NormalCurrentDensity', 2);
    model.component('comp1').physics('ec').feature('ncd1').selection.set([82 97]);
    
    model.component('comp1').physics('ec').create('gnd1', 'Ground', 2);
    model.component('comp1').physics('ec').feature('gnd1').selection.set([57 58 59 60 106 107 108 109]);


    model.component('comp1').physics('ec').label('Electric Currents');
    model.component('comp1').physics('ec').prop('PortSweepSettings').set('PortParamName', 'PortName');
    model.component('comp1').physics('ec').feature('cucn1').set('minput_temperature_src', 'userdef');
    model.component('comp1').physics('ec').feature('cucn1').set('minput_numberdensity', 0);
    model.component('comp1').physics('ec').feature('cucn1').featureInfo('info').label('Equation View');
    model.component('comp1').physics('ec').feature('ein1').featureInfo('info').label('Equation View');
    model.component('comp1').physics('ec').feature('init1').featureInfo('info').label('Equation View');
    model.component('comp1').physics('ec').feature('fp12').featureInfo('info').label('Equation View');
    model.component('comp1').physics('ec').feature('fp4').featureInfo('info').label('Equation View');
    model.component('comp1').physics('ec').feature('fp3').featureInfo('info').label('Equation View');
    model.component('comp1').physics('ec').feature('fp2').featureInfo('info').label('Equation View');
    model.component('comp1').physics('ec').feature('fp1').featureInfo('info').label('Equation View');
    model.component('comp1').physics('ec').feature('fp6').featureInfo('info').label('Equation View');
    model.component('comp1').physics('ec').feature('fp7').featureInfo('info').label('Equation View');
    model.component('comp1').physics('ec').feature('fp8').featureInfo('info').label('Equation View');
    model.component('comp1').physics('ec').feature('fp9').featureInfo('info').label('Equation View');
    model.component('comp1').physics('ec').feature('fp10').featureInfo('info').label('Equation View');

    model.component('comp1').physics('ec').feature('ncd1').set('nJ', ['((', num2str(stimulationCurrent),')/(1.054*10^-7))']);
    
    model.component('comp1').physics('ec').feature('ncd1').featureInfo('info').label('Equation View');
end
