function [NRT_real_k_Rec_Elect_Select, NRT_real_k_Amplitude_Select] = PatientData(paciente, electrodo, selectedElectrodes)
    global I_k NRT_real_k_Rec_Elect NRT_real_k_Amplitude
    global NRT_real_k_Rec_Elect_Select NRT_real_k_Amplitude_Select
    NRT_real_k_Rec_Elect = [-4, -3, -2, -1, 1, 2, 3, 4];
    
    

    if nargin<2
        NRT_real_k_Rec_Elect_Select = [-4, -3, -2, -1, 1, 2, 3, 4];
    elseif nargin==3
        NRT_real_k_Rec_Elect_Select = selectedElectrodes;
    end
    
    electrodes = sprintf('%d, ',NRT_real_k_Rec_Elect_Select);
    electrodes = electrodes(1:end-2);
    fprintf(sprintf("\n[+] data/PatientData.m >> Patient %d electrode %d with selected electrodes [%s] has been loaded\n\n", paciente, electrodo, electrodes))
    
    if (paciente == 1)
        if (electrodo == 6)
            %NRT elec 6 Patient 1
            I_k = [0.412654, 0.648135, 1.01799]*(-10^-3);            %CL=200; Conversion (10*(7/4))*100^(CL/255)
            NRT_real_k_Amplitude = [40.64,  51.57,  60.45,  87.43,  76.5,   52.25,  38.93,  28;   ...
                                    83.88,  104.85, 134.9,  172.81, 177.94, 124.66, 90.5,   66.6; ...
                                    145.49, 168.38, 207.31, 239.41, 252.73, 195.7,  147.88, 107.24]   *10^-6; %NRT ECAP Amplitude in V
        else
            %NRT elec 18 Patient 1
            I_k = [0.412654, 0.648135, 1.01799]*(-10^-3);            %CL=200; Conversion (10*(7/4))*100^(CL/255)
            NRT_real_k_Amplitude = [     0,      0,      0,      0,   7.51,      0,      0,      0
                                     64.89,  66.94,  69.33,  82.65,  75.82,  64.89,  65.23,  64.21
                                    197.40, 200.48, 205.94, 212.43, 207.31, 202.18, 189.55, 188.18]   *10^-6; %NRT ECAP Amplitude in V              
        end
    else
        if (electrodo == 6)
            %NRT elec 6 Patient 2
            I_k = [0.412654, 0.648135, 1.01799]*(-10^-3);
            NRT_real_k_Amplitude = [31.76, 38.25, 32.45, 36.54, 31.42, 26.98, 26.64, 19.81; ...
                                    183.4, 211.75, 229.16, 231.56, 181.69, 142.07, 121.58, 115.09; ...
                                    400.61, 461.41, 491.8, 494.88, 393.1, 332.99, 276.64, 250.34]   *10^-6; 
        else
            %NRT elec 18 Patient 2
            I_k = [0.412654, 0.648135, 1.01799]*(-10^-3);
            NRT_real_k_Amplitude = [106.22, 109.29, 125, 166.67, 149.93, 146.17, 136.61, 127.73; ...
                                    368.51, 386.27, 418.37, 461.06, 440.23, 434.08, 425.55, 405.05; ...
                                    797.13, 878.76, 969.95, 1068.99, 866.46, 806.35, 762.3, 716.87]   *10^-6; 
        end
    end
    
    NRT_real_k_Amplitude_Select = NRT_real_k_Amplitude(:,find(ismember(NRT_real_k_Rec_Elect,NRT_real_k_Rec_Elect_Select)==1));
end