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

% figure()
% load("2Cam1Test2Vid1.mat")
% 
% plot(interpX,interpY);
% axis equal
% 
% figure()
% load("2Cam2Test2Vid1.mat")
% plot(interpX,interpY)












%%  

time.test1 = (0:(1/24):(191/24))';
time.test2 = (0:(1/24):(227/24))';
time.test3 = (0:(1/24):(357/24))';
time.test4 = (0:(1/24):(157/24))';
time.test5 = (0:(1/24):(135/24))';

attit = [0.2;0.15;0] * pi/180;
R = RotationMatrix321(attit);
R1 = R';

offset = [0,-5.2344157371925712,1.6778984];

% first test
[positiont1,velocityt1] = estimation(cam_data.test1,time.test1,2);

for i = 1:length(positiont1)
    positiont1(i,:) = (R1 * (positiont1(i,:))')';
end

positiont1 = positiont1 + offset;

%second test
[positiont2,velocityt2] = estimation(cam_data.test2,time.test2,2);

for i = 1:length(positiont2)
    positiont2(i,:) = (R1 * (positiont2(i,:))')';
end

positiont2 = positiont2 + offset;

%third test
[positiont3,velocityt3] = estimation(cam_data.test3,time.test3,2);

for i = 1:length(positiont3)
    positiont3(i,:) = (R1 * (positiont3(i,:))')';
end

positiont3 = positiont3 + offset;

% fourth test
[positiont4,velocityt4] = estimation(cam_data.test4,time.test4,2);

for i = 1:length(positiont4)
    positiont4(i,:) = (R1 * (positiont4(i,:))')';
end

positiont4 = positiont4 + offset;

%fifth test
[positiont5,velocityt5] = estimation(cam_data.test5,time.test5,2);

for i = 1:length(positiont5)
    positiont5(i,:) = (R1 * (positiont5(i,:))')';
end

positiont5 = positiont5 + offset;

%% Error calculation

modpos1 = interp1(time.test1,positiont1,0:0.01:time.test1(end),'pchip');
modpos2 = interp1(time.test2,positiont2,0:0.01:time.test2(end),'pchip');
modpos3 = interp1(time.test3,positiont3,0:0.01:time.test3(end),'pchip');
modpos4 = interp1(time.test4,positiont4,0:0.01:time.test4(end),'pchip');

evec1 = VICON.test1.pos(234:end,:)-modpos1;
t1 = (0:0.01:time.test1(end))';
error1 = (evec1(:,1).^2 + evec1(:,2).^2+evec1(:,3).^2).^(1/2);

evec2 = VICON.test2.pos(233:end,:)-modpos2;
error2 = (evec2(:,1).^2 + evec2(:,2).^2+evec2(:,3).^2).^(1/2);

evec3 = VICON.test3.pos(193:end,:)-modpos3;
error3 = (evec3(:,1).^2 + evec3(:,2).^2+evec3(:,3).^2).^(1/2);

evec4 = VICON.test4.pos(171:end,:)-modpos4;
error4 = (evec4(:,1).^2 + evec4(:,2).^2+evec4(:,3).^2).^(1/2);

[vmod1,~] = EstimateVelocity(modpos1,t1);

%%
figure()
plot(0:0.01:time.test1(end),error1)
xlabel("Time (s)")
ylabel("Error in position")

figure()
plot(0:0.01:time.test2(end),error2)
xlabel("Time (s)")
ylabel("Error in position")

figure()
plot(0:0.01:time.test3(end),error3)
xlabel("Time (s)")
ylabel("Error in position")

figure()
plot(0:0.01:time.test4(end),error4)
xlabel("Time (s)")
ylabel("Error in position")





%% velocity comparison

cam1pos = [0;-5.2324;1.8764];
cam2pos = [-2.9972;0;1.8764];

% test 1
figure()
subplot(3,1,1)
plot(2.4+time.test1,velocityt1(:,1))
hold on
plot(VICON.test1.t,VICON.test1.v(:,1))
% plot(time.test1,velocityt1(:,1))
% plot(0:0.01:time.test1(end),vmod1)

xlabel('time (s)')
ylabel('Vx (m/s)')
title('Test 1 3 Axis Velocity')
legend('Cameras','VICON')

subplot(3,1,2)
plot(2.4+time.test1,velocityt1(:,2))
xlabel('time (s)')
ylabel('Vy (m/s)')
hold on
plot(VICON.test1.t,VICON.test1.v(:,2))

subplot(3,1,3)
plot(2.4+time.test1,velocityt1(:,3))
xlabel('time (s)')
ylabel('Vz (m/s)')
hold on
plot(VICON.test1.t,VICON.test1.v(:,3))

% test 2
figure()
subplot(3,1,1)
plot(2.4+time.test2,velocityt2(:,1))
hold on
plot(VICON.test2.t,VICON.test2.v(:,1))
xlabel('time (s)')
ylabel('Vx (m/s)')
title('Test 2 3 Axis Velocity')
legend('Cameras','VICON')

subplot(3,1,2)
plot(2.4+time.test2,velocityt2(:,2))
hold on
xlabel('time (s)')
ylabel('Vy (m/s)')
plot(VICON.test2.t,VICON.test2.v(:,2))

subplot(3,1,3)
plot(2.4+time.test2,velocityt2(:,3))
hold on
xlabel('time (s)')
ylabel('Vz (m/s)')
plot(VICON.test2.t,VICON.test2.v(:,3))

%test 3
figure()
subplot(3,1,1)
plot(2.25+time.test3,velocityt3(:,1))
hold on
plot(VICON.test3.t,VICON.test3.v(:,1))
xlabel('time (s)')
ylabel('Vx (m/s)')
title('Test 3 3 Axis Velocity')
legend('Cameras','VICON')

subplot(3,1,2)
plot(2.25+time.test3,velocityt3(:,2))
hold on
xlabel('time (s)')
ylabel('Vy (m/s)')
plot(VICON.test3.t,VICON.test3.v(:,2))

subplot(3,1,3)
plot(2.25+time.test3,velocityt3(:,3))
hold on
xlabel('time (s)')
ylabel('Vz (m/s)')
plot(VICON.test3.t,VICON.test3.v(:,3))

%test 4
figure()
subplot(3,1,1)
plot(2+time.test4,velocityt4(:,1))
hold on
plot(VICON.test4.t,VICON.test4.v(:,1))
xlabel('time (s)')
ylabel('Vx (m/s)')
title('Test 4 3 Axis Velocity')
legend('Cameras','VICON')

subplot(3,1,2)
plot(2+time.test4,velocityt4(:,2))
hold on
xlabel('time (s)')
ylabel('Vy (m/s)')
plot(VICON.test4.t,VICON.test4.v(:,2))

subplot(3,1,3)
plot(2+time.test4,velocityt4(:,3))
hold on
xlabel('time (s)')
ylabel('Vz (m/s)')
plot(VICON.test4.t,VICON.test4.v(:,3))

% test 5
figure()
subplot(3,1,1)
plot(1.45+time.test5,velocityt5(:,1))
hold on
plot(VICON.test5.t,VICON.test5.v(:,1))
xlabel('time (s)')
ylabel('Vx (m/s)')
title('Test 5 3 Axis Velocity')
legend('Cameras','VICON')

subplot(3,1,2)
plot(1.45+time.test5,velocityt5(:,2))
hold on
xlabel('time (s)')
ylabel('Vy (m/s)')
plot(VICON.test5.t,VICON.test5.v(:,2))

subplot(3,1,3)
plot(1.45+time.test5,velocityt5(:,3))
hold on
xlabel('time (s)')
ylabel('Vz (m/s)')
plot(VICON.test5.t,VICON.test5.v(:,3))



%% position plot
%test 1
figure()
plot3(positiont1(:,1),positiont1(:,2),positiont1(:,3))
hold on
plot3(VICON.test1.pos(:,1),VICON.test1.pos(:,2),VICON.test1.pos(:,3))
plot3(cam1pos(1),cam1pos(2),cam1pos(3),'mo','MarkerFaceColor','k')
plot3(cam2pos(1),cam2pos(2),cam2pos(3),'go','MarkerFaceColor','k')
legend('Cam data','Vicon','Cam1','Cam2')
xlabel('X-axis')
ylabel('Y-axis')
zlabel('Z-axis')
axis equal
title('Test 1 3d position')
%% 
%test 2
figure()
plot3(positiont2(:,1),positiont2(:,2),positiont2(:,3))
hold on
plot3(VICON.test2.pos(:,1),VICON.test2.pos(:,2),VICON.test2.pos(:,3))
plot3(cam1pos(1),cam1pos(2),cam1pos(3),'mo','MarkerFaceColor','k')
plot3(cam2pos(1),cam2pos(2),cam2pos(3),'go','MarkerFaceColor','k')
legend('Cam data','Vicon','Cam1','Cam2')
xlabel('X-axis')
ylabel('Y-axis')
zlabel('Z-axis')
axis equal
title('Test 2 3d position')

%test 3
figure()
plot3(positiont3(:,1),positiont3(:,2),positiont3(:,3))
hold on
plot3(VICON.test3.pos(:,1),VICON.test3.pos(:,2),VICON.test3.pos(:,3))
plot3(cam1pos(1),cam1pos(2),cam1pos(3),'mo','MarkerFaceColor','k')
plot3(cam2pos(1),cam2pos(2),cam2pos(3),'go','MarkerFaceColor','k')
legend('Cam data','Vicon','Cam1','Cam2')
xlabel('X-axis')
ylabel('Y-axis')
zlabel('Z-axis')
axis equal
title('Test 3 3d position')

%test 4
figure()
plot3(positiont4(:,1),positiont4(:,2),positiont4(:,3))
hold on
plot3(VICON.test4.pos(:,1),VICON.test4.pos(:,2),VICON.test4.pos(:,3))
plot3(cam1pos(1),cam1pos(2),cam1pos(3),'mo','MarkerFaceColor','k')
plot3(cam2pos(1),cam2pos(2),cam2pos(3),'go','MarkerFaceColor','k')
legend('Cam data','Vicon','Cam1','Cam2')
xlabel('X-axis')
ylabel('Y-axis')
zlabel('Z-axis')
axis equal
title('Test 4 3d position')

%test 5
figure()
plot3(positiont5(:,1),positiont5(:,2),positiont5(:,3))
hold on
plot3(VICON.test5.pos(:,1),VICON.test5.pos(:,2),VICON.test5.pos(:,3))
plot3(cam1pos(1),cam1pos(2),cam1pos(3),'mo','MarkerFaceColor','k')
plot3(cam2pos(1),cam2pos(2),cam2pos(3),'go','MarkerFaceColor','k')
legend('Cam data','Vicon','Cam1','Cam2')
xlabel('X-axis')
ylabel('Y-axis')
zlabel('Z-axis')
axis equal
title('Test 5 3d position')



function [position,velocity] = estimation(PixPos,time,n)
    
    camInfo = CameraInformation();
    
    for j=1:length(time)
    
        position(j,:) = ThreeDLines(PixPos,camInfo,n,j);
    
    end
    
    [velocity,~] = EstimateVelocity(position,time);

end

function camInfo = CameraInformation()

Rx = RotationMatrix321([pi/2;0;0]);

% Cam 1
camInfo.cam1.X = 0;
camInfo.cam1.Y = 0;
camInfo.cam1.Z = 0;

% [0;-5.2324;1.6764]

camInfo.cam1.R = eye(3,3);
camInfo.cam1.resolution = [3840;2880];

camInfo.cam1.FOV_w = 107.11;
camInfo.cam1.FOV_l = 74.22; % deg

% Cam 2
camInfo.cam2.X = -2.9972;
camInfo.cam2.Y = 5.2344157371925712;
camInfo.cam2.Z = 0;

% [-2.9972;0;1.6764]

attitude1 =  [0.5851339;89.7897107;0]*(pi/180);
R2 = RotationMatrix321(attitude1);

camInfo.cam2.R = Rx*R2'*Rx';

% camInfo.cam2.attitude = [0;0;92.5];
camInfo.cam2.resolution = [3840;2880];

camInfo.cam2.FOV_w = 107.11;
camInfo.cam2.FOV_l = 74.22; % deg

end

function cam = camData()

cam.test1.cam1.x = cell2mat(struct2cell(load('2Cam1Test2Vid1.mat','interpX')));
cam.test1.cam1.z = cell2mat(struct2cell(load('2Cam1Test2Vid1.mat','interpY')));
cam.test1.cam1.bool = ones(length(cam.test1.cam1.x),1);
cam.test1.cam2.x = cell2mat(struct2cell(load('2Cam2Test2Vid1.mat','interpX')));
cam.test1.cam2.x(1:12) = [];
cam.test1.cam2.z = cell2mat(struct2cell(load('2Cam2Test2Vid1.mat','interpY')));
cam.test1.cam2.z(1:12) = [];
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
cam.test3.cam2.x(1:2) = [];
cam.test3.cam2.z = cell2mat(struct2cell(load('2Cam2Test2Vid3.mat','interpY')));
cam.test3.cam2.z(1:2) = [];
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














