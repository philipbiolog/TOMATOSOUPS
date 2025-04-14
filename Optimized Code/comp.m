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

cam1 = camData('1Test2Vid1', CameraInformation(1));
cam2 = camData('2Test2Vid1', CameraInformation(2));
cam_array = [cam1, cam2];

%% Position Estimation

position1 = posEstimate(cam_array);

time.test1 = (0:(1/24):(191/24))';

figure()
plot3(position1(1, :),position1(2,:),position1(3,:))
hold on
plot3(VICON.test1.pos(:,1),VICON.test1.pos(:,3),-VICON.test1.pos(:,2)+.8)

legend('Cam','Vicon')
xlabel('X-axis')
ylabel('Y-axis')
zlabel('Z-axis')
axis equal
title('Test 1 3d position')

figure()
subplot(3, 1, 1)
plot(VICON.test1.pos(:, 1))
title('x pos')

subplot(3, 1, 2)
plot(VICON.test1.pos(:, 2))
title('y pos')

subplot(3, 1, 3)
plot(VICON.test1.pos(:, 3))
title('z pos')


