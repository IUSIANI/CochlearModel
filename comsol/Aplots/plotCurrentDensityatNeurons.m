function plotCurrentDensityatNeurons(currentDensityAtNeurons)
    figure('Name','Current Density at Neurons'); hold on;
    global longitudNeurona
    x = linspace(longitudNeurona/1000,longitudNeurona, 1000);
    plot(x, currentDensityAtNeurons)
    xlabel('Arc length (mm)')
    ylabel('Current density norm (A/m^2)')
end