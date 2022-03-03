ROOT = 'path to the example data goes here';
SCALE = 1; %um/pixel scale goes here
FRAMERATE = 2; %#s per fram goes here

DIRECTORY = [ROOT '\ExampleData\']; %you will need to flip \ to / for mac os.
%Calculte velocity field from data
[U_VEL_FIELD, V_VEL_FIELD] = func_PIVLabCommandLine(DIRECTORY);
[VEL_TIME_LIST, STD_ERR_TIME_LIST] = func_find_mean_vel(U_VEL_FIELD, V_VEL_FIELD,SCALE,FRAMERATE);

%Calculate Velocity-Velocity spatial correlation
tmin =1; tmax=29; step =1; PIV_BIN = 4; %Start time, time step for skipping a certain amount of the data, and the final resolution of the PIV data
X_BUFFER = 5; FIT_START_POINT = [1.7 100 0]]; %These numbers might need to be modified

[CORR_LIST]   = func_find_correlation_length(U_VEL_FIELD, V_VEL_FIELD , tmin, step, tmax, SCALE,PIV_BIN, X_BUFFER , FIT_START_POINT);
