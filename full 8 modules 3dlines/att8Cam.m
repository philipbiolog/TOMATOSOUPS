function [mean, perc] = att8Cam(camInfo, Pos, pixel_pos, n, CI, plots)

    fidelity = n;
    ErrorPos = zeros(fidelity, 3);
    withinBounds = 0;
    
    cam1_att = camInfo.cam1.attitude;
    cam2_att = camInfo.cam2.attitude;
    cam3_att = camInfo.cam3.attitude;
    cam4_att = camInfo.cam4.attitude;
    cam5_att = camInfo.cam5.attitude;
    cam6_att = camInfo.cam6.attitude;
    cam7_att = camInfo.cam7.attitude;
    cam8_att = camInfo.cam8.attitude;
    
    
    xy_err = .4;
    z_err = .6;
    
    max = CI(2);
    min = CI(1);
    
    for i=1:fidelity
        
        camInfo.cam1.attitude = cam1_att + [xy_err*randn(2, 1); z_err*randn(1, 1)];
        camInfo.cam2.attitude = cam2_att + [xy_err*randn(2, 1); z_err*randn(1, 1)];
        camInfo.cam3.attitude = cam3_att + [xy_err*randn(2, 1); z_err*randn(1, 1)];
        camInfo.cam4.attitude = cam4_att + [xy_err*randn(2, 1); z_err*randn(1, 1)];
        camInfo.cam5.attitude = cam5_att + [xy_err*randn(2, 1); z_err*randn(1, 1)];
        camInfo.cam6.attitude = cam6_att + [xy_err*randn(2, 1); z_err*randn(1, 1)];
        camInfo.cam7.attitude = cam7_att + [xy_err*randn(2, 1); z_err*randn(1, 1)];
        camInfo.cam8.attitude = cam8_att + [xy_err*randn(2, 1); z_err*randn(1, 1)];
    
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
        title("Single Simulation of Normal Error in Camera Attitude")
        hold off
    
        figure
        histogram(ErrorY, 'NumBins', 50)
        hold on
        xlabel("Error in Y-Position Estimate")
        ylabel("Number of Simulations")
        title("Single Simulation of Normal Error in Camera Attitude")
        hold off
    
        figure
        histogram(ErrorZ, 'NumBins', 50)
        hold on
        xlabel("Error in Z-Position Estimate")
        ylabel("Number of Simulations")
        title("Single Simulation of Normal Error in Camera Attitude")
        hold off
    end
    
    

    mean = sum(ErrorPos)/n;
    
    perc = withinBounds/n;


end