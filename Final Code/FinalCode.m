clear all; clc; close all;


function [position,velocity] = estimation(datafilename,n)

    data = readmatrix(datafilename);
    
    time = data(:,1);
    
    pixelPositions = data(:,2:end);
    
    camInfo = CameraInformation();
    
    for j=1:length(time)
    
        position = ThreeDLines(pixelPositions(i,:),camInfo,n);
    
    end
    
    [raw_data,velocity] = EstimateVelocity(position,time);

end














