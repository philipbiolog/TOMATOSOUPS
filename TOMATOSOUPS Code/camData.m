function cam = camData(Filename, camInfo)

file1= strcat('data/2Cam',Filename,'.mat'); % Change these based on filename standards


cam.x = cell2mat(struct2cell(load(file1,'interpX')));   % x and z pos of object in camera frame
cam.z = cell2mat(struct2cell(load(file1,'interpY')));
cam.seen = isnan(cam.x) + isnan(cam.z);
cam.seen = ~cam.seen;   % boolean vector on whether or not the vehicle can be seen

cam.pos = camInfo.pos;

cam.FOV = [camInfo.FOV_w, camInfo.FOV_l];

cam.res = camInfo.res;

cam.R = camInfo.R;

end
