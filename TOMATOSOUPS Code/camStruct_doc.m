%% Cam Struct Documentation
%{

The camera struct is used for storing all data referring to the calibration
of cameras and their data capture.

%% Frame Properties
****************************************************************
cam.pix_x:  lengthwise pixel size of each frame
cam.pix_z:  heightwise pixel size of each frame

cam.res: [pix_x, pix_y]

cam.FOV_x:  lengthwise Field of View
cam.FOV_z:  heightwise Field of View

cam.FOV = [FOV_x, FOV_z]

%% Calibration Data
****************************************************************
cam.X:  x position offset from origin in inertial frame
cam.Y:  y position offset from origin in inertial frame
cam.Z:  z position offset from origin in inertial frame

cam.pos: [X; Y; Z]

cam.phi:    angular offset about x axis from inertial frame
cam.theta:  angular offset about y axis from inertial frame
cam.psi:    angular offset about z axis from inertial frame

cam.att: [phi; theta; psi]

%% Data Capture
****************************************************************
cam.x:      lengthwise position of object in camera frame
cam.z:      lengthwise position of object in camera frame
cam.t:      time vector of object in camera frame
cam.seen:   boolean vector for if the object is seen in camera frame



%}