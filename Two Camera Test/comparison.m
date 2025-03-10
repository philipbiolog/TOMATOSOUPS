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

cam_data = camData();

time = linspace(0,14.75,354)';

[position,velocity] = estimation(cam_data.test1,time,2);

plot3(position(:,1),position(:,2),position(:,3))
hold on
plot3(VICON.test1.pos(:,1),VICON.test1.pos(:,2),VICON.test1.pos(:,3))
legend('Cam','Vicon')
xlabel('X-axis')
ylabel('Y-axis')
zlabel('Z-axis')


function [position,velocity] = estimation(PixPos,time,n)
    
    camInfo = CameraInformation();
    
    for j=1:length(time)
    
        position(j,:) = ThreeDLines(PixPos,camInfo,n,j);
    
    end
    
    [velocity,~] = EstimateVelocity(position,time);

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

function cam = camData()

cam.test1.cam1.x = cell2mat(struct2cell(load('2Cam11.mat','interpX')));
cam.test1.cam1.z = cell2mat(struct2cell(load('2Cam11.mat','interpY')));
cam.test1.cam1.bool = ones(length(cam.test1.cam1.x),1);
cam.test1.cam2.x = cell2mat(struct2cell(load('2Cam21.mat','interpX')));
cam.test1.cam2.z = cell2mat(struct2cell(load('2Cam21.mat','interpY')));
cam.test1.cam2.bool = ones(length(cam.test1.cam2.x),1);

cam.test2.cam1.x = cell2mat(struct2cell(load('2Cam12.mat','interpX')));
cam.test2.cam1.z = cell2mat(struct2cell(load('2Cam12.mat','interpY')));
cam.test2.cam1.bool = ones(length(cam.test2.cam1.x),1);
cam.test2.cam2.x = cell2mat(struct2cell(load('2Cam22.mat','interpX')));
cam.test2.cam2.z = cell2mat(struct2cell(load('2Cam22.mat','interpY')));
cam.test2.cam1.bool = ones(length(cam.test2.cam2.x),1);

cam.test3.cam1.x = cell2mat(struct2cell(load('2Cam13.mat','interpX')));
cam.test3.cam1.z = cell2mat(struct2cell(load('2Cam13.mat','interpY')));
cam.test3.cam1.bool = ones(length(cam.test3.cam1.x),1);
cam.test3.cam2.x = cell2mat(struct2cell(load('2Cam23.mat','interpX')));
cam.test3.cam2.z = cell2mat(struct2cell(load('2Cam23.mat','interpY')));
cam.test3.cam2.bool = ones(length(cam.test3.cam2.x),1);

cam.test4.cam1.x = cell2mat(struct2cell(load('2Cam14.mat','interpX')));
cam.test4.cam1.z = cell2mat(struct2cell(load('2Cam14.mat','interpY')));
cam.test4.cam1.bool = ones(length(cam.test4.cam1.x),1);
cam.test4.cam2.x = cell2mat(struct2cell(load('2Cam24.mat','interpX')));
cam.test4.cam2.z = cell2mat(struct2cell(load('2Cam24.mat','interpY')));
cam.test4.cam2.bool = ones(length(cam.test4.cam2.x),1);

cam.test5.cam1.x = cell2mat(struct2cell(load('2Cam15.mat','interpX')));
cam.test5.cam1.z = cell2mat(struct2cell(load('2Cam15.mat','interpY')));
cam.test5.cam1.bool = ones(length(cam.test5.cam1.x),1);
cam.test5.cam2.x = cell2mat(struct2cell(load('2Cam25.mat','interpX')));
cam.test5.cam2.z = cell2mat(struct2cell(load('2Cam25.mat','interpY')));
cam.test5.cam2.bool = ones(length(cam.test5.cam2.x),1);

cam.test6.cam1.x = cell2mat(struct2cell(load('2Cam16.mat','interpX')));
cam.test6.cam1.z = cell2mat(struct2cell(load('2Cam16.mat','interpY')));
cam.test6.cam1.bool = ones(length(cam.test6.cam1.x),1);
cam.test6.cam2.x = cell2mat(struct2cell(load('2Cam26.mat','interpX')));
cam.test6.cam2.z = cell2mat(struct2cell(load('2Cam26.mat','interpY')));
cam.test6.cam2.bool = ones(length(cam.test6.cam2.x),1);

end














