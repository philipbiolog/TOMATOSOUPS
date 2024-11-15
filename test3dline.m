clear; clc;


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

Pixel1 = TrajectoryToCamera(Pos, cameraInfo1);
Pixel2 = TrajectoryToCamera(Pos, cameraInfo2);



position = SecondOrder3DLine(Pixel1,cameraInfo1,Pixel2,cameraInfo2);

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