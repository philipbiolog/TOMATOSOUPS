clear all; clc; close all;


function [position,velocity] = estimation(datafilename,n,)

data = readmatrix(datafilename);

time = data(:,1);

pixelPositions = data(:,2:end);

camInfo = CameraInformation();














