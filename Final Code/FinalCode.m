clear all; clc; close all;


function [position,velocity] = estimation(PixPos,time,n)
    
    camInfo = CameraInformation();
    
    for j=1:length(time)
    
        position(j,:) = ThreeDLines(PixPos,camInfo,n,j);
    
    end
    
    [raw_data,velocity] = EstimateVelocity(position,time);

end

function camInfo = CameraInformation()

% Cam 1
camInfo.cam1.X = 8.13816;
camInfo.cam1.Y = 3.9647433024;
camInfo.cam1.Z = -0.005;

camInfo.cam1.attitude = [-0.11;0;90];
camInfo.cam1.resolution = [3840;2160];

camInfo.cam1.FOV_w = 107;
camInfo.cam1.FOV_l = 74.22; % deg

% Cam 2
camInfo.cam2.X = 0;
camInfo.cam2.Y = 0;
camInfo.cam2.Z = 0;

camInfo.cam2.attitude = [0;0;0];
camInfo.cam2.resolution = [3840;2160];

camInfo.cam2.FOV_w = 107;
camInfo.cam2.FOV_l = 74.22; % deg

end















