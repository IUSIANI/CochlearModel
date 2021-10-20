clear all; 
close all;
clc;
%% Init COMSOL
addpath('/opt/comsol56/multiphysics/mli', '-begin')
mphstart()
import com.comsol.model.util.*

Rundeopt


exit()