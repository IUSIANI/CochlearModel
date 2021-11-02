function model  = Mesh_ImportMesh(model, filename)
%     validFormat = {'stl'; 'mphtxt'};
%     contains(format, validFormat);
%     [filepath,name,ext] = fileparts(filename)
%     replace(ext, '.','')

    fprintf('\t[-] Import mesh from %s\n',filename);

    model.component('comp1').mesh('mesh1').create('imp1', 'Import');
    model.component('comp1').mesh('mesh1').feature('imp1').set('source', 'native');
    model.component('comp1').mesh('mesh1').feature('imp1').set('filename', meshFile('input',filename));
    model.component('comp1').mesh('mesh1').run;
end