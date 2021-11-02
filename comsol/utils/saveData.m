fprintf("[+] /comsol/utils/saveData.m >> Saving data\n")
save(patientwsFiles(patient,electrode, anchorElectrode, arrayPos))
save(optFiles(patient,electrode, anchorElectrode, arrayPos), 'FVr_x','d','S','w_','W')

%% Prepare data
[Xsorted, YRealsorted, YSimsorted, I] = sortInterp0(NRT_real_k_Rec_Elect, NRT_real_k_Amplitude, NRTAmplitud, anchorElectrode, InterpolationMethod);
Electrodos = reshape(repmat(Xsorted,length(I_k), 1)', [],1); % Ok
Intensidad = reshape(repmat(I_k, length(Xsorted),1),[],1); % Ok
Paciente = repmat(patient,length(Intensidad),1); % Ok
Opt = Paciente;
Tipo = repmat(electrode,length(Intensidad),1); % Ok
NRT_real = reshape(YRealsorted ,[],1); % Ok
NRT_sim = reshape(YSimsorted,[],1);%

trained = ismember(Xsorted, NRT_real_k_Rec_Elect_Select);
trained(find(Xsorted == anchorElectrode)) = true; 
Trained = reshape(repmat(trained,length(I_k), 1)', [],1); % Ok
rm = ~all(ismember(NRT_real_k_Rec_Elect,NRT_real_k_Rec_Elect_Select));
RM=ones(size(Trained))*rm;
Anchor = repmat(anchorElectrode, size(Electrodos));

data = [Electrodos,Intensidad,Paciente,Opt,Tipo,NRT_real,NRT_sim,Trained,RM,Anchor];
T = array2table(data);
T.Properties.VariableNames = {'Electrodos', 'Intensidad','Paciente','Opt','Tipo','NRT_real','NRT_sim','Trained','RM','Anchor'};

if (length(NRT_real_k_Rec_Elect_Select) == length(NRT_real_k_Rec_Elect))
    writetable(T, patientcsvFiles(patient, electrode, anchorElectrode, arrayPos,'xlsx'))
    csvwrite(patientcsvFiles(patient, electrode, anchorElectrode,arrayPos,'csv'),data)
    csvwrite(patientwFiles(patient, electrode, anchorElectrode,arrayPos),w_)
else
    writetable(T, patientcsvFiles(patient, electrode, anchorElectrode,arrayPos,'xlsx'))
    csvwrite(patientcsvFiles(patient, electrode, anchorElectrode,arrayPos,'csv'),data)
    csvwrite(patientwFiles(patient, electrode, anchorElectrode,arrayPos),w_)
end