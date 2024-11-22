clc; clear; close all;
%% Camera Initialization
n = 20; % Fidelity
z_offset = 15;
Pos = [0, 50, 20];

%camera 1
cameraInfo1.resolution = [7680;4320]; % pixels
cameraInfo1.FOV_w = 157;
cameraInfo1.FOV_l = 80; % deg
cameraInfo1.attitude = [-10;0;0]; % deg
cameraInfo1.X = -1;
cameraInfo1.Y = 0;
cameraInfo1.Z = 14; % meters

%camera 2
cameraInfo2.resolution = [7680;4320];
cameraInfo2.FOV_w = 157;
cameraInfo2.FOV_l = 80;
cameraInfo2.attitude = [-10;0;0];
cameraInfo2.X = 1;
cameraInfo2.Y = 0;
cameraInfo2.Z = 14;

%camera 3
cameraInfo3.resolution = [7680;4320]; % pixels
cameraInfo3.FOV_w = 157;
cameraInfo3.FOV_l = 80; % deg
cameraInfo3.attitude = [0;0;45]; % deg
cameraInfo3.X = -30;
cameraInfo3.Y = 0;
cameraInfo3.Z = 4; % meters

%camera 4
cameraInfo4.resolution = [7680;4320];
cameraInfo4.FOV_w = 157;
cameraInfo4.FOV_l = 80;
cameraInfo4.attitude = [0;0;-45];
cameraInfo4.X = 30;
cameraInfo4.Y = 0;
cameraInfo4.Z = 4;

%camera 5
cameraInfo5.resolution = [7680;4320]; % pixels
cameraInfo5.FOV_w = 157;
cameraInfo5.FOV_l = 80; % deg
cameraInfo5.attitude = [-5;0;-60]; % deg
cameraInfo5.X = -40;
cameraInfo5.Y = 50;
cameraInfo5.Z = 4; % meters

%camera 6
cameraInfo6.resolution = [7680;4320];
cameraInfo6.FOV_w = 157;
cameraInfo6.FOV_l = 80;
cameraInfo6.attitude = [-5;0;60];
cameraInfo6.X = 40;
cameraInfo6.Y = 50;
cameraInfo6.Z = 4;

%camera 7
cameraInfo7.resolution = [7680;4320]; % pixels
cameraInfo7.FOV_w = 157;
cameraInfo7.FOV_l = 80; % deg
cameraInfo7.attitude = [0;0;-120]; % deg
cameraInfo7.X = -40;
cameraInfo7.Y = 100;
cameraInfo7.Z = 4; % meters

%camera 8
cameraInfo8.resolution = [7680;4320];
cameraInfo8.FOV_w = 157;
cameraInfo8.FOV_l = 80;
cameraInfo8.attitude = [0;0;120];
cameraInfo8.X = 40;
cameraInfo8.Y = 100;
cameraInfo8.Z = 4;

camInfo = struct('cam1',cameraInfo1,'cam2', cameraInfo2,'cam3',cameraInfo3,...
    'cam4',cameraInfo4,'cam5',cameraInfo5,'cam6',cameraInfo6,'cam7',cameraInfo7,'cam8',cameraInfo8);

Pixel1 = TrajectoryToCamera(Pos, cameraInfo1);
Pixel2 = TrajectoryToCamera(Pos, cameraInfo2);
Pixel3 = TrajectoryToCamera(Pos, cameraInfo3);
Pixel4 = TrajectoryToCamera(Pos, cameraInfo4);
Pixel5 = TrajectoryToCamera(Pos, cameraInfo5);
Pixel6 = TrajectoryToCamera(Pos, cameraInfo6);
Pixel7 = TrajectoryToCamera(Pos, cameraInfo7);
Pixel8 = TrajectoryToCamera(Pos, cameraInfo8);
% Pixel1 = Pixel1(1:2);
% Pixel2 = Pixel2(1:2);
% Pixel3 = Pixel3(1:2);
% Pixel4 = Pixel4(1:2);
% Pixel5 = Pixel5(1:2);
% Pixel6 = Pixel6(1:2);
% Pixel7 = Pixel7(1:2);
% Pixel8 = Pixel8(1:2);

fidelity = 100;
ErrorPos = zeros(fidelity, 3);
Error = zeros(8, 3);
for i=1:fidelity
    for j=1:8
        Error(i, 1:2) = 10*randn(1, 2);
    end
    pixel_pos = [Pixel1 + Error(1, :);Pixel2 + Error(2, :);Pixel3 + Error(3, :);Pixel4 + Error(4, :);Pixel5 + Error(5, :);Pixel6 + Error(6, :);Pixel7 + Error(7, :);Pixel8 + Error(8, :)];
    position = ThreeDLines(pixel_pos,camInfo,8);
    ErrorPos(i, :) = Pos - position';
end
figure
histogram(Error(:, 1), 'NumBins',50, 'FaceColor', 'b')
xlabel("Injected Error")
ylabel("Number of Simulations")

figure
ErrorX = rmoutliers(ErrorPos(:, 1));
histogram(ErrorPos(:, 1), 'NumBins', 50, 'FaceColor', 'r')
xlabel("Estimated X Error")
ylabel("Number of Simulations")

figure
histogram(ErrorX, 'NumBins', 50, 'FaceColor', 'b')
xlabel("Estimated X Error with no Outliers")
ylabel("Number of Simulations")















