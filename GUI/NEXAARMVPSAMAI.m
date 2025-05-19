function NEXAARMVPSAMAI = NEXAARMVPSAMAI(filename)

% Load video and initialize video reader
videoFile = filename;
vidObj = VideoReader(videoFile);

% Parameters for tracking
numFrames = vidObj.NumFrames;
trackedPositions = NaN(numFrames, 2); % [x, y] position of the glider per frame

% Set up output video writer
[filepath, name, ext] = fileparts(filename); % Split into parts

newName = strcat(name, '_processed', ext); % Add '_processed' before extension

outputVideoFile = newName;
outputVideo = VideoWriter(outputVideoFile, 'MPEG-4');
outputVideo.FrameRate = vidObj.FrameRate;
open(outputVideo);

% Get first frame and prompt user to select color
firstFrame = read(vidObj, 1);
figure;
imshow(firstFrame);
title('Click on the object color you want to track');
[x, y] = ginput(1);
clickedColor = double(squeeze(firstFrame(round(y), round(x), :)))'; % RGB triplet
close;

% Define color tolerance for tracking
colorTolerance = 40; % You can tune this as needed

% Precompute squared tolerance for speed
colorToleranceSq = colorTolerance^2;

% Track object based on color in each frame
for k = 1:numFrames
    frame = read(vidObj, k);
    rgbFrame = double(frame);

    % Compute distance from selected color
    dist = (rgbFrame(:,:,1) - clickedColor(1)).^2 + ...
           (rgbFrame(:,:,2) - clickedColor(2)).^2 + ...
           (rgbFrame(:,:,3) - clickedColor(3)).^2;

    % Create mask of matching color pixels
    mask = dist < colorToleranceSq;

    % Find centroid of mask
    [rows, cols] = find(mask);
    if ~isempty(rows)
        posX = mean(cols);
        posY = mean(rows);
        trackedPositions(k, :) = [posX, posY];
        % Annotate the frame
        frame = insertShape(frame, 'Circle', [posX, posY, 10], 'Color', 'red', 'LineWidth', 2);
    end

    writeVideo(outputVideo, frame);
end

% Close the video writer
close(outputVideo);

% Plot tracked positions
figure;
validIdx = ~isnan(trackedPositions(:,1));
plot(trackedPositions(validIdx,1), trackedPositions(validIdx,2), '-o');
title('Tracked Object Positions Based on Selected Color');
xlabel('X Position');
ylabel('Y Position');
legend('Tracked Path');
axis equal

NEXAARMVPSAMAI = trackedPositions;

end