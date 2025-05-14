function [mean, perc] = pos8Cam(camInfo, Pos, pixel_pos, n, CI, plots)

    fidelity = n;
    ErrorPos = zeros(fidelity, 3);
    withinBounds = 0;
    
    cam1_pos = [camInfo.cam1.X, camInfo.cam1.Y, camInfo.cam1.Z];
    cam2_pos = [camInfo.cam2.X, camInfo.cam2.Y, camInfo.cam2.Z];
    cam3_pos = [camInfo.cam3.X, camInfo.cam3.Y, camInfo.cam3.Z];
    cam4_pos = [camInfo.cam4.X, camInfo.cam4.Y, camInfo.cam4.Z];
    cam5_pos = [camInfo.cam5.X, camInfo.cam5.Y, camInfo.cam5.Z];
    cam6_pos = [camInfo.cam6.X, camInfo.cam6.Y, camInfo.cam6.Z];
    cam7_pos = [camInfo.cam7.X, camInfo.cam7.Y, camInfo.cam7.Z];
    cam8_pos = [camInfo.cam8.X, camInfo.cam8.Y, camInfo.cam8.Z];
    
    err = .5;
    
    
    max = CI(2);
    min = CI(1);
    
    for i=1:fidelity
    %     for j=1:8
    %         Error(i, 1:2) = 10*randn(1, 2);
    %     end
        errPos = err * randn(8, 3);
        
        camInfo.cam1.X = cam1_pos(1) + errPos(1, 1);
        camInfo.cam2.X = cam2_pos(1) + errPos(2, 1);
        camInfo.cam3.X = cam3_pos(1) + errPos(3, 1);
        camInfo.cam4.X = cam4_pos(1) + errPos(4, 1);
        camInfo.cam5.X = cam5_pos(1) + errPos(5, 1);
        camInfo.cam6.X = cam6_pos(1) + errPos(6, 1);
        camInfo.cam7.X = cam7_pos(1) + errPos(7, 1);
        camInfo.cam8.X = cam8_pos(1) + errPos(8, 1);

        camInfo.cam1.Y = cam1_pos(2) + errPos(1, 2);
        camInfo.cam2.Y = cam2_pos(2) + errPos(2, 2);
        camInfo.cam3.Y = cam3_pos(2) + errPos(3, 2);
        camInfo.cam4.Y = cam4_pos(2) + errPos(4, 2);
        camInfo.cam5.Y = cam5_pos(2) + errPos(5, 2);
        camInfo.cam6.Y = cam6_pos(2) + errPos(6, 2);
        camInfo.cam7.Y = cam7_pos(2) + errPos(7, 2);
        camInfo.cam8.Y = cam8_pos(2) + errPos(8, 2);

        camInfo.cam1.Z = cam1_pos(3) + errPos(1, 3);
        camInfo.cam2.Z = cam2_pos(3) + errPos(2, 3);
        camInfo.cam3.Z = cam3_pos(3) + errPos(3, 3);
        camInfo.cam4.Z = cam4_pos(3) + errPos(4, 3);
        camInfo.cam5.Z = cam5_pos(3) + errPos(5, 3);
        camInfo.cam6.Z = cam6_pos(3) + errPos(6, 3);
        camInfo.cam7.Z = cam7_pos(3) + errPos(7, 3);
        camInfo.cam8.Z = cam8_pos(3) + errPos(8, 3);
    
        position = ThreeDLines(pixel_pos,camInfo,8);
        ErrorPos(i, :) = Pos - position';
        norm_err = norm(ErrorPos(i, :));
        if (norm_err < max) && (norm_err > min)
            withinBounds = withinBounds + 1;
        end
    end


    ErrorX = rmoutliers(ErrorPos(:, 1));
    ErrorY = rmoutliers(ErrorPos(:, 2));
    ErrorZ = rmoutliers(ErrorPos(:, 3));
    
    if plots

        figure
        histogram(ErrorX, 'NumBins', 50)
        hold on
        xlabel("Error in X-Position Estimate")
        ylabel("Number of Simulations")
        title("Single Simulation of Normal Error in Camera Position")
        hold off
    
        figure
        histogram(ErrorY, 'NumBins', 50)
        hold on
        xlabel("Error in Y-Position Estimate")
        ylabel("Number of Simulations")
        title("Single Simulation of Normal Error in Camera Position")
        hold off
    
        figure
        histogram(ErrorZ, 'NumBins', 50)
        hold on
        xlabel("Error in Z-Position Estimate")
        ylabel("Number of Simulations")
        title("Single Simulation of Normal Error in Camera Position")
        hold off
    end
    
    

    mean = sum(ErrorPos)/n;
    
    perc = withinBounds/n;


end