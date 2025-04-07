%% Cam Struct Documentation
%{

The camera struct is used for storing all data referring to the calibration
of cameras and their data capture.

%% Frame Properties
****************************************************************
cam.pix_x:
cam.pix_z:

cam.res: [pix_x, pix_y]

cam.FOV_x:
cam.FOV_z:

cam.FOV = [FOV_x, FOV_z]

%% Calibration Data
****************************************************************
cam.X:
cam.Y:
cam.Z:

cam.pos: [X; Y; Z]

cam.phi:
cam.theta:
cam.psi:

cam.att: [phi; theta; psi]

%% Data Capture
****************************************************************
cam.x:
cam.z:
cam.t:
cam.seen:



%}