clear; clc; close all;

%% Camera Initialization
x_start = 20;
x_end = 60;
y_start = 0;
y_end = 80;
z_offset = 1;
Pos = [linspace(x_start, x_end, 20)', linspace(y_start, y_end, 20)', (sin(linspace(0, 10, 20)) + z_offset*ones(size(1, 20)))'];


cameraInfo1.resolution = [3840;2160]; % pixels
cameraInfo1.FOV_w = 60;
cameraInfo1.FOV_l = 40; % deg
cameraInfo1.attitude = [15;0;-45]; % deg
cameraInfo1.X = 0;
cameraInfo1.Y = -5;
cameraInfo1.Z = 0; % meters


cameraInfo2.resolution = [3840;2160];
cameraInfo2.FOV_w = 60;
cameraInfo2.FOV_l = 40;
cameraInfo2.attitude = [15;0;45];
cameraInfo2.X = 80;
cameraInfo2.Y = -5;
cameraInfo2.Z = 0;

%% Base Code testing
Pixel1 = TrajectoryToCamera(Pos, cameraInfo1);
Pixel1_Visible = Pixel1(:, 3);
Pixel1 = Pixel1(:, 1:2);
Pixel2 = TrajectoryToCamera(Pos, cameraInfo2);
Pixel2_Visible = Pixel2(:, 3);
Pixel2 = Pixel2(:, 1:2);

% Plotting 
video = VideoWriter('Initial_positionvtime.mp4','MPEG-4');
open(video);


figure(1)
t = linspace(0,200);
error = zeros(1, 20);
for i=1:20
    plot3(Pos(i, 1), Pos(i, 2), Pos(i, 3), 'ro', 'MarkerSize', 8)
    drawnow
    pause(.2)
    frame1 = getframe(gcf);
    writeVideo(video,frame1);
    line1 = Frame2Line(Pixel1(i, :), cameraInfo1, t);
    line2 = Frame2Line(Pixel2(i, :), cameraInfo2, t);
    position = SecondOrder3DLine(Pixel1(i, :),cameraInfo1,Pixel2(i, :),cameraInfo2);
    plot3(line1(1, :), line1(2, :), line1(3, :), 'r');
    hold on
    plot3(line2(1, :), line2(2, :), line2(3, :), 'b');
    plot3(position(1),position(2),position(3), 'go', 'MarkerFaceColor', 'g', 'MarkerSize', 8)
    xlabel("x axis")
    ylabel("y axis")
    zlabel("z axis")
    xlim([0 80])
    ylim([0 100])
    zlim([0 20])
    drawnow
    pause(.2)
    error(i) = norm(Pos(i, :)-position);

    frame2 = getframe(gcf);
    writeVideo(video,frame2);

end

close(video)