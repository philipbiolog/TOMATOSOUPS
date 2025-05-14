function R321 = rotation321(attitude)
    % Input: attitude = 3x1 matrix of Euler angles (phi, theta, psi) in
    % degrees

    % Output: rotation matrix from inertial to "attitude" frame such that
    % R321 * vec_inert = new_vec


    phi = deg2rad(attitude(1));
    theta = deg2rad(attitude(2));
    psi = deg2rad(attitude(3));
    
    R1 = [1, 0, 0;
          0, cos(phi), sin(phi);
          0, -sin(phi), cos(phi)];
    
    R2 = [cos(theta), 0, -sin(theta);
          0, 1, 0;
          sin(theta), 0, cos(theta)];
    
    R3 = [cos(psi), sin(psi), 0;
          -sin(psi), cos(psi), 0;
          0, 0, 1];
    
    R321 = R1 * R2 * R3;
end