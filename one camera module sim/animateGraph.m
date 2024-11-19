

clear; clc; close all;

%% Camera Initialization
n = 20; % Fidelity
z_offset = 15;
Pos = [10*sin(linspace(0, 10, n))', linspace(0, 70, n)', linspace(z_offset, 0, n)'];


cameraInfo1.resolution = [7680;4320]; % pixels
cameraInfo1.FOV_w = 157;
cameraInfo1.FOV_l = 80; % deg
cameraInfo1.attitude = [15;0;45]; % deg
cameraInfo1.X = 50;
cameraInfo1.Y = 8;
cameraInfo1.Z = 0; % meters


cameraInfo2.resolution = [7680;4320];
cameraInfo2.FOV_w = 157;
cameraInfo2.FOV_l = 80;
cameraInfo2.attitude = [15;0;45];
cameraInfo2.X = 50;
cameraInfo2.Y = 5;
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
az = 120;
el = 10;
for i=1:n
    plot3(Pos(i, 1), Pos(i, 2), Pos(i, 3), 'ro', 'MarkerSize', 8)
    view(az, el)
    xlabel("x axis (m)")
    ylabel("y axis (m)")
    zlabel("z axis (m)")
    xlim([-50 50])
    ylim([0 100])
    zlim([0 20])
    view(az, el)
    title("Position Tracking of a known path")
    frame1 = getframe(gcf);
    for s=1:10
        writeVideo(video,frame1);
    end
    line1 = Frame2Line(Pixel1(i, :), cameraInfo1, t);
    line2 = Frame2Line(Pixel2(i, :), cameraInfo2, t);
    position = SecondOrder3DLine(Pixel1(i, :),cameraInfo1,Pixel2(i, :),cameraInfo2);
    plot3(line1(1, :), line1(2, :), line1(3, :), 'b');
    hold on
    plot3(line2(1, :), line2(2, :), line2(3, :), 'k');
    plot3(position(1),position(2),position(3), 'bo', 'MarkerFaceColor', 'g', 'MarkerSize', 8)
    xlim([-50 50])
    ylim([0 100])
    zlim([0 20])
    view(az, el)
    err = Pos(i, :)-position';
    error(i) = norm(err);

    frame2 = getframe(gcf);
    for s=1:10
        writeVideo(video,frame2);
    end
    
    

end

close(video)