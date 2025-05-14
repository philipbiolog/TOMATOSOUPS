function pos = SecondOrder3DLine(pos1, Cam1, pos2, Cam2)


%% Camera 1 Values

center1 = (Cam1.resolution / 2); % Center of the frame / Camera frame origin
x1 = pos1(1) - center1(1); % pos of the object relative to new camera frame origin ^ 
z1 = center1(2) - pos1(2);

p1 = x1 / Cam1.resolution(1) * deg2rad(Cam1.FOV_w); % inside tan -> x_n / res * FOV = ang_size
q1 = z1 / Cam1.resolution(2) * deg2rad(Cam1.FOV_l);

x_bar1 = [Cam1.X Cam1.Y Cam1.Z]'; % Vertical vector of offset

d1 = [tan(p1), 1, tan(q1)]'; % Vertical vector of direction (no t value)


%% Camera 2 Values

center2 = (Cam2.resolution / 2);
x2 = pos2(1) - center2(1);
z2 = center2(2) - pos2(2);

p2 = x2 / Cam2.resolution(1) * deg2rad(Cam2.FOV_w);
q2 = z2 / Cam2.resolution(2) * deg2rad(Cam2.FOV_l);

x_bar2 = [Cam2.X Cam2.Y Cam2.Z]';

d2 = [tan(p2), 1, tan(q2)]';

%% Camera to Global Frame
R1 = RotationMatrix321(deg2rad(Cam1.attitude));
R2 = RotationMatrix321(deg2rad(Cam2.attitude));

d1 = R1 \ d1;
d2 = R2 \ d2;

%% Solution

x_bar = x_bar1 - x_bar2;
f1 = @(t1, t2) (d1(1)*(t1*d1(1)-t2*d2(1)+x_bar(1)) + d1(2)*(t1*d1(2)-t2*d2(2)+x_bar(2)) + d1(3)*(t1*d1(3)-t2*d2(3)+x_bar(3)) );
f2 = @(t1, t2) (d2(1)*(t1*d1(1)-t2*d2(1)+x_bar(1)) + d2(2)*(t1*d1(2)-t2*d2(2)+x_bar(2)) + d2(3)*(t1*d1(3)-t2*d2(3)+x_bar(3)) );
f = @(t) [f1(t(1), t(2)); f2(t(1), t(2))];

options = optimset('Display', 'off');  % Turn off display for fsolve
[s, val] = fsolve(f, [10 10], options);
P1 = s(1)*d1 + x_bar1;
P2 = s(2)*d2 + x_bar2;
pos = (P1+P2)/2;

end