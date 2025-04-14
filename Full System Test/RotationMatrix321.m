function R321 = RotationMatrix321(attitude)
    % Input: attitude = 3x1 matrix of Euler angles (phi, theta, psi)
    phi = attitude(1);
    theta = attitude(2);
    psi = attitude(3);
    
    R3 = [1, 0, 0;
          0, cos(phi), sin(phi);
          0, -sin(phi), cos(phi)];
    
    R2 = [cos(theta), 0, -sin(theta);
          0, 1, 0;
          sin(theta), 0, cos(theta)];
    
    R1 = [cos(psi), sin(psi), 0;
          -sin(psi), cos(psi), 0;
          0, 0, 1];
    
    R321 = R1 * R2 * R3;
end