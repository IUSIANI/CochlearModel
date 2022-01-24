%% Init COMSOL
addpath('/opt/comsol56/multiphysics/mli', '-begin')
mphstart()
import com.comsol.model.util.*

%% Init Variables
run('./Rundeopt.m')
