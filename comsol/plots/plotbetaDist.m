function plotbetaDist(FVr_x)
figure('Name','Beta Distribution');
plot([0:0.01:1]*FVr_x(4), betainc([0:0.01:1],FVr_x(1),FVr_x(2)))
title(sprintf('Beta distribution\n $\\alpha: %.2f ~|~ \\beta: %.2f ~|~ Jmax: %.2f$',FVr_x(1),FVr_x(2),FVr_x(4)),'Interpreter','latex')

ylim([0,1.05])
xlim([0,FVr_x(4)])
end
