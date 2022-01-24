function model  = Mesh_ExportMesh(model)
    global meshFile
    model.component('comp1').mesh('mesh1').export.set('filename', meshFile('output','mesh.mphtxt'));
    model.component('comp1').mesh('mesh1').export(meshFile('output','mesh.mphtxt'));
end