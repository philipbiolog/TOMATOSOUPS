function [position_c] = TrajectoryToCamera(trajectory, cameraobject)
%TRAJECTORYTOCAMERA Takes in a camera project and trajectory to establish a
% the projection of the trajectory on the camera face
% Expects aircraft dynamics xyz global frame and return x and y positons in
% the xz plate of the global frame with +x=>+x and +z=>+y so +y is down

x = cameraobject.x_position;
y = cameraobject.y_position;
z = cameraobject.z_position;
FOV_x = deg2rad(cameraobject.FOV_x);
FOV_y = deg2rad(cameraobject.FOV_y);
pix_x = cameraobject.pix_x;
pix_y = cameraobject.pix_y;

% Performance Optimization
pix_x_half = pix_x/2;
pix_y_half = pix_y/2;

phi = deg2rad(cameraobject.phi);
theta = deg2rad(cameraobject.theta);
psi = deg2rad(cameraobject.psi);

eul = [psi theta  phi];
rotmZYX = eul2rotm(eul);

trajectory_camera = trajectory - [x y z]; % Ofsets global camer location
trajectory_camera = rotmZYX * trajectory_camera'; % Apply Camera Rotation
trajectory_camera = trajectory_camera';
[rows, ~] = size(trajectory_camera);

position_c = zeros(rows,3);

% Uses Johns math to find the x and y camera fame cordinates
for i = 1:rows
    t = norm(trajectory_camera(i,1));
    position_c(i,1) = atan(trajectory_camera(i,2)/t)*pix_x/FOV_x;
    position_c(i,2) = atan(trajectory_camera(i,3)/t)*pix_y/FOV_y;
    
    % Sees if the camera could see the pixle
    if abs(position_c(i,1)) > pix_x_half
        position_c(i,3) = false;
    elseif abs(position_c(i,2)) > pix_y_half
        position_c(i,3) = false;
    else
        position_c(i,3) = true;
    end
end



