clear all; clc; close all;

cam_info2 = camInfoD1();

cam_data = camData();

time = (0:(1/24):(232/24))';

[position,velocity] = estimation(cam_data.test1,time,2);

figure()
plot3(position(:,1),position(:,2),position(:,3))
hold on
plot3(0,0,0,'bo','MarkerFaceColor','k')
plot3(cam_info2.cam2.X,cam_info2.cam2.Y,cam_info2.cam2.Z,'go','MarkerFaceColor','k')
plot3(cam_info2.cam7.X,cam_info2.cam7.Y,cam_info2.cam7.Z,'ro','MarkerFaceColor','k')
plot3(cam_info2.cam8.X,cam_info2.cam8.Y,cam_info2.cam8.Z,'mo','MarkerFaceColor','k')
xlabel('X axis (m)')
ylabel('Y axis (m)')
zlabel('Z axis (m)')

figure()
subplot(3,1,1)
plot(time,velocity(:,1))
xlabel('time (s)')
ylabel('Vx (m/s)')
title('3 Axis Velocity v Time')

subplot(3,1,2)
plot(time,velocity(:,2))
xlabel('time (s)')
ylabel('Vy (m/s)')

subplot(3,1,3)
plot(time,velocity(:,3))
xlabel('time (s)')
ylabel('Vz (m/s)')



function [position,velocity] = estimation(PixPos,time,n)
    
    camInfo = camInfoD1();
    
    for j=1:length(time)
    
        position(j,:) = ThreeDLines(PixPos,camInfo,n,j);
    
    end
    
    [velocity,~] = EstimateVelocity(position,time);

end


function cam = camData()

cam.test1.cam1.x = cell2mat(struct2cell(load('C1.mat','interpX')));
cam.test1.cam1.x = cam.test1.cam1.x(112:344);
cam.test1.cam1.z = cell2mat(struct2cell(load('C1.mat','interpY')));
cam.test1.cam1.z = cam.test1.cam1.z(112:344);

cam.test1.cam2.x = cell2mat(struct2cell(load('C2.mat','interpX')));
cam.test1.cam2.x = cam.test1.cam2.x(1:233);
cam.test1.cam2.z = cell2mat(struct2cell(load('C2.mat','interpY')));
cam.test1.cam2.z = cam.test1.cam2.z(1:233);

cam.test1.cam7.x = cell2mat(struct2cell(load('C7.mat','interpX')));
cam.test1.cam7.x = cam.test1.cam7.x(702:934);
cam.test1.cam7.z = cell2mat(struct2cell(load('C7.mat','interpY')));
cam.test1.cam7.z = cam.test1.cam7.z(702:934);

cam.test1.cam8.x = cell2mat(struct2cell(load('C8.mat','interpX')));
cam.test1.cam8.x = cam.test1.cam8.x(751:983);
cam.test1.cam8.z = cell2mat(struct2cell(load('C8.mat','interpY')));
cam.test1.cam8.z = cam.test1.cam8.z(751:983);

end