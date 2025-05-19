function NEXAARMVPV6 = NEXAARMVPV6(filename)

% Load video and initialize video reader
videoFile = filename; 
vidObj = VideoReader(videoFile);

% Choose the starting frame for annotation
startFrame = 1;

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

% Initialize manual tracking data
manualDataFile = 'manual_tracking_data.mat';
manualFrames = (1:startFrame-1)'; % Pre-fill earlier frames as NaN
manualPositions = NaN(startFrame-1, 2);

% Open figure for displaying frames
figure;
frameStep = round((numFrames - startFrame) / 80);
kList = startFrame:frameStep:numFrames;
if kList(end) ~= numFrames
    kList(end+1) = numFrames;
end

i = 1;
while i <= length(kList)
    k = kList(i);

    % Read and display frame
    frame = read(vidObj, k);
    imshow(frame);
    title(sprintf('Frame %d: Outline the glider', k));

    choice = questdlg(sprintf('Is the glider visible in frame %d?', k), ...
                      'Glider Visibility', ...
                      'Yes','No','Yes');

    if strcmp(choice, 'Yes')
        h = drawfreehand(gca);
        mask = createMask(h);
        delete(h);

        [y, x] = find(mask);
        posX = mean(x);
        posY = mean(y);
        trackedPositions(k, :) = [posX, posY];
        manualFrames = [manualFrames; k];
        manualPositions = [manualPositions; posX, posY];

        frame = insertShape(frame, 'Circle', [posX, posY, 10], 'Color', 'red', 'LineWidth', 2);
    else
        trackedPositions(k, :) = [NaN, NaN];
        manualFrames = [manualFrames; k];
        manualPositions = [manualPositions; NaN, NaN];

        frame = insertText(frame, [10, 10], 'Glider Not Visible', ...
                           'FontSize', 18, 'BoxColor', 'black', 'TextColor', 'white');

        if i < length(kList)
            nextK = kList(i + 1);
            nextFrame = read(vidObj, nextK);
            imshow(nextFrame);
            title(sprintf('Frame %d: Is the glider visible in this next frame?', nextK));
            nextChoice = questdlg('Is the glider visible in this next frame?', ...
                                  'Glider Visibility (Next Frame)', ...
                                  'Yes', 'No', 'Yes');

            if strcmp(nextChoice, 'Yes')
                midK = round((k + nextK) / 2);
                midFrame = read(vidObj, midK);
                imshow(midFrame);
                title(sprintf('Frame %d (Midpoint): Please outline the glider', midK));

                h = drawfreehand(gca);
                mask = createMask(h);
                delete(h);

                [y, x] = find(mask);
                posX = mean(x);
                posY = mean(y);
                trackedPositions(midK, :) = [posX, posY];
                manualFrames = [manualFrames; midK];
                manualPositions = [manualPositions; posX, posY];

                midFrame = insertShape(midFrame, 'Circle', [posX, posY, 10], 'Color', 'green', 'LineWidth', 2);
                writeVideo(outputVideo, midFrame);
            end
        end
    end

    writeVideo(outputVideo, frame);
    i = i + 1;
end

save(manualDataFile, 'manualFrames', 'manualPositions');
fprintf('Manual tracking data saved.\n');

% Interpolation
validIdx = ~isnan(manualPositions(:, 1));
validFrames = manualFrames(validIdx);
validPositionsX = manualPositions(validIdx, 1);
validPositionsY = manualPositions(validIdx, 2);
interpX = spline(validFrames, validPositionsX, 1:numFrames);
interpY = spline(validFrames, validPositionsY, 1:numFrames);

% Output full annotated video
for i = 1:numFrames
    frame = read(vidObj, i);
    if isnan(trackedPositions(i, 1))
        posX = interpX(i);
        posY = interpY(i);
    else
        posX = trackedPositions(i, 1);
        posY = trackedPositions(i, 2);
    end
    frame = insertShape(frame, 'Circle', [posX, posY, 10], 'Color', 'red', 'LineWidth', 2);
    writeVideo(outputVideo, frame);
end

close(outputVideo);

% Plot for analysis
figure;
plot(interpX, interpY, '-o');
hold on;
plot(manualPositions(:,1), manualPositions(:,2), 'rx', 'MarkerSize', 8, 'LineWidth', 2);
title('Tracked and Interpolated Glider Positions');
xlabel('X Position');
ylabel('Y Position');
legend('Interpolated Path', 'Manual Outlines');

NEXAARMVPV6 = [interpX, interpY];

end
