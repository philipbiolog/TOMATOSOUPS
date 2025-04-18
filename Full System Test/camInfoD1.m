function camInfo = camInfoD1()

Rx = RotationMatrix321([pi/2;0;0]);

%Conversion rate from inch to m
in2m = 0.0254;

%% Camera 1 and Camera 8
% Rotation Matrix 
R_18 = [0.805036876333921	-0.0726917898447451	-0.588754219884402
-0.207883635906561	0.894962166188529	-0.394749433202132
0.555607794820043	0.440180218524531	0.705366113131972];

% Translation Vector
t_81 =  [1509.73238208710	348.340261145677	1369.49230930959] * in2m; % Inches

%% Camera 7 and Camera 8
% Rotation Matrix
R_78 = [0.999915655411302	0.0106079258734301	-0.00749359540213026
-0.0106787339356653	0.999898106471831	-0.00947318930338735
0.00739234096334073	0.00955241240265280	0.999927049695312]; 

% Translation Vector
t_87 = [-73.7389860631579	7.25821290059708	-19.1142834939380] * in2m; % Inches

%% Camera 1 and Camera 2 
% Rotation Matrix
R_12 = [0.471086257738911	-0.0187171968246582	0.881888544155425
0.0686848083802152	0.997517703145952	-0.0155186664439470
-0.879408969062359	0.0678829761681997	0.471202468880657];

% Translation Vector
t_21 = [-1863.74228873381	-119.569422458580	924.048776430168] * in2m;

%% Cam 1
camInfo.cam1.X = 0;
camInfo.cam1.Y = 0;
camInfo.cam1.Z = 0;

% [0;-5.2324;1.6764]

camInfo.cam1.R = eye(3,3);
camInfo.cam1.resolution = [3840;2880];

camInfo.cam1.FOV_w = 107.11;
camInfo.cam1.FOV_l = 74.22; % deg

%% Cam 2

camInfo.cam2.R = Rx*R_12'*Rx';

x2 = -Rx * R_12' * t_21';

camInfo.cam2.X = x2(1);
camInfo.cam2.Y = x2(2);
camInfo.cam2.Z = x2(3);

camInfo.cam2.resolution = [3840;2880];

camInfo.cam2.FOV_w = 107.11;
camInfo.cam2.FOV_l = 74.22; % deg

%% Cam 8

x8 = -Rx * R_18' * t_81';

camInfo.cam8.X = x8(1);
camInfo.cam8.Y = x8(2);
camInfo.cam8.Z = x8(3);

camInfo.cam8.R = Rx*R_18'*Rx';

% camInfo.cam2.attitude = [0;0;92.5];
camInfo.cam8.resolution = [3840;2880];

camInfo.cam8.FOV_w = 107.11;
camInfo.cam8.FOV_l = 74.22; % deg

%% Cam 7

x7 = Rx * R_18' * t_87' + x8;

camInfo.cam7.X = x7(1);
camInfo.cam7.Y = x7(2);
camInfo.cam7.Z = x7(3);

camInfo.cam7.R = Rx*R_18'*R_78*Rx';

% camInfo.cam2.attitude = [0;0;92.5];
camInfo.cam7.resolution = [3840;2880];

camInfo.cam7.FOV_w = 107.11;
camInfo.cam7.FOV_l = 74.22; % deg

end