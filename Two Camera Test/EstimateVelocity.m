function [raw_data,velocity] = EstimateVelocity(position,time)

raw_vx = [0;diff(position(:,1)) ./ diff(time)];
raw_vy = [0;diff(position(:,2)) ./ diff(time)];
raw_vz = [0;diff(position(:,3)) ./ diff(time)];

raw_data = [raw_vx,raw_vy,raw_vz];

px = polyfit(time,raw_data(:,1),3);
py = polyfit(time,raw_data(:,2),3);
pz = polyfit(time,raw_data(:,3),3);

vx = polyval(px,time);
vy = polyval(py,time);
vz = polyval(pz,time);

velocity = [vx,vy,vz];

% figure()
% title('Velocity v Time for All Three Axes')
% subplot(3,1,1)
% plot(time,raw_data(:,1),'ro')
% hold on
% plot(time,vx,'b-')
% xlabel('Time of flight (s)')
% ylabel('X-axis Velocity (m/s)')
% 
% subplot(3,1,2)
% plot(time,raw_data(:,2),'ro')
% hold on
% plot(time,vy,'b-')
% xlabel('Time of flight (s)')
% ylabel('Y-axis Velocity (m/s)')
% 
% subplot(3,1,3)
% plot(time,raw_data(:,3),'ro')
% hold on
% plot(time,vz,'b-')
% xlabel('Time of flight (s)')
% ylabel('Z-axis Velocity (m/s)')


end