function plotCurrentDensityatNeurons(currentDensityAtNeurons)
    figure('Name','Current Density at Neurons'); hold on;
    global longitudNeurona
    x = linspace(longitudNeurona/1000,longitudNeurona, 1000);
    plot(x, currentDensityAtNeurons)
    title('Current Density at Neurons')
    xlabel('Arc length (mm)')
    ylabel('Current density norm (A/m^2)')
    
    range = [max(max(currentDensityAtNeurons,[],2)),min(min(currentDensityAtNeurons,[],2))];
    fprintf('[+] plots/plotCurrentDensityatNeurons.m >> \n\t Range = [%.2f, %.2f] A/m² \n', fliplr(range))
%     yline(range(1),'r',sprintf('max: %.2f A/m2',range(1)))
%     yline(range(2),'r',sprintf('min: %.2f A/m2', range(2)))
end