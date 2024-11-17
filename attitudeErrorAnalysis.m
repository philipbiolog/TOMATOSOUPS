function figNum = attitudeErrorAnalysis(cameraInfo1, cameraInfo2, camAtt_error, Pixel1, Pixel2, Pos, n, figNum)
    AttErr1 = cameraInfo1;
    AttErr1_X = cameraInfo1;
    AttErr1_Y = cameraInfo1;
    AttErr1_Z = cameraInfo1;
    AttErr2 = cameraInfo2;
    
    Err_Att_Cam1 = zeros(n, 3);
    Err_Att_Cam1_X = zeros(n, 3);
    Err_Att_Cam1_Y = zeros(n, 3);
    Err_Att_Cam1_Z = zeros(n, 3);
    Err_Att_Both = zeros(n, 3);
    
    for i=1:n
        AttErr1.attitude = cameraInfo1.attitude + camAtt_error(:, i);
        AttErr1_X.attitude(1) = cameraInfo1.attitude(1) + camAtt_error(1, i);
        AttErr1_Y.attitude(2) = cameraInfo1.attitude(2) + camAtt_error(2, i);
        AttErr1_Z.attitude(3) = cameraInfo1.attitude(3) + camAtt_error(3, i);
        AttErr2.attitude = cameraInfo2.attitude + camAtt_error(:, i);
    
        WrongAtt1 = SecondOrder3DLine(Pixel1,AttErr1,Pixel2,cameraInfo2);
        WrongAtt1_X = SecondOrder3DLine(Pixel1,AttErr1_X,Pixel2,cameraInfo2);
        WrongAtt1_Y = SecondOrder3DLine(Pixel1,AttErr1_Y,Pixel2,cameraInfo2);
        WrongAtt1_Z = SecondOrder3DLine(Pixel1,AttErr1_Z,Pixel2,cameraInfo2);
        WrongAttBoth = SecondOrder3DLine(Pixel1,AttErr1,Pixel2,AttErr2);
    
        Err_Att_Cam1(i, :) = abs(Pos - WrongAtt1');
        Err_Att_Cam1_X(i, :) = abs(Pos - WrongAtt1_X');
        Err_Att_Cam1_Y(i, :) = abs(Pos - WrongAtt1_Y');
        Err_Att_Cam1_Z(i, :) = abs(Pos - WrongAtt1_Z');
        Err_Att_Both(i, :) = abs(Pos - WrongAttBoth');
    
    end
    
    % Plotting
    
    figure(figNum)
    hold on
    valid = plotCameraAttError(camAtt_error, Err_Att_Cam1_X, figNum);
    subplot(3, 1, 1)
    title("Calculated Error with Error in Orientation about X-axis for One Camera");
    hold off
    figNum = figNum + 1;
     
    figure(figNum)
    hold on
    valid = plotCameraAttError(camAtt_error, Err_Att_Cam1_X, figNum);
    subplot(3, 1, 1)
    title("Calculated Error with Error in Orientation about Y-axis for One Camera");
    hold off
    figNum = figNum + 1;
    
    figure(figNum)
    hold on
    valid = plotCameraAttError(camAtt_error, Err_Att_Cam1_X, figNum);
    subplot(3, 1, 1)
    title("Calculated Error with Error in Orientation about Z-axis for One Camera");
    hold off
    figNum = figNum + 1;
    
    figure(figNum)
    hold on
    valid = plotCameraAttError(camAtt_error, Err_Att_Cam1_X, figNum);
    subplot(3, 1, 1)
    title("Calculated Error with Error in Orientation about all axes for One Camera");
    hold off
    figNum = figNum + 1;
    
    figure(figNum)
    hold on
    valid = plotCameraAttError(camAtt_error, Err_Att_Cam1_X, figNum);
    subplot(3, 1, 1)
    title("Calculated Error with Error in Orientation about all axes for Both Cameras");
    hold off
    figNum = figNum + 1;

end
