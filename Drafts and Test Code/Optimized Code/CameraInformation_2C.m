function camInfo = CameraInformation_2C(x)

    R = rotation321([90, 0, 0]);    % Rotation from calibration frame 
                                    % to our coordinate frame

    camInfo.res = [3840;2880];       
    camInfo.FOV_w = 107.11;
    camInfo.FOV_l = 74.22; % deg

    switch x 
        case 1
            % Cam 1
            camInfo.pos = [0;0;0];      % Meters
            camInfo.R = eye(3);


  
        case 2
            % Cam 2  
            camInfo.pos = [-2.9972; 5.2344; 0]; % Meters

            att = [.5851, 89.789, 0];

            camInfo.R = rotation321(att); % Rotation from cam 1 to cam 2

            camInfo.R = R*camInfo.R'*R';   % Rotation from cam 2 to cam 1
        otherwise
            camInfo = 0;
    end

    camInfo.pos = camInfo.pos;

end
