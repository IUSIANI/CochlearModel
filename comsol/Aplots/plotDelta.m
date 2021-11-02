function plotDelta(d)
global I_k
figure('Name','Deltas (d)')

l = length(d); n = (l-1)/2;

plot(linspace(-n,n, l),fliplr(d))
hleg = legend(sprintf('I_{3}: %.3f mA',I_k(3)*1e3),sprintf('I_{2}: %.3f mA',I_k(2)*1e3),sprintf('I_{1}: %.3f mA',I_k(1)*1e3));
htitle = get(hleg,'Title');
set(htitle,'String','Intensity')

title('Delta');
xlabel('# Num Virtual Neuron');
ylabel('Weigths');
xlim([-n,n]);
end