function cam = camData(Filename, camInfo)

file1= strcat('data/2Cam',Filename,'.mat'); % Change these based on filename standards


cam.x = cell2mat(struct2cell(load(file1,'interpX')));
cam.z = cell2mat(struct2cell(load(file1,'interpY')));
cam.seen = ones(length(cam.x),1);

cam.pos = camInfo.pos;

cam.FOV = [camInfo.FOV_w, camInfo.FOV_l];

cam.res = camInfo.res;

cam.R = camInfo.R;

end
