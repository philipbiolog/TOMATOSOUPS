function camInfo = CameraInformation(filename,x)

%{

%% INPUTS

filename: file name of the .mat file that has all the rotation
matrices and displacements calculated by the checkerboard calibration

x: the number of camera you want to extract information from. Meaning, if
you want info from camera 5, x = 5.



%}

load(filename);

Rx = RotationMatrix321([pi/2;0;0]);

%% Checkeboard Calibration information
%% Camera 1 and Camera 8
% Rotation Matrix: COPY AND PASTE HERE
%R_18 = []; %3x3 matrix

% Translation Vector : COPY AND PASTE HERE
t_18 =  convLength(t_18, 'in', 'm'); % 3x1 vector - leave conversion rate

%% Camera 1 and Camera 2
% Rotation Matrix
%R_12 = []; %3x3 matrix

% Translation Vector
t_12 = convLength(t_12, 'in', 'm');

%% Camera 2 and Camera 3
% Rotation Matrix
%R_23 = []; %3x3 matrix

% Translation Vector
t_23 = convLength(t_23, 'in', 'm');

%% Camera 3 and Camera 4
% Rotation Matrix
%R_34 = []; %3x3 matrix

% Translation Vector
t_34 = convLength(t_34, 'in', 'm');

%% Camera 4 and Camera 5
% Rotation Matrix
%R_45 = []; %3x3 matrix

% Translation Vector
t_45 = convLength(t_45, 'in', 'm');

%% Camera 5 and Camera 6
% Rotation Matrix
%R_56 = []; %3x3 matrix

% Translation Vector
t_56 = convLength(t_56, 'in', 'm');

%% Camera 6 and Camera 7
% Rotation Matrix
%R_67 = []; %3x3 matrix

% Translation Vector
t_67 = convLength(t_67, 'in', 'm');

%% Camera 7 and Camera 8
% Rotation Matrix: COPY AND PASTE HERE
%R_78 = []; %3x3 matrix

% Translation Vector
t_78 = convLength(t_78, 'in', 'm');



%% Actual values
%% Cam 1

%% Cam 2

%camInfo.cam2.R = Rx*R_12'*Rx';

x2 = Rx*t_12;

%% Cam 3

%camInfo.cam3.R = Rx*R_12'*R_23'*Rx';

x3 = Rx*R_12'*t_23 + x2;

%% Cam 4

%camInfo.cam4.R = Rx*R_12'*R_23'*R_34'*Rx';

x4 = Rx*R_12'*R_23'*t_34 + x3;

%% Cam 5

%camInfo.cam4.R = Rx*R_12'*R_23'*R_34'*R_45'*Rx';

%x5 = Rx*R_12'*R_23'*R_34'*t_45 + x4;

%% Cam 8

x8 = Rx*t_18;

%camInfo.cam8.R = Rx*R_18'*Rx';

%% Cam 7

x7 = -1*(Rx * R_18' * R_78 * t_78) + x8;

%camInfo.cam7.R = Rx*R_18'*R_78*Rx';

%% Cam 6

%x6 = -1*(Rx * R_18' * R_78 * R_67 * t_67) + x7;

%% Switch case
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
        camInfo.pos = Rx * t_12; % Meters

        camInfo.R = R*R_12'*R';             % Rotation

    case 3
        camInfo.R = Rx*R_12'*R_23'*Rx';

        camInfo.pos = Rx*R_12'*t_23 + x2;

    case 4
        camInfo.R = Rx*R_12'*R_23'*R_34'*Rx';
        camInfo.pos = Rx*R_12'*R_23'*t_34 + x3;

    case 5
        camInfo.cam4.R = Rx*R_12'*R_23'*R_34'*R_45'*Rx';

        camInfo.pos = Rx*R_12'*R_23'*R_34'*t_45 + x4;

    case 6

        camInfo.pos = -1*(Rx * R_18' * R_78 * R_67 * t_67) + x7;

        camInfo.cam7.R = Rx*R_18'*R_78*R_67*Rx';

    case 7
        % Cam 7
        camInfo.pos = -1*(Rx * R_18' * R_78 * t_78) + x8;

        camInfo.R = Rx*R_18'*R_78*Rx';

    case 8
        % Cam 8
        camInfo.pos = Rx*t_18; % Meters

        camInfo.R = Rx*R_18'*Rx'; % 1 -> 8

    otherwise
        camInfo = 0;
        camInfo.pos = [0;0;0];
end

end
