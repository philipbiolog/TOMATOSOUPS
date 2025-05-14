clear; clc; close all;

% Compare Vicon to Estimate


%% VICON data
VD.test1 = readmatrix("Vicon/TOMATOSOUPS Day2 Trial.csv");
VD.test2 = readmatrix("Vicon/TOMATOSOUPS Day2 Trial 1.csv");
VD.test3 = readmatrix("Vicon/TOMATOSOUPS Day2 Trial 2.csv");
VD.test4 = readmatrix("Vicon/TOMATOSOUPS Day2 Trial 3.csv");
VD.test5 = readmatrix("Vicon/TOMATOSOUPS Day2 Trial 4.csv");

names = fieldnames(VD);

for i = 1:5
    VICON.(names{i}).t = VD.(names{i})(4:end,1) / 100;
    VICON.(names{i}).pos = (VD.(names{i})(4:end,6:8))/1000;

end

%% Camera data

Test1_cam1 = camData('1Test2Vid1', CameraInformation_2C(1));
Test1_cam2 = camData('2Test2Vid1', CameraInformation_2C(2));
Test1_cam_array = [Test1_cam1, Test1_cam2];

Test2_cam1 = camData('1Test2Vid2', CameraInformation_2C(1));
Test2_cam2 = camData('2Test2Vid2', CameraInformation_2C(2));
Test2_cam_array = [Test2_cam1, Test2_cam2];

Test3_cam1 = camData('1Test2Vid3', CameraInformation_2C(1));
Test3_cam2 = camData('2Test2Vid3', CameraInformation_2C(2));
Test3_cam_array = [Test3_cam1, Test3_cam2];

Test4_cam1 = camData('1Test2Vid4', CameraInformation_2C(1));
Test4_cam2 = camData('2Test2Vid4', CameraInformation_2C(2));
Test4_cam_array = [Test4_cam1, Test4_cam2];

Test5_cam1 = camData('1Test2Vid5', CameraInformation_2C(1));
Test5_cam2 = camData('2Test2Vid5', CameraInformation_2C(2));
Test5_cam_array = [Test5_cam1, Test5_cam2];

%% Position Estimation

position1 = posEstimate(Test1_cam_array);
position2 = posEstimate(Test2_cam_array);
position3 = posEstimate(Test3_cam_array);
position4 = posEstimate(Test4_cam_array);
position5 = posEstimate(Test5_cam_array);

time.test1 = (0:(1/24):(191/24))';
time.test2 = (0:(1/24):(227/24))';
time.test3 = (0:(1/24):(357/24))';
time.test4 = (0:(1/24):(157/24))';
time.test5 = (0:(1/24):(135/24))';

%% Offset

offset = [1.65314, 5.16225, 0.152644] - [1.92997, -0.0677321, 1.88748]; 


Truth1 = VICON.test1.pos  + ones(size(VICON.test1.pos)).*offset;        % VICON offfset into our camera origin
Truth2 = VICON.test2.pos  + ones(size(VICON.test2.pos)).*offset;
Truth3 = VICON.test3.pos  + ones(size(VICON.test3.pos)).*offset;
Truth4 = VICON.test4.pos  + ones(size(VICON.test4.pos)).*offset;
Truth5 = VICON.test5.pos  + ones(size(VICON.test5.pos)).*offset;


%% Plotting Figures


figure()
plot3(position1(1, :), position1(2,:), position1(3,:))
hold on
plot3(Truth1(:,1),Truth1(:,2),Truth1(:,3))
legend('TOMATOSOUPS','VICON')
xlabel('X-axis')
ylabel('Y-axis')
zlabel('Z-axis')
axis equal
title('Test 1 3d position')

figure()
plot3(position2(1, :), position2(2,:), position2(3,:))
hold on
plot3(Truth2(:,1),Truth2(:,2),Truth2(:,3))
legend('TOMATOSOUPS','VICON')
xlabel('X-axis')
ylabel('Y-axis')
zlabel('Z-axis')
axis equal
title('Test 1 3d position')

figure()
plot3(position3(1, :), position3(2,:), position3(3,:))
hold on
plot3(Truth3(:,1),Truth3(:,2),Truth3(:,3))
legend('TOMATOSOUPS','VICON')
xlabel('X-axis')
ylabel('Y-axis')
zlabel('Z-axis')
axis equal
title('Test 1 3d position')

figure()
plot3(position4(1, :), position4(2,:), position4(3,:))
hold on
plot3(Truth4(:,1),Truth4(:,2),Truth4(:,3))
legend('TOMATOSOUPS','VICON')
xlabel('X-axis')
ylabel('Y-axis')
zlabel('Z-axis')
axis equal
title('Test 1 3d position')

figure()
plot3(position5(1, :), position5(2,:), position5(3,:))
hold on
plot3(Truth5(:,1),Truth5(:,2),Truth5(:,3))
legend('TOMATOSOUPS','VICON')
xlabel('X-axis')
ylabel('Y-axis')
zlabel('Z-axis')
axis equal
title('Test 1 3d position')

%% Error Estimation

