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

