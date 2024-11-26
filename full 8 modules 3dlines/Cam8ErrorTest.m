clc; clear; close all;
%% Camera Initialization
tic
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

%% Setting Pixel Frames
Pixel1 = TrajectoryToCamera(Pos, cameraInfo1);
Pixel2 = TrajectoryToCamera(Pos, cameraInfo2);
Pixel3 = TrajectoryToCamera(Pos, cameraInfo3);
Pixel4 = TrajectoryToCamera(Pos, cameraInfo4);
Pixel5 = TrajectoryToCamera(Pos, cameraInfo5);
Pixel6 = TrajectoryToCamera(Pos, cameraInfo6);
Pixel7 = TrajectoryToCamera(Pos, cameraInfo7);
Pixel8 = TrajectoryToCamera(Pos, cameraInfo8);
pixel_pos = [Pixel1;Pixel2;Pixel3;Pixel4;Pixel5;Pixel6;Pixel7;Pixel8];

%% Confidence Interval and Sampling 
CI_Size = 300;
fidelity = 500;

mean_att1 = zeros(CI_Size, 3);
perc_att1 = zeros(CI_Size, 1);
mean_att2 = zeros(CI_Size, 3);
perc_att2 = zeros(CI_Size, 1);

mean_pos1 = zeros(CI_Size, 3);
perc_pos1 = zeros(CI_Size, 1);
mean_pos2 = zeros(CI_Size, 3);
perc_pos2 = zeros(CI_Size, 1);

mean_frame1 = zeros(CI_Size, 3);
perc_frame1 = zeros(CI_Size, 1);
mean_frame2 = zeros(CI_Size, 3);
perc_frame2 = zeros(CI_Size, 1);

mean_all1 = zeros(CI_Size, 3);
perc_all1 = zeros(CI_Size, 1);
mean_all2 = zeros(CI_Size, 3);
perc_all2 = zeros(CI_Size, 1);

[mean_att1(1, :), perc_att1(1)] = att8Cam(camInfo, Pos, pixel_pos, fidelity, [-1, 1], true);
[mean_att2(1, :), perc_att2(1)] = att8Cam(camInfo, Pos, pixel_pos, fidelity, [-.5, .5], false);
[mean_pos1(1, :), perc_pos1(1)] = pos8Cam(camInfo, Pos, pixel_pos, fidelity, [-1, 1], true);
[mean_pos2(1, :), perc_pos2(1)] = pos8Cam(camInfo, Pos, pixel_pos, fidelity, [-.5, .5], false);
[mean_frame1(1, :), perc_frame1(1)] = frame8Cam(camInfo, Pos, pixel_pos, fidelity, [-1, 1], true);
[mean_frame2(1, :), perc_frame2(1)] = frame8Cam(camInfo, Pos, pixel_pos, fidelity, [-.5, .5], false);
[mean_all1(1, :), perc_all1(1)] = all8Cam(camInfo, Pos, pixel_pos, fidelity, [-1, 1], true);
[mean_all2(1, :), perc_all2(1)] = all8Cam(camInfo, Pos, pixel_pos, fidelity, [-.5, .5], false);

for i=2:CI_Size
    [mean_att1(i, :), perc_att1(i)] = att8Cam(camInfo, Pos, pixel_pos, fidelity, [-1, 1], false);
    [mean_att2(i, :), perc_att2(i)] = att8Cam(camInfo, Pos, pixel_pos, fidelity, [-.5, .5], false);
    [mean_pos1(i, :), perc_pos1(i)] = pos8Cam(camInfo, Pos, pixel_pos, fidelity, [-1, 1], false);
    [mean_pos2(i, :), perc_pos2(i)] = pos8Cam(camInfo, Pos, pixel_pos, fidelity, [-.5, .5], false);
    [mean_frame1(i, :), perc_frame1(i)] = frame8Cam(camInfo, Pos, pixel_pos, fidelity, [-1, 1], false);
    [mean_frame2(i, :), perc_frame2(i)] = frame8Cam(camInfo, Pos, pixel_pos, fidelity, [-.5, .5], false);
    [mean_all1(i, :), perc_all1(i)] = all8Cam(camInfo, Pos, pixel_pos, fidelity, [-1, 1], false);
    [mean_all2(i, :), perc_all2(i)] = all8Cam(camInfo, Pos, pixel_pos, fidelity, [-.5, .5], false);
    
end

avg_perc_tol(1) = mean(perc_att1);
avg_perc_tol(2) = mean(perc_att2);
avg_perc_tol(3) = mean(perc_pos1);
avg_perc_tol(4) = mean(perc_pos2);
avg_perc_tol(5) = mean(perc_frame1);
avg_perc_tol(6) = mean(perc_frame2);
avg_perc_tol(7) = mean(perc_all1);
avg_perc_tol(8) = mean(perc_all2);

ConfInt99(1, 1:2) = [avg_perc_tol(1) - 3*std(perc_att1), avg_perc_tol(1) + 3*std(perc_att1)];
ConfInt99(2, 1:2) = [avg_perc_tol(2) - 3*std(perc_att2), avg_perc_tol(2) + 3*std(perc_att2)];
ConfInt99(3, 1:2) = [avg_perc_tol(3) - 3*std(perc_pos1), avg_perc_tol(3) + 3*std(perc_pos1)];
ConfInt99(4, 1:2) = [avg_perc_tol(4) - 3*std(perc_pos2), avg_perc_tol(4) + 3*std(perc_pos2)];
ConfInt99(5, 1:2) = [avg_perc_tol(5) - 3*std(perc_frame1), avg_perc_tol(5) + 3*std(perc_frame1)];
ConfInt99(6, 1:2) = [avg_perc_tol(6) - 3*std(perc_frame2), avg_perc_tol(6) + 3*std(perc_frame2)];
ConfInt99(7, 1:2) = [avg_perc_tol(7) - 3*std(perc_all1), avg_perc_tol(7) + 3*std(perc_all1)];
ConfInt99(8, 1:2) = [avg_perc_tol(8) - 3*std(perc_all2), avg_perc_tol(8) + 3*std(perc_all2)];

