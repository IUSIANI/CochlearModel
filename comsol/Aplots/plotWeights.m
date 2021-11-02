 function plotWeights(W)
 global I_k
figure('Name','Weights (W)')

l = length(W); n = (l-1)/2;

plot(linspace(-n,n, l),fliplr(W))
%legend('I3','I2','I1','Intensity','Location','north')
hleg = legend(sprintf('I_{3}: %.3f mA',I_k(3)*1e3),sprintf('I_{2}: %.3f mA',I_k(2)*1e3),sprintf('I_{1}: %.3f mA',I_k(1)*1e3),'Location','north');
htitle = get(hleg,'Title');
set(htitle,'String','Intensity')

title('Weights');
xlabel('# Num Virtual Neuron');
ylabel('Weigths');
xlim([-n,n]);
end