function [eq,dBar] = FirstOrder3Dlines(pixelPosition,cameraInfo)

% INPUTS: pixelPosition are the x,y values of where the centroid of the
%   glider is in the image at that point in time. This value will be received
%   from Aadi's tracking code
%   The camera info is a struct that give the position of the camera, the
%   rotation of the camera, the FOV, and resolution
%
% OUTPUTS: eq is 3D equations that represent the line that the glider
%   is on in relation to the respective camera

center = (cameraInfo.resolution / 2);

xn = pixelPosition(1);% - center(1);
zn = pixelPosition(2);% - center(2);

DoX = tan((xn/cameraInfo.resolution(1)) * cameraInfo.FOV(1));
DoZ = tan((zn/cameraInfo.resolution(2)) * cameraInfo.FOV(2));

R321 = RotationMatrix321(cameraInfo.attitude);

lt = @(t) [DoX*t;t;DoZ*t];

dBar = R321 * [DoX;1;DoZ];

eq = R321 * lt(linspace(0,50,100));% + cameraInfo.offset;



    function R321 = RotationMatrix321(attitude)
    % INPUTS: attitude = 3x1 matrix of the angles relative to the inertial
    % frame that an object is at. In 3728 notation of euler angles with phi, theta, and psi 
    %  
    % OUTPUTS: R321 = the rotation matrix calculated from the 321 Euler angles
    %
    % METHODOLOGY : take the attitude value from the data and create the
    % individual rotation matrices. Multiply those matrices in the correct
    % order too achieve the full rotation matrix.
    
    %creating each angle to have their own variable for ease of use
    phi = attitude(1);
    theta = attitude(2);
    psi = attitude(3);
    
    
    R3 = [1,0,0;
          0,cos(phi),sin(phi);
          0,-sin(phi),cos(phi)];
    
    R2 = [cos(theta),0,-sin(theta);
          0,1,0;
          sin(theta),0,cos(theta)];
    
    R1 = [cos(psi),sin(psi),0;
          -sin(psi),cos(psi),0;
          0,0,1];
    
    R321 = R1 * R2 * R3;
      
    end

end

