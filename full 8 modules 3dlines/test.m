clear; clc; close all;

%% Camera Initialization
n = 20; % Fidelity
z_offset = 15;
Pos = [10*sin(linspace(0, 10, n))', linspace(0, 70, n)', linspace(z_offset, 0, n)'];

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


video = VideoWriter('eight_cameras_test.mp4','MPEG-4');
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
    

    pixel_pos = [Pixel1(i,:);Pixel2(i,:);Pixel3(i,:);Pixel4(i,:);Pixel5(i,:);Pixel6(i,:);Pixel7(i,:);Pixel8(i,:)];

    plotLines(pixel_pos,camInfo,t,8)

    position = ThreeDLines(pixel_pos,camInfo,8);
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

function plotLines(pixel_pos,camInfo,t,n)

cam = fieldnames(camInfo);

for i=1:n

    line = Frame2Line(pixel_pos(i, :),camInfo.(cam{i}),t);
    plot3(line(1, :), line(2, :), line(3, :), 'k--');
    hold on

end
end