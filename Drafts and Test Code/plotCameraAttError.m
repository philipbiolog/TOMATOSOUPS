function valid = plotCameraAttError(errInput, absError, n)
    %{
    This function plots the position error plots for the camera
    errInput should be 3xm and absError should be mx1

    errInput - Error that is input into the camera initial configuration
    absError - Error seen in the final calculated value of vehicle position
    n        - Figure number

    valid - boolean representing if the function was able to finish
    %}
    valid = 0;

    figure(n)
    hold on
    subplot(3, 1, 1)
    plot(errInput, absError(:, 1));
    xlabel("Error in Camera Orientation [deg]")
    ylabel("Error in Estimated X-Position [m]")
    
    subplot(3, 1, 2)
    plot(errInput, absError(:, 2));
    xlabel("Error in Camera Orientation [deg]")
    ylabel("Error in Estimated Y-Position [m]")
    
    subplot(3, 1, 3)
    plot(errInput, absError(:, 3));
    xlabel("Error in Camera Orientation [deg]")
    ylabel("Error in Estimated Z-Position [m]")
    
    valid = 1;
    
end