function [eq,dBar] = FirstOrder3Dlines(pixelPosition,cameraInfo)

% INPUTS: pixelPosition are the x,y values of where the centroid of the
%   glider is in the image at that point in time. This value will be received
%   from Aadi's tracking code
%   The camera info is a struct that give the position of the camera, the
%   rotation of the camera, the FOV, and resolution
%
% OUTPUTS: eq is 3D equations that represent the line that the glider
%   is on in relation to the respective camera

%camera 1 calculations
center = (cameraInfo.resolution / 2);

xn = pixelPosition(1) - center(1);
zn = pixelPosition(2) - center(2);

DoX = tan((xn/cameraInfo.resolution(1)) * deg2rad(cameraInfo.FOV_w));
DoZ = tan((zn/cameraInfo.resolution(2)) * deg2rad(cameraInfo.FOV_l));

R321 = RotationMatrix321(deg2rad(cameraInfo.attitude));

dBar = R321 * [DoX;1;DoZ];

eq.X = @(t) dBar(1) * t + cameraInfo.X;
eq.Y = @(t) dBar(2) * t + cameraInfo.Y;
eq.Z = @(t) dBar(3) * t + cameraInfo.Z;

end

