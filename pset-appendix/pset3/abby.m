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

% selecting span of 30 after reccomendation from Dr. Moyer
best = smooth(heart.pdata, 30);

% derivatives and sign matrices
dy = diff(best);
sign_dy = sign(dy);
sign_diff = diff(sign_dy);

% peaks
max_treshold = 0.65 * max(best);
peaks = find(sign_diff == -2); 
data_peaks = best(peaks);
desired_peaks = find(data_peaks >= max_treshold);
indices_desired_peaks = peaks(desired_peaks);

% troughs
thresholdMin = 0.65 * min(best);
troughs = find(sign_diff == 2); % Corrected comparison operator
data_troughs = best(troughs);
desired_troughs = find(data_troughs <= thresholdMin);
indices_deisred_troughs = troughs(desired_troughs);

figure(2);
hold on
plot(heart.ptime, best)
scatter(heart.ptime(indices_desired_peaks), best(indices_desired_peaks), 's', 'filled', 'MarkerFaceColor', 'yellow');
scatter(heart.ptime(indices_deisred_troughs), best(indices_deisred_troughs), 's', 'filled', 'MarkerFaceColor', 'yellow');
ylabel("ECG Data");
xlabel("Time (t)");
legend("ECG Data", "Peaks", "Troughs"); % Updated legend entries
hold off
