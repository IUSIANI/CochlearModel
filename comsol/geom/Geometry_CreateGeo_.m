function model  = Geometry_CreateGeo(model, distanceBetweenNeurons, numNeurons, boundaryRadius)

    fprintf('\t[-] Creating geometry.\n');
    
    model.component('comp1').geom('geom1').label('Geometry 1');
    
    model.component('comp1').geom('geom1').lengthUnit('mm');   
    model.component('comp1').geom('geom1').create('sph1', 'Sphere');
    model.component('comp1').geom('geom1').feature('sph1').set('r', 1);

    model.component('comp1').geom('geom1').create('sph2', 'Sphere');
    model.component('comp1').geom('geom1').feature('sph2').set('pos', [0 18 0]);
    model.component('comp1').geom('geom1').feature('sph2').set('r', '.5');

    model.component('comp1').geom('geom1').run;
    disp(model.selection)
    idx = mphgetselection(model.selection('geom1_sph2_bnc')).entities
    
end