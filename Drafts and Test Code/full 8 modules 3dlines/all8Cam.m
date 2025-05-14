function [mean, perc] = all8Cam(camInfo, Pos, pixel_pos, n, CI, plots)

    fidelity = n;
    ErrorPos = zeros(fidelity, 3);
    withinBounds = 0;
    
    %% Initializing Constants
    cam1_pos = [camInfo.cam1.X, camInfo.cam1.Y, camInfo.cam1.Z];
    cam2_pos = [camInfo.cam2.X, camInfo.cam2.Y, camInfo.cam2.Z];
    cam3_pos = [camInfo.cam3.X, camInfo.cam3.Y, camInfo.cam3.Z];
    cam4_pos = [camInfo.cam4.X, camInfo.cam4.Y, camInfo.cam4.Z];
    cam5_pos = [camInfo.cam5.X, camInfo.cam5.Y, camInfo.cam5.Z];
    cam6_pos = [camInfo.cam6.X, camInfo.cam6.Y, camInfo.cam6.Z];
    cam7_pos = [camInfo.cam7.X, camInfo.cam7.Y, camInfo.cam7.Z];
    cam8_pos = [camInfo.cam8.X, camInfo.cam8.Y, camInfo.cam8.Z];

    cam1_att = camInfo.cam1.attitude;
    cam2_att = camInfo.cam2.attitude;
    cam3_att = camInfo.cam3.attitude;
    cam4_att = camInfo.cam4.attitude;
    cam5_att = camInfo.cam5.attitude;
    cam6_att = camInfo.cam6.attitude;
    cam7_att = camInfo.cam7.attitude;
    cam8_att = camInfo.cam8.attitude;
    
    pix1 = pixel_pos(1, :);
    pix2 = pixel_pos(2, :);
    pix3 = pixel_pos(3, :);
    pix4 = pixel_pos(4, :);
    pix5 = pixel_pos(5, :);
    pix6 = pixel_pos(6, :);
    pix7 = pixel_pos(7, :);
    pix8 = pixel_pos(8, :);
 
    xy_err = .3;
    z_err = .45;

    pixErr = 8;
    
    err = .5;
    
    
    max = CI(2);
    min = CI(1);
    
    for i=1:fidelity
        errPos = err * randn(8, 3);
        errPixels = pixErr * randn(8,2);
        
        % Position error
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

        % Attitude Error
        camInfo.cam1.attitude = cam1_att + [xy_err*randn(2, 1); z_err*randn(1, 1)];
        camInfo.cam2.attitude = cam2_att + [xy_err*randn(2, 1); z_err*randn(1, 1)];
        camInfo.cam3.attitude = cam3_att + [xy_err*randn(2, 1); z_err*randn(1, 1)];
        camInfo.cam4.attitude = cam4_att + [xy_err*randn(2, 1); z_err*randn(1, 1)];
        camInfo.cam5.attitude = cam5_att + [xy_err*randn(2, 1); z_err*randn(1, 1)];
        camInfo.cam6.attitude = cam6_att + [xy_err*randn(2, 1); z_err*randn(1, 1)];
        camInfo.cam7.attitude = cam7_att + [xy_err*randn(2, 1); z_err*randn(1, 1)];
        camInfo.cam8.attitude = cam8_att + [xy_err*randn(2, 1); z_err*randn(1, 1)];

        % Pixel Error
        err1 = pix1 + [errPixels(1, :), 0];
        err2 = pix2 + [errPixels(2, :), 0];
        err3 = pix3 + [errPixels(3, :), 0];
        err4 = pix4 + [errPixels(4, :), 0];
        err5 = pix5 + [errPixels(5, :), 0];
        err6 = pix6 + [errPixels(6, :), 0];
        err7 = pix7 + [errPixels(7, :), 0];
        err8 = pix8 + [errPixels(8, :), 0];

        pixel_pos_err = [err1; err2; err3; err4; err5; err6; err7; err8];


    
        position = ThreeDLines(pixel_pos_err,camInfo,8);
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
        title("Single Simulation of Normal Error")
        hold off
    
        figure
        histogram(ErrorY, 'NumBins', 50)
        hold on
        xlabel("Error in Y-Position Estimate")
        ylabel("Number of Simulations")
        title("Single Simulation of Normal Error")
        hold off
    
        figure
        histogram(ErrorZ, 'NumBins', 50)
        hold on
        xlabel("Error in Z-Position Estimate")
        ylabel("Number of Simulations")
        title("Single Simulation of Normal Error")
        hold off
    end
    
    

    mean = sum(ErrorPos)/n;
    
    perc = withinBounds/n;


end