function figNum = positionErrorAnalysis(cameraInfo1, cameraInfo2, camPos_error, Pixel1, Pixel2, Pos, n, figNum)
    PosErr1_X = cameraInfo1;
    PosErr1_Y = cameraInfo1;
    PosErr1_Z = cameraInfo1;
    PosErr1 = cameraInfo1;
    PosErr2 = cameraInfo2;
    
    Err_Pos_Cam1 = zeros(n, 3);
    Err_Pos_Cam1_X = zeros(n, 3);
    Err_Pos_Cam1_Y = zeros(n, 3);
    Err_Pos_Cam1_Z = zeros(n, 3);
    Err_Pos_Both = zeros(n, 3);
    
    for i=1:n
        PosErr1.X = cameraInfo1.X + camPos_error(i);
        PosErr1.Y = cameraInfo1.Y + camPos_error(i);
        PosErr1.Z = cameraInfo1.Z + camPos_error(i);
        PosErr1_X.X = cameraInfo1.X + camPos_error(i);
        PosErr1_Y.Y = cameraInfo1.Y + camPos_error(i);
        PosErr1_Z.Z = cameraInfo1.Z + camPos_error(i);
        PosErr2.X = cameraInfo2.X + camPos_error(i);
        PosErr2.Y = cameraInfo2.Y + camPos_error(i);
        PosErr2.Z = cameraInfo2.Z + camPos_error(i);
        WrongPos1 = SecondOrder3DLine(Pixel1,PosErr1,Pixel2,cameraInfo2);
        WrongPos1_X = SecondOrder3DLine(Pixel1,PosErr1_X,Pixel2,cameraInfo2);
        WrongPos1_Y = SecondOrder3DLine(Pixel1,PosErr1_Y,Pixel2,cameraInfo2);
        WrongPos1_Z = SecondOrder3DLine(Pixel1,PosErr1_Z,Pixel2,cameraInfo2);
        WrongPosBoth = SecondOrder3DLine(Pixel1,PosErr1,Pixel2,PosErr2);
    
        Err_Pos_Cam1(i, :) = abs(Pos - WrongPos1');
        Err_Pos_Cam1_X(i, :) = abs(Pos - WrongPos1_X');
        Err_Pos_Cam1_Y(i, :) = abs(Pos - WrongPos1_Y');
        Err_Pos_Cam1_Z(i, :) = abs(Pos - WrongPos1_Z');
        Err_Pos_Both(i, :) = abs(Pos - WrongPosBoth');
    
    end
    
    % Plotting
    
    figure(figNum)
    hold on 
    valid = plotCameraPosError(camPos_error, Err_Pos_Cam1_X, figNum);
    subplot(3, 1, 1)
    title("Calculated Error with Error in X for One Camera");
    hold off
    figNum = figNum + 1;

    figure(figNum)
    hold on
    valid = plotCameraPosError(camPos_error, Err_Pos_Cam1_Y, figNum);
    subplot(3, 1, 1)
    title("Calculated Error with Error in Y for One Camera");
    hold off
    figNum = figNum + 1;
    
    figure(figNum)
    hold on
    valid = plotCameraPosError(camPos_error, Err_Pos_Cam1_Z, figNum);
    subplot(3, 1, 1)
    title("Calculated Error with Error in Z for One Camera");
    hold off
    figNum = figNum + 1;
     
    figure(figNum)
    hold on
    valid = plotCameraPosError(camPos_error, Err_Pos_Cam1, figNum);
    subplot(3, 1, 1)
    title("Calculated Error with Error in all axis for One Camera");
    hold off
    figNum = figNum + 1;
     
    figure(figNum)
    hold on
    valid = plotCameraPosError(camPos_error, Err_Pos_Both, figNum);
    subplot(3, 1, 1)
    title("Calculated Error with Error in all axis for Both Cameras");
    hold off
    figNum = figNum + 1;
    
end