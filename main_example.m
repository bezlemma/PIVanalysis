ROOT = 'Path\To\File\Goes\Here';
SCALE = 1; %um/[ixel scale goes here
FRAMERATE = 2; %#s per fram goes here

DIRECTORY = [ROOT '\ExampleData'];

%Calculte velocity field from data
[U_VEL_FIELD, V_VEL_FIELD] = func_PIVLabCommandLine(DIRECTORY);
[VEL_TIME_LIST, STD_ERR_TIME_LIST] = Find_Mean_Vel(U_VEL_FIELD, V_VEL_FIELD,SCALE,FRAMERATE);

%Calculate Velocity-Velocity spatial correlation
tmin =1; tmax=30; step =1; PIV_BIN = 4; %Start time, time step for skipping a certain amount of the data, and the final resolution of the PIV data
X_BUFFER = 5; MID_POINT = 0.5; FIT_START_POINT = [1 15 0]; %These numbers might need to be modified

[CORRELATION_LIST]   = func_find_correlation_length(U_VEL_FIELD, V_VEL_FIELD , tmin, step, 30, SCALE,PIV_BIN,X_BUFFER , MID_POINT , FIT_START_POINT);