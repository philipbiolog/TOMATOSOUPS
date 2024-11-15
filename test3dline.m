clear; clc; close all;

%% Camera Initialization
Pos = [10, 50, 10];

cameraInfo1.resolution = [3840;2160]; % pixels
cameraInfo1.FOV_w = 60;
cameraInfo1.FOV_l = 40; % deg
cameraInfo1.attitude = [15;0;-20]; % deg
cameraInfo1.X = 10;
cameraInfo1.Y = 10;
cameraInfo1.Z = 5; % meters


cameraInfo2.resolution = [3840;2160];
cameraInfo2.FOV_w = 60;
cameraInfo2.FOV_l = 40;
cameraInfo2.attitude = [15;0;20];
cameraInfo2.X = 60;
cameraInfo2.Y = 10;
cameraInfo2.Z = 5;

%% Base Code testing
Pixel1 = TrajectoryToCamera(Pos, cameraInfo1);
Pixel2 = TrajectoryToCamera(Pos, cameraInfo2);
position = SecondOrder3DLine(Pixel1,cameraInfo1,Pixel2,cameraInfo2);

% Plotting 
figure(1)
t = linspace(0,100,200);
line1 = Frame2Line(Pixel1, cameraInfo1, t);
line2 = Frame2Line(Pixel2, cameraInfo2, t);
plot3(line1(1, :), line1(2, :), line1(3, :), 'r');
hold on
plot3(line2(1, :), line2(2, :), line2(3, :), 'b');
grid on
plot3(Pos(1), Pos(2), Pos(3), 'ro', 'MarkerSize', 8)
plot3(position(1),position(2),position(3), 'go', 'MarkerFaceColor', 'g', 'MarkerSize', 8)
xlabel("x axis")
ylabel("y axis")
zlabel("z axis")
xlim([0 80])
ylim([0 100])
zlim([0 20])

%% Error Analysis

n = 100; % Fidelity
camPos_error = [linspace(-.5, .5, n); linspace(-.5, .5, n); linspace(-.5, .5, n)];
frame_error = [linspace(-2, 2, n); linspace(-2, 2, n); linspace(-2, 2, n)];
camAtt_error = [linspace(-5, 5, n); linspace(-5, 5, n); linspace(-5, 5, n)];

%%  Position Error Analysis
PosErr1 = cameraInfo1;
PosErr2 = cameraInfo2;

Err_Pos_Cam1 = zeros(n, 3);
Err_Pos_Cam2 = zeros(n, 3);
Err_Pos_Both = zeros(n, 3);

for i=1:n
    PosErr1.X = cameraInfo1.X + camPos_error(1, i);
    PosErr1.Y = cameraInfo1.Y + camPos_error(2, i);
    PosErr1.Z = cameraInfo1.Z + camPos_error(3, i);
    PosErr2.X = cameraInfo2.X + camPos_error(1, i);
    PosErr2.Y = cameraInfo2.Y + camPos_error(2, i);
    PosErr2.Z = cameraInfo2.Z + camPos_error(3, i);

    WrongPos1 = SecondOrder3DLine(Pixel1,PosErr1,Pixel2,cameraInfo2);
    WrongPos2 = SecondOrder3DLine(Pixel1,cameraInfo1,Pixel2,PosErr2);
    WrongPosBoth = SecondOrder3DLine(Pixel1,PosErr1,Pixel2,PosErr2);

    Err_Pos_Cam1(i, :) = abs(Pos - WrongPos1');
    Err_Pos_Cam2(i, :) = abs(Pos - WrongPos2');
    Err_Pos_Both(i, :) = abs(Pos - WrongPosBoth');

end

% Plotting
% Just Camera 1 Error

figure(2)
subplot(3, 1, 1)
plot(camPos_error(1, :), Err_Pos_Cam1(:, 1));
xlabel("Error in Camera 1 Position [m]")
ylabel("Error in Estimated X-Position [m]")

subplot(3, 1, 2)
plot(camPos_error(2, :), Err_Pos_Cam1(:, 2));
xlabel("Error in Camera 1 Position [m]")
ylabel("Error in Estimated Y-Position [m]")

subplot(3, 1, 3)
plot(camPos_error(3, :), Err_Pos_Cam1(:, 3));
xlabel("Error in Camera 1 Position [m]")
ylabel("Error in Estimated Z-Position [m]")



%%  Orientation Error Analysis
AttErr1 = cameraInfo1;
AttErr2 = cameraInfo2;

Err_Att_Cam1 = zeros(n, 3);
Err_Att_Cam2 = zeros(n, 3);
Err_Att_Both = zeros(n, 3);

for i=1:n
    AttErr1.attitude = cameraInfo1.attitude + camAtt_error(:, i);
    AttErr2.attitude = cameraInfo2.attitude + camAtt_error(:, i);

    WrongAtt1 = SecondOrder3DLine(Pixel1,AttErr1,Pixel2,cameraInfo2);
    WrongAtt2 = SecondOrder3DLine(Pixel1,cameraInfo1,Pixel2,AttErr2);
    WrongAttBoth = SecondOrder3DLine(Pixel1,AttErr1,Pixel2,AttErr2);

    Err_Att_Cam1(i, :) = abs(Pos - WrongAtt1');
    Err_Att_Cam2(i, :) = abs(Pos - WrongAtt2');
    Err_Att_Both(i, :) = abs(Pos - WrongAttBoth');

end

% Plotting
% Just Camera 1 Error 

figure(3)
subplot(3, 1, 1)
plot(camAtt_error(1, :), Err_Att_Cam1(:, 1));
xlabel("Error in Camera 1 Orientation [deg]")
ylabel("Error in Estimated X-Position [m]")

subplot(3, 1, 2)
plot(camAtt_error(2, :), Err_Att_Cam1(:, 2));
xlabel("Error in Camera 1 Orientation [deg]")
ylabel("Error in Estimated Y-Position [m]")

subplot(3, 1, 3)
plot(camAtt_error(3, :), Err_Att_Cam1(:, 3));
xlabel("Error in Camera 1 Orientation [deg]")
ylabel("Error in Estimated Z-Position [m]")





