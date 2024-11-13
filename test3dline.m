clear; clc;


Pos = [10, 50, 10];


cameraInfo1.resolution = [3840;2160]; % pixels
cameraInfo1.FOV_w = 60;
cameraInfo1.FOV_l = 40; % deg
cameraInfo1.attitude = [25;0;-50]; % deg
cameraInfo1.X = 10;
cameraInfo1.Y = 10;
cameraInfo1.Z = 5; % meters


cameraInfo2.resolution = [3840;2160];
cameraInfo2.FOV_w = 60;
cameraInfo2.FOV_l = 40;
cameraInfo2.attitude = [25;0;-130];
cameraInfo2.X = 60;
cameraInfo2.Y = 30;
cameraInfo2.Z = 5;

Pixel1 = TrajectoryToCamera(Pos, cameraInfo1);
Pixel2 = TrajectoryToCamera(Pos, cameraInfo2);

[eq1,dBar1] = FirstOrder3Dlines(Pixel1, cameraInfo1);

[eq2,dBar2] = FirstOrder3Dlines(Pixel2, cameraInfo2);

position = SecondOrder3DLines(Pixel1,cameraInfo1,Pixel2,cameraInfo2);

t = linspace(0,200,2000);

plot3(eq1.X(t),eq1.Y(t),eq1.Z(t))
hold on
grid on
plot3(Pos(1), Pos(2), Pos(3), 'ro', 'MarkerSize', 8)
plot3(eq2.X(t),eq2.Y(t),eq2.Z(t))
plot3(position(1),position(2),position(3), 'go', 'MarkerFaceColor', 'g', 'MarkerSize', 8)
xlabel("x axis")
ylabel("y axis")
zlabel("z axis")
% xlim([5 20])
% ylim([20 60])
% zlim([5 20])