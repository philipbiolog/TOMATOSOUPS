figure
histogram(perc_att1, 'NumBins', 20)
hold on
xlabel("Percentage of Data within Error Tolerance")
title("Histrogram of Attitude Error with Tolerance +/- 1 m")
xlim([min(perc_att1)-.05, 1])
plot([ConfInt99(1, 1), ConfInt99(1, 2)], [0 0], 'r', 'LineWidth', 2)
plot([ConfInt95(1, 1), ConfInt95(1, 2)], [.01 .01], 'g', 'LineWidth', 2)
hold off

figure
histogram(perc_att2, 'NumBins', 20)
hold on
xlabel("Percentage of Data within Error Tolerance")
title("Histrogram of Attitude Error with Tolerance +/- .5 m")
xlim([min(perc_att2)-.05, max(perc_att2)+.05])
plot([ConfInt99(2, 1), ConfInt99(2, 2)], [0 0], 'r', 'LineWidth', 2)
plot([ConfInt95(2, 1), ConfInt95(2, 2)], [.01 .01], 'g', 'LineWidth', 2)
hold off

figure
histogram(perc_pos1, 'NumBins', 20)
hold on
xlabel("Percentage of Data within Error Tolerance")
title("Histrogram of Position Error with Tolerance +/- 1 m")
xlim([min(perc_pos1)-.05, 1])
plot([ConfInt99(3, 1), ConfInt99(3, 2)], [0 0], 'r', 'LineWidth', 2)
plot([ConfInt95(3, 1), ConfInt95(3, 2)], [.01 .01], 'g', 'LineWidth', 2)
hold off

figure
histogram(perc_pos2, 'NumBins', 20)
hold on
xlabel("Percentage of Data within Error Tolerance")
title("Histrogram of Position Error with Tolerance +/- .5 m")
xlim([min(perc_pos2)-.05, max(perc_pos2)+.05])
plot([ConfInt99(4, 1), ConfInt99(4, 2)], [0 0], 'r', 'LineWidth', 2)
plot([ConfInt95(4, 1), ConfInt95(4, 2)], [.01 .01], 'g', 'LineWidth', 2)
hold off

figure
histogram(perc_frame1, 'NumBins', 20)
hold on
xlabel("Percentage of Data within Error Tolerance")
title("Histrogram of Frame Error with Tolerance +/- 1 m")
plot([ConfInt99(5, 1), ConfInt99(5, 2)], [0 0], 'r', 'LineWidth', 2)
plot([ConfInt95(5, 1), ConfInt95(5, 2)], [.01 .01], 'g', 'LineWidth', 2)
hold off

figure
histogram(perc_frame2, 'NumBins', 20)  
hold on
xlabel("Percentage of Data within Error Tolerance")
title("Histrogram of Frame Error with Tolerance +/- .5 m")
plot([ConfInt99(6, 1), ConfInt99(6, 2)], [0 0], 'r', 'LineWidth', 2)
plot([ConfInt95(6, 1), ConfInt95(6, 2)], [.01 .01], 'g', 'LineWidth', 2)
hold off

figure
histogram(perc_all1, 'NumBins', 20)
hold on
xlabel("Percentage of Data within Error Tolerance")
title("Histrogram of Total Error with Tolerance +/- 1 m")
xlim([min(perc_all1)-.05, 1])
plot([ConfInt99(7, 1), ConfInt99(7, 2)], [0 0], 'r', 'LineWidth', 2)
plot([ConfInt95(7, 1), ConfInt95(7, 2)], [.01 .01], 'g', 'LineWidth', 2)
hold off

figure
histogram(perc_all2, 'NumBins', 20)
hold on
xlabel("Percentage of Data within Error Tolerance")
title("Histrogram of Total Error with Tolerance +/- .5 m")
xlim([min(perc_all2)-.05, max(perc_all2)+.05])
plot([ConfInt99(8, 1), ConfInt99(8, 2)], [0 0], 'r', 'LineWidth', 2)
plot([ConfInt95(8, 1), ConfInt95(8, 2)], [.01 .01], 'g', 'LineWidth', 2)
hold off
