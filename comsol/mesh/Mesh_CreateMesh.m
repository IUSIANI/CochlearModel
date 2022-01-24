function model  = Mesh_CreateMesh(model, nNeuronasSimuladas)
    fprintf('\t[-] Meshing geometry.\n');

    model.component('comp1').mesh.create('mesh1');

    model.component('comp1').mesh('mesh1').create('ftet1', 'FreeTet');
    model.component('comp1').mesh('mesh1').feature('ftet1').set('optlevel', 'medium');
    model.component('comp1').mesh('mesh1').feature('ftet1').label('Free Tetrahedral 1');
    

    model.component('comp1').mesh('mesh1').label('Mesh 1');
    model.component('comp1').mesh('mesh1').feature('size').label('Size');
    model.component('comp1').mesh('mesh1').feature('size').set('custom', 'on');
    model.component('comp1').mesh('mesh1').feature('size').set('hmax', 1.2);
    model.component('comp1').mesh('mesh1').feature('size').set('hmin', '0.216/3');

    model.component('comp1').mesh('mesh1').create('ref1', 'Refine');
    model.component('comp1').mesh('mesh1').feature('ref1').set('rmethod', 'regular');
    model.component('comp1').mesh('mesh1').feature('ref1').set('numrefine', 3);
    model.component('comp1').mesh('mesh1').feature('ref1').selection.geom('geom1', 1);
    model.component('comp1').mesh('mesh1').feature('ref1').selection.set([98:98+(nNeuronasSimuladas)]);

    model.component('comp1').mesh('mesh1').run;
end