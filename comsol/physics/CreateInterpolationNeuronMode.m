function [model] = CreateInterpolationNeuronMode(model, filename)
model.func.create('int1', 'Interpolation');
model.func('int1').label('Interpolation 1');
model.func('int1').set('source', 'file');
model.func('int1').set('filename', filename);
model.func('int1').refresh;
model.func('int1').importData;
model.func('int1').set('argunit', 'ms');
model.func('int1').set('fununit', 'A/m^2');
end