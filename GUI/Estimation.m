function [position,velocity] = Estimation(cam_struct)
%{
%% Objective: 
Estimates the position of the object by optimizing or minimizing the cost
function "averageDistance" which returns the average distance between a
point and the bearing lines of the cameras. Estimates velocity by simply
taking derivative of position in all 3 axes

%% Inputs:
cam_struct:     1x8 array of all camera structs as defined by camStruct_doc
%% Outputs:
position:            Final Position estimate of the object
velocity:            Final velocity estimate of the object


%}
position = posEstimate(cam_struct);

time = length(position(:,1)) / 24;

velocity = EstimateVelocity(position,time);

end

