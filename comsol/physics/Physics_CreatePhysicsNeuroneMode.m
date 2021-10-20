function model = Physics_CreatePhysicsNeuroneMode(model, selectedNeuronArray, boundaryRadius, meanMaterialConductivity, a)

    fprintf('\t[-] Adding Physics.\n');
    numNeurons = length(selectedNeuronArray);
    
    try
        model.component('comp1').physics.create('ec', 'ConductiveMedia', 'geom1');
    catch
        model.component('comp1').physics.remove('ec');
        model.component('comp1').physics.create('ec', 'ConductiveMedia', 'geom1');
    end
    
    idx = mphselectcoords(model, 'geom1', a, 'boundary','radius',0.2,'include','any');
    model.component('comp1').physics('ec').create('fp12', 'FloatingPotential', 2);
    model.component('comp1').physics('ec').feature('fp12').selection.set([idx(2) idx(14)]);
    model.component('comp1').physics('ec').create('fp4', 'FloatingPotential', 2);
    model.component('comp1').physics('ec').feature('fp4').selection.set([idx(3) idx(15)]);
    model.component('comp1').physics('ec').create('fp3', 'FloatingPotential', 2);
    model.component('comp1').physics('ec').feature('fp3').selection.set([idx(4) idx(16)]);
    model.component('comp1').physics('ec').create('fp2', 'FloatingPotential', 2);
    model.component('comp1').physics('ec').feature('fp2').selection.set([idx(5) idx(17)]);
    model.component('comp1').physics('ec').create('fp1', 'FloatingPotential', 2);
    model.component('comp1').physics('ec').feature('fp1').selection.set([idx(6) idx(18)]);
    
    model.component('comp1').physics('ec').create('fp11', 'FloatingPotential', 2);
    model.component('comp1').physics('ec').feature('fp11').selection.set([idx(7) idx(19)]);
    
    model.component('comp1').physics('ec').create('fp6', 'FloatingPotential', 2);
    model.component('comp1').physics('ec').feature('fp6').selection.set([idx(8) idx(20)]);
    model.component('comp1').physics('ec').create('fp7', 'FloatingPotential', 2);
    model.component('comp1').physics('ec').feature('fp7').selection.set([idx(9) idx(21)]);
    model.component('comp1').physics('ec').create('fp8', 'FloatingPotential', 2);
    model.component('comp1').physics('ec').feature('fp8').selection.set([idx(10) idx(22)]);
    model.component('comp1').physics('ec').create('fp9', 'FloatingPotential', 2);
    model.component('comp1').physics('ec').feature('fp9').selection.set([idx(11) idx(23)]);
    model.component('comp1').physics('ec').create('fp10', 'FloatingPotential', 2);
    model.component('comp1').physics('ec').feature('fp10').selection.set([idx(12) idx(24)]);
    
    idx = mphselectcoords(model, 'geom1', [0, 18, 0], 'boundary','radius',1,'include','any');
    model.component('comp1').physics('ec').create('fp13', 'FloatingPotential', 2);
    model.component('comp1').physics('ec').feature('fp13').selection.set(idx);
    
    idx = mphselectcoords(model, 'geom1', [-boundaryRadius 0 0; boundaryRadius 0 0]', 'boundary','radius',0.2,'include','any');
    model.component('comp1').physics('ec').create('dimp1', 'DistributedImpedance', 2);
    model.component('comp1').physics('ec').feature('dimp1').selection.set(idx);

    model.component('comp1').physics('ec').label('Electric Currents');
    model.component('comp1').physics('ec').prop('PortSweepSettings').set('PortParamName', 'PortName');
    model.component('comp1').physics('ec').feature('cucn1').set('minput_temperature_src', 'userdef');
    model.component('comp1').physics('ec').feature('cucn1').set('minput_numberdensity', 0);
    model.component('comp1').physics('ec').feature('cucn1').label('Current Conservation 1');
    model.component('comp1').physics('ec').feature('cucn1').featureInfo('info').label('Equation View');
    model.component('comp1').physics('ec').feature('ein1').label('Electric Insulation 1');
    model.component('comp1').physics('ec').feature('ein1').featureInfo('info').label('Equation View');
    model.component('comp1').physics('ec').feature('init1').label('Initial Values 1');
    model.component('comp1').physics('ec').feature('init1').featureInfo('info').label('Equation View');
    model.component('comp1').physics('ec').feature('fp12').featureInfo('info').label('Equation View');
    model.component('comp1').physics('ec').feature('fp4').featureInfo('info').label('Equation View');
    model.component('comp1').physics('ec').feature('fp3').featureInfo('info').label('Equation View');
    model.component('comp1').physics('ec').feature('fp2').featureInfo('info').label('Equation View');
    model.component('comp1').physics('ec').feature('fp1').featureInfo('info').label('Equation View');
    model.component('comp1').physics('ec').feature('fp11').featureInfo('info').label('Equation View');
    model.component('comp1').physics('ec').feature('fp6').featureInfo('info').label('Equation View');
    model.component('comp1').physics('ec').feature('fp7').featureInfo('info').label('Equation View');
    model.component('comp1').physics('ec').feature('fp8').featureInfo('info').label('Equation View');
    model.component('comp1').physics('ec').feature('fp9').featureInfo('info').label('Equation View');
    model.component('comp1').physics('ec').feature('fp10').featureInfo('info').label('Equation View');
    model.component('comp1').physics('ec').feature('dimp1').set('ds', [num2str(boundaryRadius),'[mm]']);
    model.component('comp1').physics('ec').feature('dimp1').set('sigmabnd_mat', 'userdef');
    model.component('comp1').physics('ec').feature('dimp1').set('sigmabnd', [num2str(meanMaterialConductivity),'[S/m]']);
    model.component('comp1').physics('ec').feature('dimp1').set('epsilonrbnd_mat', 'userdef');
    model.component('comp1').physics('ec').feature('dimp1').label('Distributed Impedance 1');
    model.component('comp1').physics('ec').feature('dimp1').featureInfo('info').label('Equation View');

    for i=3:(numNeurons+2)
        model.component('comp1').physics('ec').create(['lcs',num2str(i)], 'LineCurrentSource', 1);
        model.component('comp1').physics('ec').feature(['lcs',num2str(i)]).selection.set([97+(i-2)]);
        model.component('comp1').physics('ec').feature(['lcs',num2str(i)]).set('Qjl', [num2str(selectedNeuronArray(i-2)),'*',num2str(4.18879*(10^-8)),'*int1(t -(1/v)*(0.000982135 + 1.08339*x - 82.4198*x^2 + 137382.*x^3))']);
        model.component('comp1').physics('ec').feature(['lcs',num2str(i)]).label(['Line Current Source ', num2str(i-2)]);
        model.component('comp1').physics('ec').feature(['lcs',num2str(i)]).featureInfo('info').label('Equation View');
    end
    
%     model.component('comp1').physics('ec').create('lcs3', 'LineCurrentSource', 1);
%     model.component('comp1').physics('ec').feature('lcs3').selection.set([98]);
%     model.component('comp1').physics('ec').create('lcs4', 'LineCurrentSource', 1);
%     model.component('comp1').physics('ec').feature('lcs4').selection.set([99]);
%     model.component('comp1').physics('ec').create('lcs5', 'LineCurrentSource', 1);
%     model.component('comp1').physics('ec').feature('lcs5').selection.set([100]);
%     model.component('comp1').physics('ec').create('lcs6', 'LineCurrentSource', 1);
%     model.component('comp1').physics('ec').feature('lcs6').selection.set([101]);
%     model.component('comp1').physics('ec').create('lcs7', 'LineCurrentSource', 1);
%     model.component('comp1').physics('ec').feature('lcs7').selection.set([102]);
%     model.component('comp1').physics('ec').create('lcs8', 'LineCurrentSource', 1);
%     model.component('comp1').physics('ec').feature('lcs8').selection.set([103]);
%     model.component('comp1').physics('ec').create('lcs9', 'LineCurrentSource', 1);
%     model.component('comp1').physics('ec').feature('lcs9').selection.set([104]);
%     model.component('comp1').physics('ec').create('lcs10', 'LineCurrentSource', 1);
%     model.component('comp1').physics('ec').feature('lcs10').selection.set([105]);
%     model.component('comp1').physics('ec').create('lcs11', 'LineCurrentSource', 1);
%     model.component('comp1').physics('ec').feature('lcs11').selection.set([106]);
%     model.component('comp1').physics('ec').create('lcs12', 'LineCurrentSource', 1);
%     model.component('comp1').physics('ec').feature('lcs12').selection.set([107]);
%     model.component('comp1').physics('ec').create('lcs13', 'LineCurrentSource', 1);
%     model.component('comp1').physics('ec').feature('lcs13').selection.set([108]);
%     
%     model.component('comp1').physics('ec').feature('lcs3').set('Qjl', [num2str(selectedNeuronArray(1)),'*',num2str(4.18879*(10^-8)),'*int1(t -(1/v)*(0.000982135 + 1.08339*x - 82.4198*x^2 + 137382.*x^3))']);
%     model.component('comp1').physics('ec').feature('lcs3').label('Line Current Source 1');
%     model.component('comp1').physics('ec').feature('lcs3').featureInfo('info').label('Equation View');
%     model.component('comp1').physics('ec').feature('lcs4').set('Qjl', [num2str(selectedNeuronArray(2)),'*',num2str(4.18879*(10^-8)),'*int1(t -(1/v)*(0.000982135 + 1.08339*x - 82.4198*x^2 + 137382.*x^3))']);
%     model.component('comp1').physics('ec').feature('lcs4').label('Line Current Source 2');
%     model.component('comp1').physics('ec').feature('lcs4').featureInfo('info').label('Equation View');
%     model.component('comp1').physics('ec').feature('lcs5').set('Qjl', [num2str(selectedNeuronArray(3)),'*',num2str(4.18879*(10^-8)),'*int1(t -(1/v)*(0.000982135 + 1.08339*x - 82.4198*x^2 + 137382.*x^3))']);
%     model.component('comp1').physics('ec').feature('lcs5').label('Line Current Source 3');
%     model.component('comp1').physics('ec').feature('lcs5').featureInfo('info').label('Equation View');
%     model.component('comp1').physics('ec').feature('lcs6').set('Qjl', [num2str(selectedNeuronArray(4)),'*',num2str(4.18879*(10^-8)),'*int1(t -(1/v)*(0.000982135 + 1.08339*x - 82.4198*x^2 + 137382.*x^3))']);
%     model.component('comp1').physics('ec').feature('lcs6').label('Line Current Source 4');
%     model.component('comp1').physics('ec').feature('lcs6').featureInfo('info').label('Equation View');
%     model.component('comp1').physics('ec').feature('lcs7').set('Qjl', [num2str(selectedNeuronArray(5)),'*',num2str(4.18879*(10^-8)),'*int1(t -(1/v)*(0.000982135 + 1.08339*x - 82.4198*x^2 + 137382.*x^3))']);
%     model.component('comp1').physics('ec').feature('lcs7').label('Line Current Source 5');
%     model.component('comp1').physics('ec').feature('lcs7').featureInfo('info').label('Equation View');
%     model.component('comp1').physics('ec').feature('lcs8').set('Qjl', [num2str(selectedNeuronArray(6)),'*',num2str(4.18879*(10^-8)),'*int1(t -(1/v)*(0.000982135 + 1.08339*x - 82.4198*x^2 + 137382.*x^3))']);
%     model.component('comp1').physics('ec').feature('lcs8').label('Line Current Source 6');
%     model.component('comp1').physics('ec').feature('lcs8').featureInfo('info').label('Equation View');
%     model.component('comp1').physics('ec').feature('lcs9').set('Qjl', [num2str(selectedNeuronArray(7)),'*',num2str(4.18879*(10^-8)),'*int1(t -(1/v)*(0.000982135 + 1.08339*x - 82.4198*x^2 + 137382.*x^3))']);
%     model.component('comp1').physics('ec').feature('lcs9').label('Line Current Source 7');
%     model.component('comp1').physics('ec').feature('lcs9').featureInfo('info').label('Equation View');
%     model.component('comp1').physics('ec').feature('lcs10').set('Qjl', [num2str(selectedNeuronArray(8)),'*',num2str(4.18879*(10^-8)),'*int1(t -(1/v)*(0.000982135 + 1.08339*x - 82.4198*x^2 + 137382.*x^3))']);
%     model.component('comp1').physics('ec').feature('lcs10').label('Line Current Source 8');
%     model.component('comp1').physics('ec').feature('lcs10').featureInfo('info').label('Equation View');
%     model.component('comp1').physics('ec').feature('lcs11').set('Qjl', [num2str(selectedNeuronArray(9)),'*',num2str(4.18879*(10^-8)),'*int1(t -(1/v)*(0.000982135 + 1.08339*x - 82.4198*x^2 + 137382.*x^3))']);
%     model.component('comp1').physics('ec').feature('lcs11').label('Line Current Source 9');
%     model.component('comp1').physics('ec').feature('lcs11').featureInfo('info').label('Equation View');
%     model.component('comp1').physics('ec').feature('lcs12').set('Qjl', [num2str(selectedNeuronArray(10)),'*',num2str(4.18879*(10^-8)),'*int1(t -(1/v)*(0.000982135 + 1.08339*x - 82.4198*x^2 + 137382.*x^3))']);
%     model.component('comp1').physics('ec').feature('lcs12').label('Line Current Source 10');
%     model.component('comp1').physics('ec').feature('lcs12').featureInfo('info').label('Equation View');
%     model.component('comp1').physics('ec').feature('lcs13').set('Qjl', [num2str(selectedNeuronArray(11)),'*',num2str(4.18879*(10^-8)),'*int1(t -(1/v)*(0.000982135 + 1.08339*x - 82.4198*x^2 + 137382.*x^3))']);
%     model.component('comp1').physics('ec').feature('lcs13').label('Line Current Source 11');
%     model.component('comp1').physics('ec').feature('lcs13').featureInfo('info').label('Equation View');
end
