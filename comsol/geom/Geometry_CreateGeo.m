function model  = Geometry_CreateGeo(model, distanceBetweenNeurons, numNeurons, boundaryRadius)

    fprintf('\t[-] Creating geometry.\n');
    
    model.component('comp1').geom('geom1').label('Geometry 1');
    
    model.component('comp1').geom('geom1').lengthUnit('mm');   
    model.component('comp1').geom('geom1').create('sph1', 'Sphere');
    model.component('comp1').geom('geom1').feature('sph1').set('r', boundaryRadius);
    model.component('comp1').geom('geom1').create('sph2', 'Sphere');
    model.component('comp1').geom('geom1').feature('sph2').set('pos', [0 18 0]);
    model.component('comp1').geom('geom1').feature('sph2').set('r', '.5');
    model.component('comp1').geom('geom1').create('dif2', 'Difference');
    model.component('comp1').geom('geom1').feature('dif2').selection('input').set({'sph1'});
    model.component('comp1').geom('geom1').feature('dif2').selection('input2').set({'sph2'});
    model.component('comp1').geom('geom1').create('wp1', 'WorkPlane');
    model.component('comp1').geom('geom1').feature('wp1').label('Cochlea');
    model.component('comp1').geom('geom1').feature('wp1').set('unite', true);
    model.component('comp1').geom('geom1').feature('wp1').geom.create('pol1', 'Polygon');
    model.component('comp1').geom('geom1').feature('wp1').geom.feature('pol1').label('Scala Vestibular');
    model.component('comp1').geom('geom1').feature('wp1').geom.feature('pol1').set('source', 'table');
    model.component('comp1').geom('geom1').feature('wp1').geom.feature('pol1').set('table', {'-0.066667' '-0.643333';  ...
    '0.020000' '-0.616667';  ...
    '0.040000' '-0.556667';  ...
    '0.273333' '-0.483333';  ...
    '0.520000' '-0.523333';  ...
    '0.793333' '-0.763333';  ...
    '0.860000' '-1.136667';  ...
    '0.620000' '-1.456667';  ...
    '0.433333' '-1.583333';  ...
    '0.146667' '-1.696667';  ...
    '-0.013333' '-1.770000';  ...
    '-0.293333' '-1.750000';  ...
    '-0.606667' '-1.616667';  ...
    '-0.726667' '-1.443333';  ...
    '-0.873333' '-1.250000';  ...
    '-0.473333' '-0.956667'});
    model.component('comp1').geom('geom1').feature('wp1').geom.create('pol2', 'Polygon');
    model.component('comp1').geom('geom1').feature('wp1').geom.feature('pol2').label('Scala Timpanica');
    model.component('comp1').geom('geom1').feature('wp1').geom.feature('pol2').set('source', 'table');
    model.component('comp1').geom('geom1').feature('wp1').geom.feature('pol2').set('table', {'-0.780000' '-0.476667';  ...
    '-0.600000' '-0.423333';  ...
    '-0.406667' '-0.410000';  ...
    '-0.233333' '-0.330000';  ...
    '0.093333' '-0.343333';  ...
    '0.460000' '-0.296667';  ...
    '0.733333' '-0.016667';  ...
    '0.900000' '0.330000';  ...
    '0.900000' '0.643333';  ...
    '0.680000' '1.023333';  ...
    '0.386667' '1.210000';  ...
    '-0.053333' '1.210000';  ...
    '-0.373333' '1.096667';  ...
    '-0.713333' '0.783333';  ...
    '-1.006667' '0.283333';  ...
    '-1.100000' '-0.090000';  ...
    '-0.940000' '-0.323333'});
    model.component('comp1').geom('geom1').feature('wp1').geom.create('pol3', 'Polygon');
    model.component('comp1').geom('geom1').feature('wp1').geom.feature('pol3').active(false);
    model.component('comp1').geom('geom1').feature('wp1').geom.feature('pol3').set('source', 'table');
    model.component('comp1').geom('geom1').feature('wp1').geom.feature('pol3').set('table', {'-0.606667' '-1.616667';  ...
    '-0.780000' '-1.470000';  ...
    '-0.980000' '-1.223333';  ...
    '-1.013333' '-0.916667';  ...
    '-0.926667' '-0.683333';  ...
    '-0.866667' '-0.636667';  ...
    '-0.860000' '-0.730000';  ...
    '-0.953333' '-0.890000';  ...
    '-0.960000' '-1.076667';  ...
    '-0.873333' '-1.250000';  ...
    '-0.726667' '-1.443333'});
    model.component('comp1').geom('geom1').feature('wp1').geom.create('pol4', 'Polygon');
    model.component('comp1').geom('geom1').feature('wp1').geom.feature('pol4').active(false);
    model.component('comp1').geom('geom1').feature('wp1').geom.feature('pol4').set('source', 'table');
    model.component('comp1').geom('geom1').feature('wp1').geom.feature('pol4').set('table', {'-0.606667' '-1.616667';  ...
    '-0.933333' '-1.396667';  ...
    '-1.126667' '-1.116667';  ...
    '-1.220000' '-0.723333';  ...
    '-1.246667' '-0.476667';  ...
    '-1.173333' '-0.243333';  ...
    '-0.940000' '-0.323333';  ...
    '-0.780000' '-0.476667';  ...
    '-0.873333' '-0.563333';  ...
    '-0.866667' '-0.636667';  ...
    '-0.926667' '-0.683333';  ...
    '-1.013333' '-0.916667';  ...
    '-0.980000' '-1.223333';  ...
    '-0.780000' '-1.470000'});
    model.component('comp1').geom('geom1').feature('wp1').geom.create('pol5', 'Polygon');
    model.component('comp1').geom('geom1').feature('wp1').geom.feature('pol5').label('Scala Media');
    model.component('comp1').geom('geom1').feature('wp1').geom.feature('pol5').set('source', 'table');
    model.component('comp1').geom('geom1').feature('wp1').geom.feature('pol5').set('table', {'-0.873333' '-1.250000';  ...
    '-0.960000' '-1.076667';  ...
    '-0.953333' '-0.890000';  ...
    '-0.860000' '-0.730000';  ...
    '-0.866667' '-0.636667';  ...
    '-0.746667' '-0.610000';  ...
    '-0.580000' '-0.563333';  ...
    '-0.433333' '-0.576667';  ...
    '-0.260000' '-0.570000';  ...
    '-0.173333' '-0.623333';  ...
    '-0.066667' '-0.643333';  ...
    '-0.473333' '-0.956667'});
    model.component('comp1').geom('geom1').feature('wp1').geom.create('pol6', 'Polygon');
    model.component('comp1').geom('geom1').feature('wp1').geom.feature('pol6').label('Organo Corti');
    model.component('comp1').geom('geom1').feature('wp1').geom.feature('pol6').set('source', 'table');
    model.component('comp1').geom('geom1').feature('wp1').geom.feature('pol6').set('table', {'-0.866667' '-0.636667';  ...
    '-0.873333' '-0.563333';  ...
    '-0.780000' '-0.476667';  ...
    '-0.600000' '-0.423333';  ...
    '-0.406667' '-0.410000';  ...
    '-0.080000' '-0.443333';  ...
    '0.166667' '-0.470000';  ...
    '0.273333' '-0.483333';  ...
    '0.040000' '-0.556667';  ...
    '0.020000' '-0.616667';  ...
    '-0.066667' '-0.643333';  ...
    '-0.173333' '-0.623333';  ...
    '-0.260000' '-0.570000';  ...
    '-0.433333' '-0.576667';  ...
    '-0.580000' '-0.563333';  ...
    '-0.746667' '-0.610000'});
    model.component('comp1').geom('geom1').feature('wp1').geom.create('pol7', 'Polygon');
    model.component('comp1').geom('geom1').feature('wp1').geom.feature('pol7').label('Nervio');
    model.component('comp1').geom('geom1').feature('wp1').geom.feature('pol7').set('source', 'table');
    model.component('comp1').geom('geom1').feature('wp1').geom.feature('pol7').set('table', {'-0.376667' '-0.405000';  ...
    '-0.233333' '-0.3450000';  ...
    '0.093333' '-0.362';  ...
    '0.460000' '-0.32';  ...
    '0.753333' '-0.025';  ...
    '0.92500' '0.330000';  ...
    '0.93000' '0.643333';  ...
    '0.840000' '1.096667';  ...
    '0.826667' '1.403333';  ...
    '0.800000' '1.576667';  ...
    '1.193333' '1.770000';  ...
    '1.426667' '1.650000';  ...
    '1.420000' '0.976667';  ...
    '1.273333' '0.203333';  ...
    '1.086667' '-0.276667';  ...
    '0.840000' '-0.516667';  ...
    '0.520000' '-0.503333';  ...
    '0.273333' '-0.463333';  ...
    '0.166667' '-0.450000';  ...
    '-0.080000' '-0.423333'});
    model.component('comp1').geom('geom1').feature('wp1').geom.create('pol8', 'Polygon');
    model.component('comp1').geom('geom1').feature('wp1').geom.feature('pol8').label('Hueso Intermedio');
    model.component('comp1').geom('geom1').feature('wp1').geom.feature('pol8').set('source', 'table');
    model.component('comp1').geom('geom1').feature('wp1').geom.feature('pol8').set('table', {'0.680000' '1.023333';  ...
    '0.900000' '0.643333';  ...
    '0.900000' '0.330000';  ...
    '0.733333' '-0.016667';  ...
    '0.460000' '-0.296667';  ...
    '0.093333' '-0.343333';  ...
    '-0.233333' '-0.330000';  ...
    '-0.406667' '-0.410000';  ...
    '-0.080000' '-0.443333';  ...
    '0.166667' '-0.470000';  ...
    '0.273333' '-0.483333';  ...
    '0.520000' '-0.523333';  ...
    '0.793333' '-0.763333';  ...
    '0.840000' '-0.516667';  ...
    '0.520000' '-0.503333';  ...
    '0.273333' '-0.463333';  ...
    '0.166667' '-0.450000';  ...
    '-0.080000' '-0.423333';  ...
    '-0.376667' '-0.405000';  ...
    '-0.233333' '-0.3450000';  ...
    '0.093333' '-0.362';  ...
    '0.460000' '-0.32';  ...
    '0.753333' '-0.025';  ...
    '0.92500' '0.330000';  ...
    '0.93000' '0.643333';  ...
    '0.840000' '1.096667'});
    model.component('comp1').geom('geom1').create('rot1', 'Rotate');
    model.component('comp1').geom('geom1').feature('rot1').set('pos', '0 0 0');
    model.component('comp1').geom('geom1').feature('rot1').setIndex('rot', '-40.999999', 0);
    model.component('comp1').geom('geom1').feature('rot1').selection('input').set({'wp1'});
    model.component('comp1').geom('geom1').create('mov1', 'Move');
    model.component('comp1').geom('geom1').feature('mov1').setIndex('displx', '-0.3295', 0);
    model.component('comp1').geom('geom1').feature('mov1').setIndex('disply', '0.273641', 0);
    model.component('comp1').geom('geom1').feature('mov1').selection('input').set({'rot1'});
    model.component('comp1').geom('geom1').create('ext3', 'Extrude');
    model.component('comp1').geom('geom1').feature('ext3').set('extrudefrom', 'faces');
    model.component('comp1').geom('geom1').feature('ext3').setIndex('distance', '9', 0);
    model.component('comp1').geom('geom1').feature('ext3').selection('inputface').set('mov1(1)', [1 2 3 4 5 6]);
    model.component('comp1').geom('geom1').create('uni1', 'Union');
    model.component('comp1').geom('geom1').feature('uni1').selection('input').set({'ext3(1)'});
    model.component('comp1').geom('geom1').create('mov2', 'Move');
    model.component('comp1').geom('geom1').feature('mov2').setIndex('displz', '-4.5', 0);
    model.component('comp1').geom('geom1').feature('mov2').selection('input').set({'uni1'});
    
    model.component('comp1').geom('geom1').create('cyl2', 'Cylinder');
    model.component('comp1').geom('geom1').feature('cyl2').set('pos', [0 0 -4.5]);
    model.component('comp1').geom('geom1').feature('cyl2').set('r', '.3');
    model.component('comp1').geom('geom1').feature('cyl2').set('h', 9);
    model.component('comp1').geom('geom1').create('csur1', 'ConvertToSurface');
    model.component('comp1').geom('geom1').feature('csur1').selection('input').set({'cyl2'});
    model.component('comp1').geom('geom1').create('blk1', 'Block');
    model.component('comp1').geom('geom1').feature('blk1').set('pos', {'0' '0-blockElectrodePos+0.17' '0'});
    model.component('comp1').geom('geom1').feature('blk1').set('base', 'center');
    model.component('comp1').geom('geom1').feature('blk1').set('size', {'.33' '.05' '0.3'});
    model.component('comp1').geom('geom1').create('blk2', 'Block');
    model.component('comp1').geom('geom1').feature('blk2').set('pos', {'0' '0-blockElectrodePos+0.17' '.7'});
    model.component('comp1').geom('geom1').feature('blk2').set('base', 'center');
    model.component('comp1').geom('geom1').feature('blk2').set('size', {'.33' '0.05' '0.3'});
    model.component('comp1').geom('geom1').create('blk3', 'Block');
    model.component('comp1').geom('geom1').feature('blk3').set('pos', {'0' '0-blockElectrodePos+0.17' '-.7'});
    model.component('comp1').geom('geom1').feature('blk3').set('base', 'center');
    model.component('comp1').geom('geom1').feature('blk3').set('size', {'.33' '0.05' '0.3'});
    model.component('comp1').geom('geom1').create('blk4', 'Block');
    model.component('comp1').geom('geom1').feature('blk4').set('pos', {'0' '0-blockElectrodePos+0.17' '1.4'});
    model.component('comp1').geom('geom1').feature('blk4').set('base', 'center');
    model.component('comp1').geom('geom1').feature('blk4').set('size', {'.33' '.05' '0.3'});
    model.component('comp1').geom('geom1').create('blk5', 'Block');
    model.component('comp1').geom('geom1').feature('blk5').set('pos', {'0' '0-blockElectrodePos+0.17' '-1.4'});
    model.component('comp1').geom('geom1').feature('blk5').set('base', 'center');
    model.component('comp1').geom('geom1').feature('blk5').set('size', {'.33' '0.05' '0.3'});
    model.component('comp1').geom('geom1').create('blk6', 'Block');
    model.component('comp1').geom('geom1').feature('blk6').set('pos', {'0' '0-blockElectrodePos+0.17' '2.1'});
    model.component('comp1').geom('geom1').feature('blk6').set('base', 'center');
    model.component('comp1').geom('geom1').feature('blk6').set('size', {'.33' '0.05' '0.3'});
    model.component('comp1').geom('geom1').create('blk7', 'Block');
    model.component('comp1').geom('geom1').feature('blk7').set('pos', {'0' '0-blockElectrodePos+0.17' '-2.1'});
    model.component('comp1').geom('geom1').feature('blk7').set('base', 'center');
    model.component('comp1').geom('geom1').feature('blk7').set('size', {'.33' '0.05' '0.3'});
    model.component('comp1').geom('geom1').create('blk8', 'Block');
    model.component('comp1').geom('geom1').feature('blk8').set('pos', {'0' '0-blockElectrodePos+0.17' '2.8'});
    model.component('comp1').geom('geom1').feature('blk8').set('base', 'center');
    model.component('comp1').geom('geom1').feature('blk8').set('size', {'.33' '0.05' '0.3'});
    model.component('comp1').geom('geom1').create('blk9', 'Block');
    model.component('comp1').geom('geom1').feature('blk9').set('pos', {'0' '0-blockElectrodePos+0.17' '-2.8'});
    model.component('comp1').geom('geom1').feature('blk9').set('base', 'center');
    model.component('comp1').geom('geom1').feature('blk9').set('size', {'.33' '0.05' '0.3'});
    model.component('comp1').geom('geom1').create('blk10', 'Block');
    model.component('comp1').geom('geom1').feature('blk10').set('pos', {'0' '0-blockElectrodePos+0.17' '3.5'});
    model.component('comp1').geom('geom1').feature('blk10').set('base', 'center');
    model.component('comp1').geom('geom1').feature('blk10').set('size', {'.33' '0.05' '0.3'});
    model.component('comp1').geom('geom1').create('blk11', 'Block');
    model.component('comp1').geom('geom1').feature('blk11').set('pos', {'0' '0-blockElectrodePos+0.17' '-3.5'});
    model.component('comp1').geom('geom1').feature('blk11').set('base', 'center');
    model.component('comp1').geom('geom1').feature('blk11').set('size', {'.33' '.05' '0.3'});
    model.component('comp1').geom('geom1').create('uni2', 'Union');
    model.component('comp1').geom('geom1').feature('uni2').selection('input').set({'blk1' 'blk10' 'blk11' 'blk2' 'blk3' 'blk4' 'blk5' 'blk6' 'blk7' 'blk8'  ...
    'blk9'});
    model.component('comp1').geom('geom1').create('int1', 'Intersection');
    model.component('comp1').geom('geom1').feature('int1').selection('input').set({'csur1' 'uni2'});
    model.component('comp1').geom('geom1').create('cyl3', 'Cylinder');
    model.component('comp1').geom('geom1').feature('cyl3').set('pos', [0 0 -4.5]);
    model.component('comp1').geom('geom1').feature('cyl3').set('r', '.3');
    model.component('comp1').geom('geom1').feature('cyl3').set('h', 9);
    model.component('comp1').geom('geom1').create('uni4', 'Union');
    model.component('comp1').geom('geom1').feature('uni4').selection('input').set({'cyl3' 'int1'});
    model.component('comp1').geom('geom1').create('mov2400', 'Move');
    model.component('comp1').geom('geom1').feature('mov2400').set('disply', 'arrayPos');
    model.component('comp1').geom('geom1').feature('mov2400').selection('input').set({'uni4'});
    
    model.component('comp1').geom('geom1').create('dif1', 'Difference');
    model.component('comp1').geom('geom1').feature('dif1').selection('input').set({'mov2' 'dif2'});
    model.component('comp1').geom('geom1').feature('dif1').selection('input2').set({'mov2400'});
    model.component('comp1').geom('geom1').create('pc1', 'ParametricCurve');
    model.component('comp1').geom('geom1').feature('pc1').set('parmin', 0.01);
    model.component('comp1').geom('geom1').feature('pc1').set('coord', {'-2.2307*(0.355591 - s)' '0.09  + 0.5*(-1.02117 + 0.65725*sqrt(0.01 + 4.12373*(0.355591 - s)^2)+ 0.684478*(0.355591 - s) + 3.787*(0.355591 - s)^2)' '0'});
    model.component('comp1').geom('geom1').create('uni3', 'Union');
    model.component('comp1').geom('geom1').feature('uni3').selection('input').set({'pc1'});
    if (numNeurons>1)
        for i=3:(3+(numNeurons-2))
            model.component('comp1').geom('geom1').create(['mov',int2str(i)], 'Move');
            model.component('comp1').geom('geom1').feature(['mov',int2str(i)]).label(['Move ',int2str(i)]);
            model.component('comp1').geom('geom1').feature(['mov',int2str(i)]).set('selresult', true);
            model.component('comp1').geom('geom1').feature(['mov',int2str(i)]).set('keep', true);
            model.component('comp1').geom('geom1').feature(['mov',int2str(i)]).set('displz', [num2str(distanceBetweenNeurons),'*',num2str(i-2)]);
            model.component('comp1').geom('geom1').feature(['mov',int2str(i)]).selection('input').set({'uni3'});
        end
    end
    model.component('comp1').geom('geom1').feature('fin').label('Form Union');    
    model.component('comp1').geom('geom1').run;
    model.component('comp1').geom('geom1').run('fin');


end