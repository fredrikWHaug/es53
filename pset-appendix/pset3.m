
% load data as struct
heart = load('ECGdata.mat');

% declare subplot and plot pdata with no smoothing
figure(1);
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

% transpose the "best" ECG and transpose it to enable element-wise division
best = transpose(smoothed_heart_1000);

% define derivative of the best ECH
derivative = diff(best) ./ diff(ptime);

% get matrix of the sign of the derivativ
derivative_sign = sign(derivative);

% run diff function on derivative sign matrix to get only the points 
% on best where there is a sign change in the deriavtive
difference_sign = diff(derivative_sign);

% use find to find the indeces in the array where the sign is equal to -2
% to get the peaks because that means the sign goes from being positive
% to being negative
peak_indices = find(difference_sign == -2);
peaks = best(peak_indices); % get actual peaks on best
peak_time = ptime(peak_indices); % define time accordingly for alignment

% use find to find the indeces in the array where the sign is equal to 2
% to get the troughs because that means the sign goes from being negative
% to being positive
trough_indices = find(difference_sign == 2);
troughs = best(trough_indices); % get actual troughs on best
trough_time = ptime(trough_indices); % define time accordingly for alignment

% plot
figure(2);
hold on
plot(ptime,smoothed_heart_1000);
scatter(peak_time, peaks, 'y', 's', 'filled');
scatter(trough_time, troughs, 'y', 's', 'filled');
hold off
title('Peaks and troughs on the best ECG');
xlabel('Time');
ylabel('ECG data');