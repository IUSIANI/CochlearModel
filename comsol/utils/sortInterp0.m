function [Xsorted, YRealsorted, YSimsorted, I] = sortInterp0(x, yReal, ySim, InterpolationMethod)

if nargin == 3
    global InterpolationMethod
end


NRT_Interp_0_array = interp1(x,yReal',0, InterpolationMethod);

[Xsorted, I] =  sort([x, 0]);
YRealsorted = [yReal'; NRT_Interp_0_array];
YSimsorted = [ySim';NRT_Interp_0_array];

YRealsorted = YRealsorted(I,:);
YSimsorted = YSimsorted(I,:);
end
