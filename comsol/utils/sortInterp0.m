function [Xsorted, YRealsorted, YSimsorted, I] = sortInterp0(x, yReal, ySim, anchorElectrode, InterpolationMethod)

if nargin == 4
    global InterpolationMethod
end


NRT_Interp_0_array = interp1(x,yReal',0, InterpolationMethod);

[Xsorted, I] =  sort([x, 0]);
YRealsorted = [yReal'; NRT_Interp_0_array];

switch anchorElectrode
    case 0
        YSimsorted = [ySim'; NRT_Interp_0_array]; 
    otherwise 
        NRT_Interp_0_array = interp1(x,ySim',0, InterpolationMethod);
        YSimsorted = [ySim'; NRT_Interp_0_array]; 
end
% NRT_Interp_0_array = interp1(x,ySim',0, InterpolationMethod);
% YSimsorted = [ySim';NRT_Interp_0_array];

YRealsorted = YRealsorted(I,:);
YSimsorted = YSimsorted(I,:);
end
