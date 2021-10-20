function plotbetaDist(FVr_x)
figure;
plot([0:0.01:1]*FVr_x(4),betaDist([0:0.01:1],FVr_x(1),FVr_x(2)))
end
