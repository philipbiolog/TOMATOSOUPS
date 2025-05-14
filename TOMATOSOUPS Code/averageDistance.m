function dist = averageDistance(cam_struct, pos, n) % Definitely not the problem
%{
%% Objective: 
Calculates the average distance, or error, of the array of pointing lines
and a point as given by pos. This is a "cost function" that, when
minimized, calcualtes the position of an object given an array of
cameras and what they see

%% Inputs:
cam_struct:     1xn array of Camera structs. Each camera must be able to
                see the object and therefore have data at the current time step

pos:            Current guess or estimate being used by cost function

n:              number of cameras that can see the object
%% Outputs:
dist:           Total distance error between pos and the n lines given by
                the camera
%}


dist = 0;
for i = 1:n                                         %       For every camera that can see, calculate the shortest 
    dist = dist + shortestDist(cam_struct(i), pos); %       dist between the bearings line
end                                                 %       and a given point. Return the sum of these distances

end


