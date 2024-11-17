function figNum = frameErrorAnalysis(cameraInfo1, cameraInfo2, frame_error, Pixel1, Pixel2, Pos, n, figNum)
    frame1_X = Pixel1;
    frame1_Z = Pixel1;
    frame1_both = Pixel1;
    frame2_both = Pixel2;
    
    Err_Z = zeros(n, 3);
    Err_X = zeros(n, 3);
    Err_Both = zeros(n, 3);
    Err2 = zeros(n, 3);
    
    for i=1:n
        frame1_X(1) = Pixel1(1) + frame_error(1, i);
        frame1_Z(2) = Pixel1(2) + frame_error(2, i);
        frame1_both = Pixel1 + frame_error(:, i)';
        frame2_both = Pixel2 + frame_error(:, i)';
        WrongPos_X = SecondOrder3DLine(frame1_X,cameraInfo1,Pixel2,cameraInfo2);
        WrongPos_Z = SecondOrder3DLine(frame1_Z,cameraInfo1,Pixel2,cameraInfo2);
        WrongPos_Both = SecondOrder3DLine(frame1_both,cameraInfo1,Pixel2,cameraInfo2);
        WrongPos2 = SecondOrder3DLine(frame1_both,cameraInfo1,frame2_both,cameraInfo2);
    
        Err_X(i, :) = abs(Pos - WrongPos_X');
        Err_Z(i, :) = abs(Pos - WrongPos_Z');
        Err_Both(i, :) = abs(Pos - WrongPos_Both');
        Err2(i, :) = abs(Pos - WrongPos2');
    
    end
    
    % Plotting
    
    figure(figNum)
    hold on 
    valid = plotFrameError(frame_error, Err_X, figNum);
    subplot(3, 1, 1)
    title("Calculated Error with Error in X Frame Position");
    hold off
    figNum = figNum + 1;

    figure(figNum)
    hold on
    valid = plotFrameError(frame_error, Err_Z, figNum);
    subplot(3, 1, 1)
    title("Calculated Error with Error in Z Frame Position");
    hold off
    figNum = figNum + 1;
    
    figure(figNum)
    hold on
    valid = plotFrameError(frame_error, Err_Both, figNum);
    subplot(3, 1, 1)
    title("Calculated Error with Error in X and Z Frame Position");
    hold off
    figNum = figNum + 1;
     
    figure(figNum)
    hold on
    valid = plotFrameError(frame_error, Err2, figNum);
    subplot(3, 1, 1)
    title("Calculated Error with Error in X Frame Position for Both Cameras");
    hold off
    figNum = figNum + 1;

    
end