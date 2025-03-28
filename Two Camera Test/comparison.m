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
time.test2 = (0:(1/24):(227/24))';
time.test3 = (0:(1/24):(357/24))';
time.test4 = (0:(1/24):(157/24))';
time.test5 = (0:(1/24):(135/24))';


[positiont1,velocityt1] = estimation(cam_data.test1,time.test1,2);
[positiont2,velocityt2] = estimation(cam_data.test2,time.test2,2);
[positiont3,velocityt3] = estimation(cam_data.test3,time.test3,2);
[positiont4,velocityt4] = estimation(cam_data.test4,time.test4,2);
[positiont5,velocityt5] = estimation(cam_data.test5,time.test5,2);


%% velocity comparison

vnorm = sqrt(velocityt1(:,1).^2 + velocityt1(:,2).^2 + velocityt1(:,3).^2);

vnormV = sqrt(VICON.test1.v(:,1).^2 + VICON.test1.v(:,2).^2 + VICON.test1.v(:,3).^2);

% VICONindice = find(vnormV == min(vnormV(400:600)));
% 
% ind = find(vnorm == min(vnorm(2:end)));

vnorm2 = sqrt(velocityt2(:,1).^2 + velocityt2(:,2).^2 + velocityt2(:,3).^2);
vnormV2 = sqrt(VICON.test2.v(:,1).^2 + VICON.test2.v(:,2).^2 + VICON.test2.v(:,3).^2);

vnorm3 = sqrt(velocityt3(:,1).^2 + velocityt3(:,2).^2 + velocityt3(:,3).^2);
vnormV3 = sqrt(VICON.test3.v(:,1).^2 + VICON.test3.v(:,2).^2 + VICON.test3.v(:,3).^2);

vnorm4 = sqrt(velocityt4(:,1).^2 + velocityt4(:,2).^2 + velocityt4(:,3).^2);
vnormV4 = sqrt(VICON.test4.v(:,1).^2 + VICON.test4.v(:,2).^2 + VICON.test4.v(:,3).^2);

vnorm5 = sqrt(velocityt5(:,1).^2 + velocityt5(:,2).^2 + velocityt5(:,3).^2);
vnormV5 = sqrt(VICON.test5.v(:,1).^2 + VICON.test5.v(:,2).^2 + VICON.test5.v(:,3).^2);

% test 1
figure()
plot(2.4+time.test1,vnorm)
hold on
plot(VICON.test1.t,vnormV)
xlabel('time (s)')
ylabel('V magnitude (m/s)')
title('Test 1 velocity magnitude')
legend('Cameras','VICON')

% test 2
figure()
plot(2.4+time.test2,vnorm2)
hold on
plot(VICON.test2.t,vnormV2)
xlabel('time (s)')
ylabel('V magnitude (m/s)')
title('Test 2 velocity magnitude')
legend('Cameras','VICON')

%test 3
figure()
plot(2.25+time.test3,vnorm3)
hold on
plot(VICON.test3.t,vnormV3)
xlabel('time (s)')
ylabel('V magnitude (m/s)')
title('Test 3 velocity magnitude')
legend('Cameras','VICON')

%test 4
figure()
plot(2.4+time.test4,vnorm4)
hold on
plot(VICON.test4.t,vnormV4)
xlabel('time (s)')
ylabel('V magnitude (m/s)')
title('Test 4 velocity magnitude')
legend('Cameras','VICON')

% test 5
figure()
plot(2.4+time.test5,vnorm5)
hold on
plot(VICON.test5.t,vnormV5)
xlabel('time (s)')
ylabel('V magnitude (m/s)')
title('Test 5 velocity magnitude')
legend('Cameras','VICON')



% %%
% %test 1
% figure()
% plot3(positiont1(:,1),positiont1(:,2),positiont1(:,3))
% hold on
% plot3(VICON.test1.pos(:,1),VICON.test1.pos(:,2),VICON.test1.pos(:,3))
% legend('Cam','Vicon')
% xlabel('X-axis')
% ylabel('Y-axis')
% zlabel('Z-axis')
% axis equal
% title('Test 1 3d position')
% 
% %test 2
% figure()
% plot3(positiont2(:,1),positiont2(:,2),positiont2(:,3))
% hold on
% plot3(VICON.test2.pos(:,1),VICON.test2.pos(:,2),VICON.test2.pos(:,3))
% legend('Cam','Vicon')
% xlabel('X-axis')
% ylabel('Y-axis')
% zlabel('Z-axis')
% axis equal
% title('Test 2 3d position')
% 
% %test 3
% figure()
% plot3(positiont3(:,1),positiont3(:,2),positiont3(:,3))
% hold on
% plot3(VICON.test3.pos(:,1),VICON.test3.pos(:,2),VICON.test3.pos(:,3))
% legend('Cam','Vicon')
% xlabel('X-axis')
% ylabel('Y-axis')
% zlabel('Z-axis')
% axis equal
% title('Test 3 3d position')
% 
% %test 4
% figure()
% plot3(positiont4(:,1),positiont4(:,2),positiont4(:,3))
% hold on
% plot3(VICON.test4.pos(:,1),VICON.test4.pos(:,2),VICON.test4.pos(:,3))
% legend('Cam','Vicon')
% xlabel('X-axis')
% ylabel('Y-axis')
% zlabel('Z-axis')
% axis equal
% title('Test 4 3d position')
% 
% %test 5
% figure()
% plot3(positiont5(:,1),positiont5(:,2),positiont5(:,3))
% hold on
% plot3(VICON.test5.pos(:,1),VICON.test5.pos(:,2),VICON.test5.pos(:,3))
% legend('Cam','Vicon')
% xlabel('X-axis')
% ylabel('Y-axis')
% zlabel('Z-axis')
% axis equal
% title('Test 5 3d position')
% 


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
cam.test2.cam2.bool = ones(length(cam.test2.cam2.x),1);

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














