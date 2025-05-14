function dist = shortestDist(cam, pos)
%{
%% Objective:
Calculates the shortest distance between a point and a line in 3D space

%% Inputs:
cam:        Data capture and calibration information at a singular time
            step. This includes calibration, FOV, frame size, x&z position,
            and inertial offset.

pos:        1x3 Position Vector to compare to the line given by cam's pointing

%% Outputs:
dist:       shortest distance between pos and the line of cam

%}

% pix_x = cam.res(1);
% pix_z = cam.res(2);

%{
x0 = cam.res(1)/2;                      % x and z camera frame origin
z0 = cam.res(2)/2;

pix2deg_x = cam.FOV(1)/pix_x;           % unit conversion from pixel to deg
pix2deg_z = cam.FOV(2)/pix_z;

p = (cam.x - x0) * pix2deg_x;           % angular difference of point relative to center
q = (z0 - cam.z) * pix2deg_z;

R = rotation321(cam.att);               % rotation matrix from intertial to camera frame

l = [tand(p); 1; tand(q)] / norm([tand(p); 1; tand(q)]);
l = R\l;      % Unit Vector of bearings line relative to the camera in global coordinate frame

projection = proj(pos-cam.pos, l);

dist = norm(projection);
%}

% Intrinsics
x0 = cam.res(1)/2;
z0 = cam.res(2)/2;
f_x = (cam.res(1)/2) / tand(cam.FOV(1)/2);  % fx in pixels
f_z = (cam.res(2)/2) / tand(cam.FOV(2)/2);  % fz in pixels

% Pixel coordinates
x = cam.x;
z = cam.z;

% Convert pixel to direction vector in camera coordinates
dx = (x - x0) / f_x;
dz = (z0 - z) / f_z;  % Note the flip if z grows downward

l_cam = [dx; 1; dz];
l_cam = l_cam / norm(l_cam);

% Rotate to global frame
R = cam.R;          % Cam #_ to Cam 1
l = R * l_cam;      

% Project point onto line and get shortest vector;

along_line = proj(pos - cam.pos, l);
perp_vector = pos - cam.pos - along_line;
dist = norm(perp_vector);

end