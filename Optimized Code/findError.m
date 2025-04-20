function err = findError(testData, VICON, time)

    err = zeros(size(testData));
    f = @(z) interp1( (1:length(VICON))/100, VICON, z);
    n = length(testData);
    for i = 1:n
        t_data = (i-1) * 1/24;
        interVal = f(t_data / 100);
        err(i) = testData(i) - interVal;
    end
    







end