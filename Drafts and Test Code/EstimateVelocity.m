function [raw_data,velocity] = EstimateVelocity(position,time)

raw_vx = diff(position(:,1)) / diff(time);
raw_vy = diff(position(:,2)) / diff(time);
raw_vz = diff(position(:,3)) / diff(time);

raw_data = [raw_vx,raw_vy,raw_vz];

px = polyfit(time(1:end-1),raw_data(:,1),5);
py = polyfit(time(1:end-1),raw_data(:,2),5);
pz = polyfit(time(1:end-1),raw_data(:,3),5);

vx = polyval(px,time);
vx = [0;vx];
vy = polyval(py,time);
vy = [0;vy];
vz = polyval(pz,time);
vz = [0;vz];

velocity = [vx,vy,vz];

figure()
title('Velocity v Time for All Three Axes')
subplot(3,1,1)
plot(time,raw_data(:,1),'ro')
hold on
plot(time,vx,'b-')
xlabel('Time of flight (s)')
ylabel('X-axis Velocity (m/s)')

subplot(3,1,2)
plot(time,raw_data(:,2),'ro')
hold on
plot(time,vy,'b-')
xlabel('Time of flight (s)')
ylabel('Y-axis Velocity (m/s)')

subplot(3,1,2)
plot(time,raw_data(:,3),'ro')
hold on
plot(time,vz,'b-')
xlabel('Time of flight (s)')
ylabel('Z-axis Velocity (m/s)')


end