function camInfo = CameraInformation()

Rx = RotationMatrix321([pi/2;0;0]);

%Conversion rate from inch to m
in2m = 0.0254;

%% Checkeboard Calibration information
%% Camera 1 and Camera 8
% Rotation Matrix: COPY AND PASTE HERE
R_18 = []; %3x3 matrix

% Translation Vector : COPY AND PASTE HERE
t_18 =  [] * in2m ; % 3x1 vector - leave conversion rate

%% Camera 1 and Camera 2 
% Rotation Matrix
R_12 = []; %3x3 matrix

% Translation Vector
t_12 = [] * in2m ; % 3x1 vector - leave conversion rate

%% Camera 2 and Camera 3 
% Rotation Matrix
R_23 = []; %3x3 matrix

% Translation Vector
t_23 = [] * in2m ; % 3x1 vector - leave conversion rate

%% Camera 3 and Camera 4 
% Rotation Matrix
R_34 = []; %3x3 matrix

% Translation Vector
t_34 = [] * in2m ; % 3x1 vector - leave conversion rate

%% Camera 4 and Camera 5 
% Rotation Matrix
R_45 = []; %3x3 matrix

% Translation Vector
t_45 = [] * in2m ; % 3x1 vector - leave conversion rate

%% Camera 5 and Camera 6 
% Rotation Matrix
R_56 = []; %3x3 matrix

% Translation Vector
t_56 = [] * in2m ; % 3x1 vector - leave conversion rate

%% Camera 5 and Camera 6 
% Rotation Matrix
R_56 = []; %3x3 matrix

% Translation Vector
t_56 = [] * in2m ; % 3x1 vector - leave conversion rate

%% Camera 6 and Camera 7 
% Rotation Matrix
R_67 = []; %3x3 matrix

% Translation Vector
t_67 = [] * in2m ; % 3x1 vector - leave conversion rate

%% Camera 7 and Camera 8
% Rotation Matrix: COPY AND PASTE HERE
R_78 = []; %3x3 matrix

% Translation Vector
t_78 =  [] * in2m ; % 3x1 vector - leave conversion rate



%% Actual values
%% Cam 1
camInfo.cam1.X = 0;
camInfo.cam1.Y = 0;
camInfo.cam1.Z = 0;

camInfo.cam1.R = eye(3,3);
camInfo.cam1.resolution = [3840;2880];

camInfo.cam1.FOV_w = 107.11;
camInfo.cam1.FOV_l = 74.22; % deg

%% Cam 2

camInfo.cam2.R = Rx*R_12'*Rx';

x2 = Rx*t_12;

camInfo.cam2.X = x2(1);
camInfo.cam2.Y = x2(2);
camInfo.cam2.Z = x2(3);

camInfo.cam2.resolution = [3840;2880];

camInfo.cam2.FOV_w = 107.11;
camInfo.cam2.FOV_l = 74.22; % deg

%% Cam 3

camInfo.cam3.R = Rx*R_12'*R_23'*Rx';

x3 = Rx*R_12'*t_23 + x2;

camInfo.cam2.X = x3(1);
camInfo.cam2.Y = x3(2);
camInfo.cam2.Z = x3(3);

camInfo.cam3.resolution = [3840;2880];

camInfo.cam3.FOV_w = 107.11;
camInfo.cam3.FOV_l = 74.22; % deg

%% Cam 4

camInfo.cam4.R = Rx*R_12'*R_23'*R_34'*Rx';

x4 = Rx*R_12'*R_23'*t_34 + x3;

camInfo.cam2.X = x4(1);
camInfo.cam2.Y = x4(2);
camInfo.cam2.Z = x4(3);

camInfo.cam3.resolution = [3840;2880];

camInfo.cam3.FOV_w = 107.11;
camInfo.cam3.FOV_l = 74.22; % deg

%% Cam 5

camInfo.cam4.R = Rx*R_12'*R_23'*R_34'*R_45'*Rx';

x5 = Rx*R_12'*R_23'*R_34'*t_34 + x4;

camInfo.cam2.X = x5(1);
camInfo.cam2.Y = x5(2);
camInfo.cam2.Z = x5(3);

camInfo.cam3.resolution = [3840;2880];

camInfo.cam3.FOV_w = 107.11;
camInfo.cam3.FOV_l = 74.22; % deg

%% Cam 8

x8 = Rx*t_18;

camInfo.cam8.X = x8(1);
camInfo.cam8.Y = x8(2);
camInfo.cam8.Z = x8(3);

camInfo.cam8.R = Rx*R_18'*Rx';

% camInfo.cam2.attitude = [0;0;92.5];
camInfo.cam8.resolution = [3840;2880];

camInfo.cam8.FOV_w = 107.11;
camInfo.cam8.FOV_l = 74.22; % deg

%% Cam 7

x7 = -1*(Rx * R_18' * R_78 * t_78) + x8;

camInfo.cam7.X = x7(1);
camInfo.cam7.Y = x7(2);
camInfo.cam7.Z = x7(3);

camInfo.cam7.R = Rx*R_18'*R_78*Rx';

% camInfo.cam2.attitude = [0;0;92.5];
camInfo.cam7.resolution = [3840;2880];

camInfo.cam7.FOV_w = 107.11;
camInfo.cam7.FOV_l = 74.22; % deg

%% Cam 6

x6 = -1*(Rx * R_18' * R_78 * R_67 * t_67) + x7;

camInfo.cam7.X = x6(1);
camInfo.cam7.Y = x6(2);
camInfo.cam7.Z = x6(3);

camInfo.cam7.R = Rx*R_18'*R_78*R_67*Rx';

% camInfo.cam2.attitude = [0;0;92.5];
camInfo.cam7.resolution = [3840;2880];

camInfo.cam7.FOV_w = 107.11;
camInfo.cam7.FOV_l = 74.22; % deg


end