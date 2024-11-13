function position = SecondOrder3DLines(pixelPosition1,cameraInfo1,pixelPosition2,cameraInfo2)

% INPUTS: pixelPosition are the x,y values of where the centroid of the
%   glider is in the image at that point in time. This value will be received
%   from Aadi's tracking code
%   The camera info is a struct that give the position of the camera, the
%   rotation of the camera, the FOV, and resolution
%
% OUTPUTS: eq is 3D equations that represent the line that the glider
%   is on in relation to the respective camera

% Camera 1 calculations
center1 = (cameraInfo1.resolution / 2);
xn1 = pixelPosition1(1) - center1(1);
zn1 = pixelPosition1(2) - center1(2);

DoX1 = tan((xn1 / cameraInfo1.resolution(1)) * deg2rad(cameraInfo1.FOV_w));
DoZ1 = tan((zn1 / cameraInfo1.resolution(2)) * deg2rad(cameraInfo1.FOV_l));

R321_cam1 = RotationMatrix321(deg2rad(cameraInfo1.attitude));
dBar1 = R321_cam1 * [DoX1; 1; DoZ1];

eq1.X = @(t1) dBar1(1) * t1 + cameraInfo1.X;
eq1.Y = @(t1) dBar1(2) * t1 + cameraInfo1.Y;
eq1.Z = @(t1) dBar1(3) * t1 + cameraInfo1.Z;

% Camera 2 calculations
center2 = (cameraInfo2.resolution / 2);
xn2 = pixelPosition2(1) - center2(1);
zn2 = pixelPosition2(2) - center2(2);

DoX2 = tan((xn2 / cameraInfo2.resolution(1)) * deg2rad(cameraInfo2.FOV_w));
DoZ2 = tan((zn2 / cameraInfo2.resolution(2)) * deg2rad(cameraInfo2.FOV_l));

R321_cam2 = RotationMatrix321(deg2rad(cameraInfo2.attitude));
dBar2 = R321_cam2 * [DoX2; 1; DoZ2];

eq2.X = @(t2) dBar2(1) * t2 + cameraInfo2.X;
eq2.Y = @(t2) dBar2(2) * t2 + cameraInfo2.Y;
eq2.Z = @(t2) dBar2(3) * t2 + cameraInfo2.Z;

% Define the distance vector function (r)
r = @(t) [
    eq1.X(t(1)) - eq2.X(t(2));   % X difference
    eq1.Y(t(1)) - eq2.Y(t(2));   % Y difference
    eq1.Z(t(1)) - eq2.Z(t(2))    % Z difference
];

% Define the dot product equations (perpendicularity conditions)
dot1 = @(t) dot(r(t), dBar1); % r(t) . dBar1 = 0
dot2 = @(t) dot(r(t), dBar2); % r(t) . dBar2 = 0

% System of equations to solve: dot1 = 0 and dot2 = 0
tot = @(t) [
    dot1(t); % dot1 = 0
    dot2(t); % dot2 = 0
];

% Solving using fsolve
initial_guess = [1, 1];  % Guess values for t1 and t2
options = optimset('Display', 'off');  % Turn off display for fsolve
[t1_t2, ~] = fsolve(tot, initial_guess, options);

% Extract the values of t1 and t2 from the result
t1 = t1_t2(1);
t2 = t1_t2(2);

% Calculate the 3D positions where the lines come closest
P1 = [eq1.X(t1); eq1.Y(t1); eq1.Z(t1)];
P2 = [eq2.X(t2); eq2.Y(t2); eq2.Z(t2)];

% The final position is the midpoint of the closest points from both lines
position = (P1 + P2) / 2;

% RotationMatrix321 function

end
