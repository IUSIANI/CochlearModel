function plotCurrentInput()
figure('Name',sprintf('%s/%s',membraneCurrentDensityFolder,membraneCurrentDensityFile));
data = csvread(sprintf('./currentInputs/%s',membraneCurrentDensityFile))
plot(data(:,1),data(:,2),'title',membraneCurrentDensityFile)
end