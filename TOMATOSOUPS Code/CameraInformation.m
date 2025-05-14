function camInfo = CameraInformation(x)

    R = rotation321([90, 0, 0]); % Rotation from T frame to our coordinate frame

    camInfo.res = [3840;2880];       
    camInfo.FOV_w = 107.11;
    camInfo.FOV_l = 74.22; % deg

    %% Load in Rotation Matrices and Translation Vectors

    % R_12 is the rotation matrix from frame 2 to frame 1
    % v_12 is the position offset from cam 2 relative to cam 1 in frame 2

    R_12 = [];
    v_12 = [];

    R_23 = [];
    v_23 = [];

    R_34 = [];
    v_34 = [];

    R_18 = [];
    v_18 = [];

    R_87 = [];
    v_87 = [];

    R_76 = [];
    v_76 = [];

    R_65 = [];
    v_65 = [];





%% Load Camera Information
%{
Here, we are using a switch statement to load the camInfo Parameters into
the output variable depending on the value of x, which corelates to the
camera number. A few notes:
 - The camera numbers are arbitrary, as long as they are kept
consistent. 
 - Camera 1 is considered the origin of the range, in both position and
 orientation
 - It may be worthwile to change how the data is loaded in the previous
 section. Right now, it is manually typed in (or copied in), but it may be
 better to have an excel format that is standardized so that it can be
 loaded and read quickly and used sent out individually for each team to
 use - so that each day can correspond to a calibration spreadsheet.

%}


    switch x 
        case 1
            % Cam 1
            camInfo.pos = [0;0;0];      % Meters
            camInfo.R = eye(3);
  
        case 2
            % Cam 2  
            v = -R * R_12 * v_12;
            R_cam_to_inert = R_12;
            camInfo.pos = convLength(v, 'in', 'm');  % Position offset from Meters
            camInfo.R = R*R_cam_to_inert*R';         % Rotation matrix

        case 3
            % Cam 3
            R_cam_to_inert = R_12 * R_23;
            v = -R * R_12 * v_12 - R * R_cam_to_inert * v_23;
            camInfo.pos = convLength(v, 'in', 'm');  % Position offset from Meters
            camInfo.R = R*R_cam_to_inert*R';         % Rotation matrix
        case 4
            % Cam 4
            R_cam_to_inert = R_12 * R_23 * R_34;
            v = -R * R_12 * v_12 - R * R_12 * R_23 * v_23 - R * R_cam_to_inert * v_34;
            camInfo.pos = convLength(v, 'in', 'm');  % Position offset from Meters
            camInfo.R = R*R_cam_to_inert*R';         % Rotation matrix
        case 5
            % Cam 6
            R_cam_to_inert = R_18 * R_87 * R_76 * R_65;
            v = -R * R_18 * v_18 - R * R_18 * R_87 * v_87 - R * R_18 * R_87 * R_76 * v_76 - R * R_cam_to_inert * v_65;
            camInfo.pos = convLength(v, 'in', 'm');  % Position offset from Meters
            camInfo.R = R*R_cam_to_inert*R';         % Rotation matrix
        case 6
            % Cam 6
            R_cam_to_inert = R_18 * R_87 * R_76;
            v = -R * R_18 * v_18 - R * R_18 * R_87 * v_87 - R * R_cam_to_inert * v_76;
            camInfo.pos = convLength(v, 'in', 'm');  % Position offset from Meters
            camInfo.R = R*R_cam_to_inert*R';         % Rotation matrix
        case 7
            % Cam 7
            R_cam_to_inert = R_18 * R_87;
            v = -R * R_18 * v_18 - R * R_cam_to_inert * v_87;
            camInfo.pos = convLength(v, 'in', 'm');  % Position offset from Meters
            camInfo.R = R*R_cam_to_inert*R';         % Rotation matrix
        case 8
            % Cam 8
            R_cam_to_inert = R_18;
            v = -R * R_18 * v_18;
            camInfo.pos = convLength(v, 'in', 'm');  % Position offset from Meters
            camInfo.R = R*R_cam_to_inert*R';         % Rotation matrix
        otherwise
            camInfo = 0;
    end

    camInfo.pos = R*camInfo.pos;

end
