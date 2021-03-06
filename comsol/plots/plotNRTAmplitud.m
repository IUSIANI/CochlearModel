function plotNRTAmplitud(NRTAmplitud)
global NRT_real_k_Rec_Elect NRT_real_k_Amplitude
global InterpolationMethod
global anchorElectrode

figure('Name','Neuronal Response Telemetry'); hold on ;
[Xsorted, YRealsorted, YSimsorted, I] = sortInterp0(NRT_real_k_Rec_Elect, NRT_real_k_Amplitude, NRTAmplitud, anchorElectrode, InterpolationMethod);

l1 = plot(NRT_real_k_Rec_Elect, NRT_real_k_Amplitude*1e3,'-or', 'DisplayName','Real');
l2 = plot(NRT_real_k_Rec_Elect, NRTAmplitud*1e3,'-ob',  'DisplayName','Sim');

anchor = scatter(repmat(anchorElectrode,1, size(YRealsorted,2)),...
                 YRealsorted(find(Xsorted==anchorElectrode),:)*1e3,'*k',  'DisplayName','Anchor');

hold off;

ldg = legend([l1(1),l2(1),anchor(1)], {'Real','Sim','Anchor'});


xlabel('# Num electrode')
ylabel('NRT Amplitud [mV]')
title('NRT Real vs NRT Simulada')

end