%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function:         S_MSE= objfun(FVr_temp, S_struct)
% Author:           Rainer Storn
% Description:      Implements the cost function to be minimized.
% Parameters:       FVr_temp     (I)    Paramter vector
%                   S_Struct     (I)    Contains a variety of parameters.
%                                       For details see Rundeopt.m
% Return value:     S_MSE.I_nc   (O)    Number of constraints
%                   S_MSE.FVr_ca (O)    Constraint values. 0 means the constraints
%                                       are met. Values > 0 measure the distance
%                                       to a particular constraint.
%                   S_MSE.I_no   (O)    Number of objectives.
%                   S_MSE.FVr_oa (O)    Objective function values.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function S_MSE= objfun(FVr_temp, S_struct, Model_struct)

%---Rosenbrock saddle-------------------------------------------
%F_cost = 100*(FVr_temp(2)-FVr_temp(1)^2)^2+(1-FVr_temp(1))^2;
[error, NRTAmplitud] = errorFit(Model_struct.currentDensityAtNeurons, ...
                               Model_struct.nNeuronasSimuladas, ...
                               FVr_temp(1), FVr_temp(2), FVr_temp(3), FVr_temp(4),...
                               Model_struct.SThreshold,... 
                               Model_struct.C_k, ...
                               Model_struct.W,...
                               Model_struct.V, ...
                               Model_struct.NRT_real_k_Amplitude,...
                               Model_struct.NRT_real_k_Rec_Elect,...
                               Model_struct.index,...
                               Model_struct.threshold,...
                                       Model_struct);
                                                                     
                                   
F_cost = error;

%----strategy to put everything into a cost function------------
S_MSE.I_nc      = 0;%no constraints
S_MSE.FVr_ca    = 0;%no constraint array
S_MSE.I_no      = 1;%number of objectives (costs)
S_MSE.FVr_oa(1) = F_cost;
S_MSE.NRTAmplitud = NRTAmplitud;
