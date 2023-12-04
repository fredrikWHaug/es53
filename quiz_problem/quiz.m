
%% Load and Plot
clear all, close all
% load data
subject = load('respiratorydata.mat');
sample_rate = subject.samplerate(1);

% extracting 200 seconds of breath data and pulse data
subject_breath = subject.data(subject.datastart(1, 1) : subject.datastart(1, 1) + 200 * sample_rate);
subject_pulse = subject.data(subject.datastart(2, 1) : subject.datastart(2, 1) + 200 * sample_rate);

% time vectors for both breath and pulse
time_breath = (0 : length(subject_breath) - 1) / sample_rate;
time_pulse = (0 : length(subject_pulse) - 1) / sample_rate;
%%

%% Peaks
% peak finding part 1
peak_1_data = subject.data(subject.datastart(1, 1) : subject.datastart(1, 1) + 120 * sample_rate);
e_1 = peak_1_data;
de_1 = diff(e_1); % derivative of this vector
threshold = 10.5; % visual peak treshold
time_1 = (1:length(e_1)) / sample_rate;
MPH = threshold;
MPD = 2 * sample_rate;
[~,peaks_1] = findpeaks(e_1,'MinPeakHeight',MPH,'MinPeakDistance',MPD);

% peak finding part 2
peak_2_data = subject.data(subject.datastart(1, 1) + (168 * sample_rate) : subject.datastart(1, 1) + (200 * sample_rate));
e_2 = peak_2_data;
de_2 = diff(e_2); % derivative of this vector
threshold = 13; % visual peak treshold
time_2 = (1:length(e_2)) / sample_rate;
MPH = threshold;
MPD = 3 * sample_rate;
[~,peaks_2] = findpeaks(e_2,'MinPeakHeight',MPH,'MinPeakDistance',MPD);
%%

%% Troughs
% trough finding part 1
trough_1_data = peak_1_data * -1;
e_trough = trough_1_data;
de_trough = diff(e_trough); % derivative of this vector
threshold = -10.5; % visual trough (peak for inverted) treshold  
time_trough = (1:length(e_trough)) / sample_rate;
MPH = threshold;
MPD = 2 * sample_rate;
[~, trough_peaks] = findpeaks(e_trough,'MinPeakHeight',MPH,'MinPeakDistance',MPD);
%%

%% Plot
% plot
figure(1);
subplot(2, 1, 1);
plot(time_breath, subject_breath, 'black');
hold on
plot(time_1(peaks_1), e_1(peaks_1), 'ro');
plot(123.08, 35.2746, 'ro');
plot(163.17, 28.1866, 'ro');
plot(168+(time_2(peaks_2)), e_2(peaks_2), 'ro');
plot(time_trough(trough_peaks), -1*e_trough(trough_peaks),'c*');
plot(150.86, 26.4678, 'c*');
hold off
xlabel('Time (s)');
ylabel('Lung expansion (a.u)');

subplot(2, 1, 2);
plot(time_pulse, subject_pulse, 'black');
xlabel('Time (s)');
ylabel('Pulse (a. u)');
%%
