function cam = camData(camInfo)

% Prompt user to select a MAT file
[file, path] = uigetfile({'*.mat', 'MAT-files (*.mat)'}, 'Select a MAT file containing trackedPositions');
if isequal(file, 0)
    error('User canceled file selection.');
end

fullFilePath = fullfile(path, file);

% Load the data
data = cell2mat(struct2cell(load(fullFilePath, 'trackedPositions')));

% Process the data
cam.x = data(:,1);
cam.z = data(:,2);
cam.seen = ones(length(cam.x), 1);

mask = isnan(cam.x) | isnan(cam.z);
cam.seen(mask) = 0;

% Copy over camera information
cam.pos = camInfo.pos;
cam.FOV = [camInfo.FOV_w, camInfo.FOV_l];
cam.res = camInfo.res;
cam.R = camInfo.R;

end
