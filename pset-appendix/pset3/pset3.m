%% Code for ENG-SCI 53 Problem Set 3: ECG Data
% Filename: Problem Set 3
% Author: Fredrik Willumsen Haug
% Creaed: September 28th, 2023
% Last Edited: September 3rd, 2023
% Description: Problem Set 2
%%

%% (APPENDIX) MATLAB Output
% load data as struct
heart = load('ECGdata.mat');

figure(1);
plot(heart.ptime, heart.pdata);
xlabel('Time (t)');
ylabel('Unsmoothed ECG Data');

% declare subplot and plot pdata with no smoothing
figure(2);
subplot(2, 2, 1);
plot(ptime, pdata);
title('no smoothing');
xlabel('Time (t)');
ylabel('ECG data');

% declare smoothed variable wih span of 10 points and plot
smoothed_heart_10 = smooth(heart.pdata, 10);
subplot(2, 2, 2);
plot(ptime, smoothed_heart_10);
title('smoothed span=10');
xlabel('Time (t)');
ylabel('ECG data'); % with this smoothing we see an improvement in
                    % interpretability by smoothing the curve


% declare smoothed variable wih span of 100 points and plot
smoothed_heart_100 = smooth(heart.pdata, 100);
subplot(2, 2, 3);
plot(ptime, smoothed_heart_100);
title('smoothed span=100');
xlabel('Time (t)');
ylabel('ECG data'); % Now it actually seems more difficult to interpret 
                    % the ECG signal. Peraps there is such a thing as
                    % 'oversmoothing' ? 

% declare smoothed variable wih span of 1000 points and plot
smoothed_heart_1000 = smooth(heart.pdata, 1000);
subplot(2, 2, 4);
plot(ptime, smoothed_heart_1000);
title('smoothed span=1000')
xlabel('Time (t)');
ylabel('ECG data'); % with a span of 1000 it is clearly more difficult to 
                    % see the relevant information from the ECG

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

% final plot
figure(3);
hold on
plot(heart.ptime, best)
scatter(heart.ptime(indices_desired_peaks), best(indices_desired_peaks), 's', 'filled', 'MarkerFaceColor', 'yellow');
scatter(heart.ptime(indices_deisred_troughs), best(indices_deisred_troughs), 's', 'filled', 'MarkerFaceColor', 'yellow');
ylabel("ECG Data");
xlabel("Time (t)");
legend("ECG Data", "Peaks", "Troughs"); % Updated legend entries
hold off
%%