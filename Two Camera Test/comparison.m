clear all; clc; close all;

%% VICON data
VD.test1 = readmatrix("TOMATOSOUPS_Trial.csv");
VD.test2 = readmatrix("TOMATOSOUPS_Trial 2.csv");
VD.test3 = readmatrix("TOMATOSOUPS_Trial 3.csv");
VD.test4 = readmatrix("TOMATOSOUPS_Trial 4.csv");
VD.test5 = readmatrix("TOMATOSOUPS_Trial 5.csv");

names = fieldnames(VD);

for i = 1:5
    VICON.(names{i}).t = VD.(names{i})(4:end,1) / 100;
    VICON.(names{i}).pos = (VD.(names{i})(4:end,6:8))/1000;
    [VICON.(names{i}).v,~] = EstimateVelocity(VICON.(names{i}).pos,VICON.(names{i}).t);

end

%% Camera data





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















