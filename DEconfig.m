
%********************************************************************
% Script file for the initialization and run of the differential 
% evolution optimizer.
%********************************************************************
% F_VTR     "Value To Reach" (stop when ofunc < F_VTR)
S_struct.F_VTR        = 1.e-30; 

Stol =1e-4; % 

epsilon = 1e-6;

% FVr_minbound,FVr_maxbound   vector of lower and bounds of initial population
%           the algorithm seems to work especially well if [FVr_minbound,FVr_maxbound] 
%           covers the region where the global minimum is expected
%               *** note: these are no bound constraints!! ***
S_struct.bound = 'auto';
S_struct.FVr_minbound = [epsilon,    epsilon,    0,  1+epsilon]; 
S_struct.FVr_maxbound = [2000, 2000, 0, 1500];  
S_struct.I_bnd_constr = 1;  %1: use bounds as bound constraints, 0: no bound constraints      

% I_D       number of parameters of the objective function 
S_struct.I_D          = length(S_struct.FVr_minbound);

% I_NP            number of population members
S_struct.I_NP         = 15;  %poner poblacion de 10 y 20
%pretty high number - needed for demo purposes only

% I_itermax       maximum number of iterations (generations)
S_struct.I_itermax    = 300;%300 %num iteraciones 2000 para 10 y 1000 para 20

% F_weight        DE-stepsize F_weight ex [0, 2]
S_struct.F_weight     = 0.3; 

% F_CR            crossover probabililty constant ex [0, 1]
S_struct.F_CR         = 1; 

% I_strategy     1 --> DE/rand/1:
%                      the classical version of DE.
%                2 --> DE/local-to-best/1:
%                      a version which has been used by quite a number
%                      of scientists. Attempts a balance between robustness
%                      and fast convergence.
%                3 --> DE/best/1 with jitter:
%                      taylored for small population sizes and fast convergence.
%                      Dimensionality should not be too high.
%  4 --> DE/rand/1 with per-vector-dither:
%        Classical DE with dither to become even more robust.
%  5 --> DE/rand/1 with per-generation-dither:
%        Classical DE with dither to become even more robust.
%        Choosing F_weight = 0.3 is a good start here.
%                6 --> DE/rand/1 either-or-algorithm:
%                      Alternates between differential mutation and three-point-
%                      recombination.           

S_struct.I_strategy   = 4; %Try for 2 population both strategy

% I_refresh     intermediate output will be produced after "I_refresh"
%               iterations. No intermediate output will be produced
%               if I_refresh is < 1
S_struct.I_refresh    = 50;

% I_plotting    Will use plotting if set to 1. Will skip plotting otherwise.
S_struct.I_plotting   = 0;
