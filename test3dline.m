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
Pixel1_Visible = Pixel1(3);
Pixel1 = Pixel1(1:2);
Pixel2 = TrajectoryToCamera(Pos, cameraInfo2);
Pixel2_Visible = Pixel2(3);
Pixel2 = Pixel2(1:2);
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
hold off

%% Error Analysis

n = 100; % Fidelity
camPos_error = linspace(-.5, .5, n);
frame_error = [linspace(-2, 2, n); linspace(-2, 2, n)];
camAtt_error = [linspace(-5, 5, n); linspace(-5, 5, n); linspace(-5, 5, n)];

%%  Position Error Analysis
figNum = 2;
figNum = positionErrorAnalysis(cameraInfo1, cameraInfo2, camPos_error, Pixel1, Pixel2, Pos, n, figNum);


%%  Orientation Error Analysis

figNum = attitudeErrorAnalysis(cameraInfo1, cameraInfo2, camAtt_error, Pixel1, Pixel2, Pos, n, figNum);


%% Frame Error Analysis

figNum = frameErrorAnalysis(cameraInfo1, cameraInfo2, frame_error, Pixel1, Pixel2, Pos, n, figNum);



