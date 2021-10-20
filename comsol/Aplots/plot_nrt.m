files = [
"bases/NRT_43_Neurons_11_Electrodes_0_2_15m_s.mat",...
"bases/NRT_43_Neurons_11_Electrodes_0_25_15m_s.mat",...
"bases/NRT_43_Neurons_11_Electrodes_0_3_15m_s.mat",...
"bases/NRT_43_Neurons_11_Electrodes_0_5_15m_s.mat",...
"bases/NRT_43_Neurons_11_Electrodes_0_7_15m_s.mat",...       
"bases/NRT_43_Neurons_11_Electrodes_0_9_15m_s.mat",...
];


electrodos = -5:1:5;
figure; hold on;
for i=1:length(files)
    load(files(i));
    plot(electrodos, calc_nrt(V));

end

legend(["0.2","0.25","0.3","0.5","0.7","0.9"])

hold off;



% 
% load("bases/NRT_43_Neurons_11_Electrodes_1_15m_s.mat")
% plot(V{6}(1,:))