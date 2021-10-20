clear
close all
clc

load('NRT_20_Neurons_11_Electrodes_0_21.mat');


x=[];
y=[];
n=1;
figure;
for i=[-5:5]
    x=[x,i];
    y=[y,sum(getAmpOnElectrodeFromBases(i, V))];
    subplot(11,2,n)
    plot([-19:19],getAmpOnElectrodeFromBases(i, V))
    title(["elec ", num2str(i)])
    n=n+2;
end

subplot(11,2,[2,4,6,8,10,12,14,16,18]);hold on
plot(x,y,'r*')
plot(x,y,'r-')