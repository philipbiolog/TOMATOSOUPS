function [mean, perc] = frame8Cam(camInfo, Pos, pixel_pos, n, CI, plots)

    fidelity = n;
    ErrorPos = zeros(fidelity, 3);
    withinBounds = 0;
    
    pix1 = pixel_pos(1, :);
    pix2 = pixel_pos(2, :);
    pix3 = pixel_pos(3, :);
    pix4 = pixel_pos(4, :);
    pix5 = pixel_pos(5, :);
    pix6 = pixel_pos(6, :);
    pix7 = pixel_pos(7, :);
    pix8 = pixel_pos(8, :);

    pixErr = 8;
    
    
    max = CI(2);
    min = CI(1);
    
    for i=1:fidelity

        errPixels = pixErr * randn(8,2);
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
        title("Single Simulation of Normal Error in Camera Frame Bounding")
        hold off
    
        figure
        histogram(ErrorY, 'NumBins', 50)
        hold on
        xlabel("Error in Y-Position Estimate")
        ylabel("Number of Simulations")
        title("Single Simulation of Normal Error in Camera Frame Bounding")
        hold off
    
        figure
        histogram(ErrorZ, 'NumBins', 50)
        hold on
        xlabel("Error in Z-Position Estimate")
        ylabel("Number of Simulations")
        title("Single Simulation of Normal Error in Camera Frame Bounding")
        hold off
    end
    
    

    mean = sum(ErrorPos)/n;
    
    perc = withinBounds/n;


end