function [VNRTOnElectrode, model] = Modo_Neurona(distanceBetweenNeurons, nNeuronasSimuladas, boundaryRadius, meanMaterialConductivity,arrayPos, vpropag)

    global membraneCurrentDensityFile membraneCurrentDensityFolder
    
    close all
    fprintf('[+] comsol/models/Modo_Neurona.m >> Calculating the electric potential (V) produced by each of simulated VN (Bases)\n')

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
    model.param.set('v', num2str(vpropag), 'velocidad transmision m/s');
    model.param.label('Parameters 1');

    model.component.create('comp1', false);
    model.component('comp1').geom.create('geom1', 3);
    model.component('comp1').label('Component 1');
    model.component('comp1').curvedInterior(false);



    model = Geometry_CreateGeo(model, distanceBetweenNeurons, nNeuronasSimuladas, boundaryRadius);
    model = Material_CreateMaterial(model, meanMaterialConductivity);
%     model = Variables_APNeuron(model);
    filename = fullfile(membraneCurrentDensityFolder, membraneCurrentDensityFile);
    fprintf('\t[-] Loading Current Density Input from file: \"%s\"\n',filename)
    model = CreateInterpolationNeuronMode(model, filename); % Nueva
    model = Mesh_CreateMesh(model, nNeuronasSimuladas);
    bases = eye(nNeuronasSimuladas); %Identity matrix%

    
    V = [];
    electrodesRecorder = [-5:5];
    VNRTOnElectrode = cell(length(electrodesRecorder),1);
    for i=1:nNeuronasSimuladas
        try
            remaininTime = num2str((endIt-startIt)*(nNeuronasSimuladas+1-i));
            startIt = toc;
        catch
            remaininTime = '∞';
        end
        fprintf("\t[-] Solving potential (V) Neuron %d/%d (remaining time: %s sec)\n",i,nNeuronasSimuladas,remaininTime)
        
        a=zeros(3,11); a(2,:)=arrayPos-0.3; a(3,:)=[-3.5:0.7:3.5];
        model = Physics_CreatePhysicsNeuroneMode(model, bases(i,:), boundaryRadius, meanMaterialConductivity, a);
        model = Study_CreateSolDinamica(model);
        
       for j=electrodesRecorder
            fprintf("\t\t[*] Calculating Electrode %d\n",j)
            V=VNRTOnElectrode{j+6};
            [V(i,:), model]  = Results_CreateResultsNeurone(model, (0.7*j));
            VNRTOnElectrode{j+6} = V;
        end
        endIt = toc;
        fprintf("\n\n")
    end
    fprintf("[+] \'comsol/models/Modo_Neurona.m' finished successfully. (Elapsed time: %g sec)\n", toc)
end
