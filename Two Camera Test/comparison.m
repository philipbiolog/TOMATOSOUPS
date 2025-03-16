clear all; clc; close all;

%% VICON data
VD.test1 = readmatrix("TOMATOSOUPS Day2 Trial.csv");
VD.test2 = readmatrix("TOMATOSOUPS Day2 Trial 1.csv");
VD.test3 = readmatrix("TOMATOSOUPS Day2 Trial 2.csv");
VD.test4 = readmatrix("TOMATOSOUPS Day2 Trial 3.csv");
VD.test5 = readmatrix("TOMATOSOUPS Day2 Trial 4.csv");

names = fieldnames(VD);

for i = 1:5
    VICON.(names{i}).t = VD.(names{i})(4:end,1) / 100;
    VICON.(names{i}).pos = (VD.(names{i})(4:end,6:8))/1000;
    [VICON.(names{i}).v,~] = EstimateVelocity(VICON.(names{i}).pos,VICON.(names{i}).t);

end

%% Camera data

cam_data = camData();

time.test1 = (0:(1/24):(191/24))';
time.test2 = (0:(1/24):(228/24))';
time.test3 = (0:(1/24):(358/24))';
time.test4 = (0:(1/24):(158/24))';
time.test5 = (0:(1/24):(136/24))';



[positiont1,velocityt1] = estimation(cam_data.test1,time.test1,2);
[positiont2,velocityt2] = estimation(cam_data.test2,time.test2,2);
[positiont3,velocityt3] = estimation(cam_data.test3,time.test3,2);
[positiont4,velocityt4] = estimation(cam_data.test4,time.test4,2);
[positiont5,velocityt5] = estimation(cam_data.test5,time.test5,2);





%%
figure()
plot3(positiont1(:,1),positiont1(:,2),positiont1(:,3))
hold on
plot3(VICON.test1.pos(:,1),VICON.test1.pos(:,2),VICON.test1.pos(:,3))
legend('Cam','Vicon')
xlabel('X-axis')
ylabel('Y-axis')
zlabel('Z-axis')


figure()
plot(time.test1,position(:,1))





function [position,velocity] = estimation(PixPos,time,n)
    
    camInfo = CameraInformation();
    
    for j=1:length(time)
    
        position(j,:) = ThreeDLines(PixPos,camInfo,n,j);
    
    end
    
    [velocity,~] = EstimateVelocity(position,time);

end

function camInfo = CameraInformation()

% Cam 1
camInfo.cam1.X = 5.23441573719257125;
camInfo.cam1.Z = 0.06492045842642645004;
camInfo.cam1.Y = 2.938185923755515905;

camInfo.cam1.attitude = [0.5851339;0;89.7897107];
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

cam.test1.cam1.x = cell2mat(struct2cell(load('2Cam1Test2Vid1.mat','interpX')));
cam.test1.cam1.z = cell2mat(struct2cell(load('2Cam1Test2Vid1.mat','interpY')));
cam.test1.cam1.bool = ones(length(cam.test1.cam1.x),1);
cam.test1.cam2.x = cell2mat(struct2cell(load('2Cam2Test2Vid1.mat','interpX')));
cam.test1.cam2.z = cell2mat(struct2cell(load('2Cam2Test2Vid1.mat','interpY')));
cam.test1.cam2.bool = ones(length(cam.test1.cam2.x),1);

cam.test2.cam1.x = cell2mat(struct2cell(load('2Cam1Test2Vid2.mat','interpX')));
cam.test2.cam1.z = cell2mat(struct2cell(load('2Cam1Test2Vid2.mat','interpY')));
cam.test2.cam1.bool = ones(length(cam.test2.cam1.x),1);
cam.test2.cam2.x = cell2mat(struct2cell(load('2Cam2Test2Vid2.mat','interpX')));
cam.test2.cam2.z = cell2mat(struct2cell(load('2Cam2Test2Vid2.mat','interpY')));
cam.test2.cam1.bool = ones(length(cam.test2.cam2.x),1);

cam.test3.cam1.x = cell2mat(struct2cell(load('2Cam1Test2Vid3.mat','interpX')));
cam.test3.cam1.z = cell2mat(struct2cell(load('2Cam1Test2Vid3.mat','interpY')));
cam.test3.cam1.bool = ones(length(cam.test3.cam1.x),1);
cam.test3.cam2.x = cell2mat(struct2cell(load('2Cam2Test2Vid3.mat','interpX')));
cam.test3.cam2.z = cell2mat(struct2cell(load('2Cam2Test2Vid3.mat','interpY')));
cam.test3.cam2.bool = ones(length(cam.test3.cam2.x),1);

cam.test4.cam1.x = cell2mat(struct2cell(load('2Cam1Test2Vid4.mat','interpX')));
cam.test4.cam1.z = cell2mat(struct2cell(load('2Cam1Test2Vid4.mat','interpY')));
cam.test4.cam1.bool = ones(length(cam.test4.cam1.x),1);
cam.test4.cam2.x = cell2mat(struct2cell(load('2Cam2Test2Vid4.mat','interpX')));
cam.test4.cam2.z = cell2mat(struct2cell(load('2Cam2Test2Vid4.mat','interpY')));
cam.test4.cam2.bool = ones(length(cam.test4.cam2.x),1);

cam.test5.cam1.x = cell2mat(struct2cell(load('2Cam1Test2Vid5.mat','interpX')));
cam.test5.cam1.z = cell2mat(struct2cell(load('2Cam1Test2Vid5.mat','interpY')));
cam.test5.cam1.bool = ones(length(cam.test5.cam1.x),1);
cam.test5.cam2.x = cell2mat(struct2cell(load('2Cam2Test2Vid5.mat','interpX')));
cam.test5.cam2.z = cell2mat(struct2cell(load('2Cam2Test2Vid5.mat','interpY')));
cam.test5.cam2.bool = ones(length(cam.test5.cam2.x),1);

end














