
% load data as struct
heart = load('ECGdata.mat');

% declare subplot and plot pdata with no smoothing
subplot(2, 2, 1);
plot(ptime, pdata);
title('no smoothing');
xlabel('Time');
ylabel('ECG data');

% declare smoothed variable wih span of 10 points and plot
smoothed_heart_10 = smooth(heart.pdata, 10);
subplot(2, 2, 2);
plot(ptime, smoothed_heart_10);
title('smoothed span=10');
xlabel('Time');
ylabel('ECG data');

% declare smoothed variable wih span of 100 points and plot
smoothed_heart_100 = smooth(heart.pdata, 100);
subplot(2, 2, 3);
plot(ptime, smoothed_heart_100);
title('smoothed span=100');
xlabel('Time');
ylabel('ECG data');

% declare smoothed variable wih span of 1000 points and plot
smoothed_heart_1000 = smooth(heart.pdata, 1000);
subplot(2, 2, 4);
plot(ptime, smoothed_heart_1000);
title('smoothed span=1000')
xlabel('Time');
ylabel('ECG data');

