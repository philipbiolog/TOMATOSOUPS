clear
clc
close all

trajectory = [linspace(10,50,100)', linspace(0,10,100)', linspace(5,0,100)'];

camera1.x_position = 0;
camera1.y_position = 0;
camera1.z_position = 0;

camera1.FOV_x = 60;
camera1.FOV_y = 40;

camera1.pix_x = 2000;
camera1.pix_y = 1000;

% CCW '+'
camera1.phi = 0;
camera1.theta = 0;
camera1.psi = 0; 

camera1.attitude = [camera1.phi camera1.theta camera1.psi];
camera1.resolution = [ camera1.pix_x camera1.pix_y];
camera1.FOV = [camera1.FOV_x camera1.FOV_y];
camera1.offset = [camera1.x_position, camera1.y_position, camera1.z_position];

position_c_1 = TrajectoryToCamera(trajectory,camera1);

figure(1)
plot3(trajectory(:,1),trajectory(:,2),trajectory(:,3));
grid on
xlabel('X');
ylabel('Y');
zlabel('Z');

figure(2)

plot3(position_c_1(:,1),position_c_1(:,2),1:100)
xlabel('X');
ylabel('Y');
grid on

[rows, ~] = size(position_c_1);

for i = 1:60
[eq,dBar] = FirstOrder3Dlines(position_c_1(i,:),camera1);
end
eq = eq';
figure(1)
hold on
plot3(eq(:,1), eq(:,2), eq(:,3))
plot3(eq(:,1), eq(:,3), eq(:,2))
plot3(eq(:,2), eq(:,1), eq(:,3))
plot3(eq(:,2), eq(:,3), eq(:,1))
plot3(eq(:,3), eq(:,1), eq(:,2))
plot3(eq(:,3), eq(:,2), eq(:,1))

legend('1','2', '3', '4', '5', '6','7','8')
plot3(trajectory(i,1),trajectory(i,2),trajectory(i,3),'o',LineWidth=4)

