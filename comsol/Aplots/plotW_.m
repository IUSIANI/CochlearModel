function plotW_(w_)
global I_k
figure('Name','Global Weights (w_)')

l = length(w_);
n = (l-1)/2;

plot(linspace(-n,n, l),fliplr(w_))
hleg = legend(sprintf('I_{3}: %.3f mA',I_k(3)*1e3),sprintf('I_{2}: %.3f mA',I_k(2)*1e3),sprintf('I_{1}: %.3f mA',I_k(1)*1e3));
htitle = get(hleg,'Title');
set(htitle,'String','Intensity')

title('global Weights (w_)');
xlabel('# Num Virtual Neuron');
ylabel('Weigths');
xlim([-n,n]);
end