ConfInt95(1, 1:2) = [avg_perc_tol(1) - 2*std(perc_att1), avg_perc_tol(1) + 2*std(perc_att1)];
ConfInt95(2, 1:2) = [avg_perc_tol(2) - 2*std(perc_att2), avg_perc_tol(2) + 2*std(perc_att2)];
ConfInt95(3, 1:2) = [avg_perc_tol(3) - 2*std(perc_pos1), avg_perc_tol(3) + 2*std(perc_pos1)];
ConfInt95(4, 1:2) = [avg_perc_tol(4) - 2*std(perc_pos2), avg_perc_tol(4) + 2*std(perc_pos2)];
ConfInt95(5, 1:2) = [avg_perc_tol(5) - 2*std(perc_frame1), avg_perc_tol(5) + 2*std(perc_frame1)];
ConfInt95(6, 1:2) = [avg_perc_tol(6) - 2*std(perc_frame2), avg_perc_tol(6) + 2*std(perc_frame2)];
ConfInt95(7, 1:2) = [avg_perc_tol(7) - 2*std(perc_all1), avg_perc_tol(7) + 2*std(perc_all1)];
ConfInt95(8, 1:2) = [avg_perc_tol(8) - 2*std(perc_all2), avg_perc_tol(8) + 2*std(perc_all2)];


avg_perc_tol'

ConfInt99

ConfInt95

toc

%% Plotting 

figure
histogram(perc_att1, 'NumBins', 20)
hold on
xlabel("Percentage of Data within Error Tolerance")
title("Histrogram of Attitude Error with Tolerance +/- 1 m")
xlim([min(perc_att1)-.05, 1])
plot([ConfInt99(1, 1), ConfInt99(1, 2)], [0 0], 'r', 'LineWidth', 2)
plot([ConfInt95(1, 1), ConfInt95(1, 2)], [.01 .01], 'g', 'LineWidth', 2)
hold off

figure
histogram(perc_att2, 'NumBins', 20)
hold on
xlabel("Percentage of Data within Error Tolerance")
title("Histrogram of Attitude Error with Tolerance +/- .5 m")
xlim([min(perc_att2)-.05, max(perc_att2)+.05])
plot([ConfInt99(2, 1), ConfInt99(2, 2)], [0 0], 'r', 'LineWidth', 2)
plot([ConfInt95(2, 1), ConfInt95(2, 2)], [.01 .01], 'g', 'LineWidth', 2)
hold off

figure
histogram(perc_pos1, 'NumBins', 20)
hold on
xlabel("Percentage of Data within Error Tolerance")
title("Histrogram of Position Error with Tolerance +/- 1 m")
xlim([min(perc_pos1)-.05, 1])
plot([ConfInt99(3, 1), ConfInt99(3, 2)], [0 0], 'r', 'LineWidth', 2)
plot([ConfInt95(3, 1), ConfInt95(3, 2)], [.01 .01], 'g', 'LineWidth', 2)
hold off

figure
histogram(perc_pos2, 'NumBins', 20)
hold on
xlabel("Percentage of Data within Error Tolerance")
title("Histrogram of Position Error with Tolerance +/- .5 m")
xlim([min(perc_pos2)-.05, max(perc_pos2)+.05])
plot([ConfInt99(4, 1), ConfInt99(4, 2)], [0 0], 'r', 'LineWidth', 2)
plot([ConfInt95(4, 1), ConfInt95(4, 2)], [.01 .01], 'g', 'LineWidth', 2)
hold off

figure
histogram(perc_frame1, 'NumBins', 20)
hold on
xlabel("Percentage of Data within Error Tolerance")
title("Histrogram of Frame Error with Tolerance +/- 1 m")
plot([ConfInt99(5, 1), ConfInt99(5, 2)], [0 0], 'r', 'LineWidth', 2)
plot([ConfInt95(5, 1), ConfInt95(5, 2)], [.01 .01], 'g', 'LineWidth', 2)
hold off

figure
histogram(perc_frame2, 'NumBins', 20)  
hold on
xlabel("Percentage of Data within Error Tolerance")
title("Histrogram of Frame Error with Tolerance +/- .5 m")
plot([ConfInt99(6, 1), ConfInt99(6, 2)], [0 0], 'r', 'LineWidth', 2)
plot([ConfInt95(6, 1), ConfInt95(6, 2)], [.01 .01], 'g', 'LineWidth', 2)
hold off

figure
histogram(perc_all1, 'NumBins', 20)
hold on
xlabel("Percentage of Data within Error Tolerance")
title("Histrogram of Total Error with Tolerance +/- 1 m")
xlim([min(perc_all1)-.05, 1])
plot([ConfInt99(7, 1), ConfInt99(7, 2)], [0 0], 'r', 'LineWidth', 2)
plot([ConfInt95(7, 1), ConfInt95(7, 2)], [.01 .01], 'g', 'LineWidth', 2)
hold off

figure
histogram(perc_all2, 'NumBins', 20)
hold on
xlabel("Percentage of Data within Error Tolerance")
title("Histrogram of Total Error with Tolerance +/- .5 m")
xlim([min(perc_all2)-.05, max(perc_all2)+.05])
plot([ConfInt99(8, 1), ConfInt99(8, 2)], [0 0], 'r', 'LineWidth', 2)
plot([ConfInt95(8, 1), ConfInt95(8, 2)], [.01 .01], 'g', 'LineWidth', 2)
hold off

