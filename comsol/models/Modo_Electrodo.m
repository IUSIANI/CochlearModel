function [currentDensityAtNeurons, model] = Modo_Electrodo(stimulationCurrent, distanceBetweenNeurons, nNeuronasSimuladas, boundaryRadius, meanMaterialConductivity, arrayPos)
    fprintf('[+] comsol/models/Modo_Electrodo.m >> Solving current density for each neuron during electrode stimulation\n')
    global mcdf mphElectrodo
    
    import com.comsol.model.*
    import com.comsol.model.util.*

    ModelUtil.clear

    model = ModelUtil.create('Model');

    model.modelPath('/Users/angelramosdemiguel/Desktop');

    model.label('modelo electrodo.mph');

    model.comments(['Model\n\n']);

    %Definicion de variables
    model.param.set('d', '2*10^-6', 'diametro neurona');
    model.param.set('arrayPos', num2str(arrayPos), 'posicion de la guia de electrodos');
    model.param.set('blockElectrodePos', '.45', 'Posicion del bloque de los electrodos');
    model.param.set('mu', '1');
    model.param.label('Parameters 1');

    model.func.create('betaDist', 'MATLAB');
    model.func('betaDist').setIndex('funcs', 'betaDist', 0, 0);
    model.func('betaDist').setIndex('funcs', 'x, z, w', 0, 1);

    model.component.create('comp1', false);
    model.component('comp1').geom.create('geom1', 3);
    model.component('comp1').label('Component 1');
    model.component('comp1').curvedInterior(false);



    model = Geometry_CreateGeo(model, distanceBetweenNeurons, nNeuronasSimuladas, boundaryRadius);
    model = Material_CreateMaterial(model, meanMaterialConductivity);
    model = Mesh_CreateMesh(model, nNeuronasSimuladas);
 
    switch arrayPos
        case 0.2
            fprintf("\t[-] Creando física para el electrodo perimodiolar\n")
            model = Physics_CreatePhysicsElectrodeMode(model, stimulationCurrent, boundaryRadius);
        case 1
            fprintf("\t[-] Creando física para el electrodo lateral\n")
            model = Physics_CreatePhysicsElectrodeModeLateral(model, stimulationCurrent, boundaryRadius);
        otherwise 
            fprintf("\t[-] Creando física para el electrodo genérico\n")
            model = Physics_CreatePhysicsElectrodeMode(model, stimulationCurrent, boundaryRadius);
    end

    model = Study_CreateSolStatic(model);
    %model = Study_CreateSolDinamica(model, 0, 0.02, 0.02);

    [currentDensityAtNeurons, model] = Results_CreateResultsElectrodo(model, distanceBetweenNeurons, nNeuronasSimuladas);

    mphName = mphElectrodo(arrayPos, mcdf);
    fprintf("\t[-] saving mph model file: \'%s\'\n", mphName)
    mphsave(mphName)
    fprintf("\t[-] \'comsol/models/Modo_Neurona.m' finished successfully.\n\n")
end
