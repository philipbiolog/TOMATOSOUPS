function pos = posEstimate(cam_struct)
%{
%% Objective: 
Estimates the position of the object by optimizing or minimizing the cost
function "averageDistance" which returns the average distance between a
point and the bearing lines of the cameras.

%% Inputs:
cam_struct:     1x8 array of all camera structs as defined by camStruct_doc
%% Outputs:
pos:            Final Position estimate of the object

%}
size = length(cam_struct(1).x);                     % Size of posX and time vector
pos = zeros(3, size);
x0 = [1, 1, 1]';
for t = 1:size
    cam_array = [];
    for i = 1:length(cam_struct)
        if (cam_struct(i).seen(t) == true)
            cam = cam_struct(i);
            cam.x = cam_struct(i).x(t);
            cam.z = cam_struct(i).z(t);
            cam_array = [cam_array, cam];
        end
    end
    n = length(cam_array);                  % Number of Cameras that can see the vehicle
    pos(:, t) = fmincon(@(x) averageDistance(cam_array, x, n), x0, [], []);
end

end