modpos1 = interp1(time.test1,position1',0:0.01:time.test1(end),'pchip');
modpos2 = interp1(time.test2,position2',0:0.01:time.test2(end),'pchip');
modpos3 = interp1(time.test3,position3',0:0.01:time.test3(end),'pchip');
modpos4 = interp1(time.test4,position4',0:0.01:time.test4(end),'pchip');
modpos5 = interp1(time.test5,position5',0:0.01:time.test5(end),'pchip');

evec1 = Truth1(260:end,:)-modpos1(1:end-26, :);

evec2 = Truth2(256:end,:)-modpos2(1:end-23, :);

evec3 = Truth3(226:end,:)-modpos3(1:end-33, :);

evec4 = Truth4(191:end,:)-modpos4(1:end-20, :);

evec5 = Truth5(217:end,:)-modpos5(1:end-46, :);



%% Error Plotting

figure()
subplot(3, 1, 1)
plot([0, 10], [.2, .2], 'k--')
hold on
title("3-Axis Position Error between Estimate and VICON")
plot(0:.01:(length(evec1)-1)/100, evec1(:, 1))
plot(0:.01:(length(evec2)-1)/100, evec2(:, 1))
plot(0:.01:(length(evec3)-1)/100, evec3(:, 1))
plot(0:.01:(length(evec4)-1)/100, evec4(:, 1))
plot(0:.01:(length(evec5)-1)/100, evec5(:, 1))
plot([0, 10], [-.2, -.2], 'k--')
xlim([0, 10])
xlabel("Time [s]")
ylabel("X Error [m]")
hold off

subplot(3, 1, 2)
plot([0, 10], [.2, .2], 'k--')
hold on
plot(0:.01:(length(evec1)-1)/100, evec1(:, 2))
plot(0:.01:(length(evec2)-1)/100, evec2(:, 2))
plot(0:.01:(length(evec3)-1)/100, evec3(:, 2))
plot(0:.01:(length(evec4)-1)/100, evec4(:, 2))
plot(0:.01:(length(evec5)-1)/100, evec5(:, 2))
plot([0, 10], [-.2, -.2], 'k--')
xlim([0, 10])
xlabel("Time [s]")
ylabel("Y Error [m]")
hold off

subplot(3, 1, 3)
plot([0, 10], [.2, .2], 'k--')
hold on
plot(0:.01:(length(evec1)-1)/100, evec1(:, 3))
plot(0:.01:(length(evec2)-1)/100, evec2(:, 3))
plot(0:.01:(length(evec3)-1)/100, evec3(:, 3))
plot(0:.01:(length(evec4)-1)/100, evec4(:, 3))
plot(0:.01:(length(evec5)-1)/100, evec5(:, 3))
plot([0, 10], [-.2, -.2], 'k--')
xlim([0, 10])
xlabel("Time [s]")
ylabel("Z Error [m]")
legend([""; "Test 1"; "Test 2"; "Test 3"; "Test 4"; "Test 5"], 'Location','southeast')
hold off


%% Error Value Calculation 

tol = .2;
evec1 = abs(evec1);
evec2 = abs(evec2);
evec3 = abs(evec3);
evec4 = abs(evec4);
evec5 = abs(evec5);
totalError = [evec1; evec2; evec3; evec4; evec5];

[mean(totalError((totalError(:, 1)>=0), 1)), mean(totalError((totalError(:, 2)>=0), 2)), mean(totalError((totalError(:, 3)>=0), 3))]

[mean(evec1(:, 1)), mean(evec1(:, 2)), mean(evec1(:, 3))]
[mean(evec2(:, 1)), mean(evec2(:, 2)), mean(evec2(:, 3))]
[mean(evec3((evec3(:, 1)>=0), 1)), mean(evec3((evec3(:, 2)>=0), 2)), mean(evec3((evec3(:, 3)>=0), 3))]
[mean(evec4((evec4(:, 1)>=0), 1)), mean(evec4((evec4(:, 2)>=0), 2)), mean(evec4((evec4(:, 3)>=0), 3))]
[mean(evec5(:, 1)), mean(evec5(:, 2)), mean(evec5(:, 3))]

%% Velocity Calculation

Vel1 = diff(position1, 1, 2)';
Vel2 = diff(position2, 1, 2)';
Vel3 = diff(position3, 1, 2)';
Vel4 = diff(position4, 1, 2)';
Vel5 = diff(position5, 1, 2)';

ViconVel1 = diff(Truth1);
ViconVel2 = diff(Truth2);
ViconVel3 = diff(Truth3);
ViconVel4 = diff(Truth4);
ViconVel5 = diff(Truth5);

%% Velocity Plotting



%% Velocity Error

modvel1 = interp1(time.test1(2:end),Vel1,0:0.01:time.test1(end),'pchip');
modvel2 = interp1(time.test2(2:end),Vel2,0:0.01:time.test2(end),'pchip');
modvel3 = interp1(time.test3(2:end),Vel3,0:0.01:time.test3(end),'pchip');
modvel4 = interp1(time.test4(2:end),Vel4,0:0.01:time.test4(end),'pchip');
modvel5 = interp1(time.test5(2:end),Vel5,0:0.01:time.test5(end),'pchip');

evel1 = ViconVel1(260-1:end,:)-modvel1(1:end-26, :);

evel2 = ViconVel2(256-1:end,:)-modvel2(1:end-23, :);

evel3 = ViconVel3(226-1:end,:)-modvel3(1:end-33, :);

evel4 = ViconVel4(191-1:end,:)-modvel4(1:end-20, :);

evel5 = ViconVel5(217-1:end,:)-modvel5(1:end-46, :);

rvel1 = evel1 ./ ViconVel1(260-1:end, :) * 100;
rvel2 = evel2 ./ ViconVel2(256-1:end, :) * 100;
rvel3 = evel3 ./ ViconVel3(226-1:end, :) * 100;
rvel4 = evel4 ./ ViconVel4(191-1:end, :) * 100;
rvel5 = evel5 ./ ViconVel5(217-1:end, :) * 100;



