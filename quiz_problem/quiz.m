
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
p_1 = peak_1_data;
threshold = 10.5; % visual peak treshold
time_p1 = (1:length(p_1)) / sample_rate;
MPH = threshold;
MPD = 2 * sample_rate;
[~,peaks_1] = findpeaks(p_1,'MinPeakHeight',MPH,'MinPeakDistance',MPD);

% peak finding part 2
peak_2_data = subject.data(subject.datastart(1, 1) + (168 * sample_rate) : subject.datastart(1, 1) + (200 * sample_rate));
p_2 = peak_2_data;
threshold = 13; % visual peak treshold
time_p2 = (1:length(p_2)) / sample_rate;
MPH = threshold;
MPD = 3 * sample_rate;
[~,peaks_2] = findpeaks(p_2,'MinPeakHeight',MPH,'MinPeakDistance',MPD);
%%

%% Troughs
% trough finding part 1
trough_1_data = peak_1_data * -1;
t_1 = trough_1_data;
threshold = -10.5; % visual trough (peak for inverted) treshold  
time_t1 = (1:length(t_1)) / sample_rate;
MPH = threshold;
MPD = 2 * sample_rate;
[~, troughs_1] = findpeaks(t_1,'MinPeakHeight',MPH,'MinPeakDistance',MPD);

% trough finding part 2
trough_2_data = peak_2_data * -1;
t_2 = trough_2_data;
threshold = -20; % visual trough (peak for inverted) treshold  
time_t2 = (1:length(t_2)) / sample_rate;
MPH = threshold;
MPD = 2 * sample_rate;
[~, troughs_2] = findpeaks(t_2,'MinPeakHeight',MPH,'MinPeakDistance',MPD);
%%

%% Plot
% plot
figure(1);
subplot(2, 1, 1);
plot(time_breath, subject_breath, 'black');
hold on
plot(time_p1(peaks_1), p_1(peaks_1), 'ro');
plot(123.08, 35.2746, 'ro');
plot(163.17, 28.1866, 'ro');
plot(168 + (time_p2(peaks_2)), p_2(peaks_2), 'ro');

plot(time_t1(troughs_1), -1*t_1(troughs_1),'c*');
plot(150.86, 26.4678, 'c*');
plot(168 + (time_t2(troughs_2)), -1*t_2(troughs_2), 'c*');
hold off
xlabel('Time (s)');
ylabel('Lung expansion (a.u)');

subplot(2, 1, 2);
plot(time_pulse, subject_pulse, 'black');
xlabel('Time (s)');
ylabel('Pulse (a. u)');
%%
