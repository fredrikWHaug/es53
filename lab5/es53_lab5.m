%% ENG-SCI 53 Lab 5
% Filename: es53_lab5.m
% Author: Chris Kim, Benjamin Brenner, Fredrik Willumsen Haug
% Created: November 4th
% Description: ECG and Blood Volume Pulse
%%

%% Figure 1
% load data from all subjects
benji = load('es53_lab5_benji.mat');
chris = load('es53_lab5_chris.mat');
fredrik = load('es53_lab5_fredrik.mat');

sample_rate = benji.samplerate(1);

% benji
% benji is block 4 because we also calibrated the equipment on his recording
% selecting data from relevant channel and block
benji_flow = benji.data(benji.datastart(1, 4) : benji.dataend(1, 4));
benji_volume = benji.data(benji.datastart(2, 4) : benji.dataend(2, 4));

% time vectors for both flow and volume
time_benji_flow = (0 : length(benji_flow) - 1) / sample_rate;
time_benji_volume = (0 : length(benji_volume) - 1) / sample_rate;

% integral of flow using cumtrapz for estimating volume vs time
benji_integrated_flow = cumtrapz(benji_flow) / sample_rate;

% chris
% selecting data from relevant channel and block
chris_flow = chris.data(chris.datastart(1, 1) : chris.dataend(1, 1));
chris_volume = chris.data(chris.datastart(2, 1) : chris.dataend(2, 1));

% time vectors for both flow and volume
time_chris_flow = (0 : length(chris_flow) - 1) / sample_rate;
time_chris_volume = (0 : length(chris_volume) - 1) / sample_rate;

% integral of flow using cumtrapz for estimating volume vs time
chris_integrated_flow = cumtrapz(chris_flow) / sample_rate;

% selecting data from relevant channel and block
% specifying end for estetics because recording lasted longer than data 
% collection
fredrik_flow = fredrik.data(fredrik.datastart(1, 1) : fredrik.datastart(1, 1) + (80 * sample_rate));
fredrik_volume = fredrik.data(fredrik.datastart(2, 1) : fredrik.datastart(2, 1) + (80 * sample_rate));

% time vectors for both flow and volume
time_fredrik_flow = (0 : length(fredrik_flow) - 1) / sample_rate;
time_fredrik_volume = (0 : length(fredrik_volume) - 1) / sample_rate;

% integral of flow using cumtrapz for estimating volume vs time
fredrik_integrated_flow = cumtrapz(fredrik_flow) / sample_rate;

% entire subplot for all six plots
figure(1);
subplot(3, 2, 1);
hold on
plot(time_benji_flow, benji_flow);
xlabel('Time (s)');
ylabel('Flow (L/s)');

subplot(3, 2, 2);
plot(time_benji_volume, benji_volume, 'r');
hold on
plot(time_benji_flow, benji_integrated_flow, 'b');
hold off
xlabel('Time (s)');
ylabel('Volume (L)');

subplot(3, 2, 3);
plot(time_chris_flow, chris_flow);
xlabel('Time (s)');
ylabel('Flow (L/s)');

subplot(3, 2, 4);
plot(time_chris_volume, chris_volume, 'r');
hold on
plot(time_chris_flow, chris_integrated_flow, 'b');
hold off
xlabel('Time (s)');
ylabel('Volume (L)');

subplot(3, 2, 5);
plot(time_fredrik_flow, fredrik_flow);
xlabel('Time (s)');
ylabel('Flow (L/s)');

subplot(3, 2, 6);
plot(time_fredrik_volume, fredrik_volume, 'r');
hold on
plot(time_fredrik_flow, fredrik_integrated_flow, 'b');
hold off
xlabel('Time (s)');
ylabel('Volume (L)');
hold off
%%

%% Flow integration sanity check
benji_flow_volume_difference_mean = abs(mean(benji_volume - benji_integrated_flow))
chris_flow_volume_difference_mean = abs(mean(chris_volume - chris_integrated_flow))
fredrik_flow_volume_difference_mean = abs(mean(fredrik_volume - fredrik_integrated_flow))
%%

%% Respiratory Rate

% 60 second data load for ease of calculation
benji_volume_60 = benji.data(benji.datastart(2, 4) : benji.datastart(2, 4) + (60 * sample_rate));
chris_volume_60 = chris.data(chris.datastart(2, 1) : chris.datastart(2, 1) + (60 * sample_rate));
fredrik_volume_60 = fredrik.data(fredrik.datastart(2, 1) : fredrik.datastart(2, 1) + (60 * sample_rate));

% peak finding benji
% benji
e_benji = benji_volume_60 / max(benji_volume_60);
de_benji = diff(e_benji); % derivative of this vector
threshold = 0.5; % empirical peak treshold
ind_benji = find((e_benji(2:end-1)>threshold)&(de_benji(1:end-1)>0)&(de_benji(2:end)<0))+1;

% plot
time_benji = (1:length(e_benji))/sample_rate;
figure(2);
plot(time_benji, e_benji);
hold on
axis([0 10 -1.1 1.1]);
MPH = threshold;
MPD = 2 * sample_rate;
[~,benji_volume_peaks] = findpeaks(e_benji,'MinPeakHeight',MPH,'MinPeakDistance',MPD);
plot(time_benji(benji_volume_peaks), e_benji(benji_volume_peaks),'r*');
hold off

% peak finding chris
e_chris = chris_volume_60 / max(chris_volume_60);
de_chris = diff(e_chris); % derivative of this vector
threshold = -12; % empirical peak treshold
ind_chris = find((e_chris(2:end-1)>threshold)&(de_chris(1:end-1)>0)&(de_chris(2:end)<0))+1;

% plot
time_chris = (1:length(e_chris))/sample_rate;
figure(3);
plot(time_chris, e_chris);
hold on
axis([0 10 -1.1 1.1]);
MPH = threshold;
MPD = 2 * sample_rate;
[~,chris_volume_peaks] = findpeaks(e_chris,'MinPeakHeight',MPH,'MinPeakDistance',MPD);
plot(time_chris(chris_volume_peaks), e_chris(chris_volume_peaks),'r*');
hold off

% peak finding fredrik
e_fredrik = fredrik_volume_60 / max(fredrik_volume_60);
de_fredrik = diff(e_fredrik); % derivative of this vector
threshold = -2; % empirical peak treshold
ind_fredrik = find((e_fredrik(2:end-1)>threshold)&(de_fredrik(1:end-1)>0)&(de_fredrik(2:end)<0))+1;

% plot
time_fredrik = (1:length(e_fredrik))/sample_rate;
figure(4);
plot(time_fredrik, e_fredrik);
hold on
axis([0 10 -1.1 1.1]);
MPH = threshold;
MPD = 2 * sample_rate;
[~,fredrik_volume_peaks] = findpeaks(e_fredrik,'MinPeakHeight',MPH,'MinPeakDistance',MPD);
plot(time_fredrik(fredrik_volume_peaks), e_fredrik(fredrik_volume_peaks),'r*');
hold off

% resperatory rates
benji_respiratory_rate = length(benji_volume_peaks)
chris_respiratory_rate = length(chris_volume_peaks)
fredrik_respiratory_rate = length(fredrik_volume_peaks)

% mean and standard deviation for respiratory rate
group_values = [benji_respiratory_rate, chris_respiratory_rate, fredrik_respiratory_rate];
mean_group_values = mean(group_values)
std_group_values = std(group_values)
%%

%% Tidal Inspiration
% peak indices for benji
benji_volume = benji.data(benji.datastart(2, 4) : benji.dataend(2, 4));
e20_benji = benji_volume / max(benji_volume);
de20_benji = diff(e20_benji); % derivative of this vector
threshold = 0.1; % emperically determined peak treshold
ind_benji = find((e20_benji(2:end-1)>threshold)&(de20_benji(1:end-1)>0)&(de20_benji(2:end)<0))+1;
time_benji = (1:length(e20_benji))/sample_rate;
figure(5);
plot(time_benji, e20_benji);
hold on
axis([0 10 -1.1 1.1]);
MPH = threshold;
MPD = 7 * sample_rate;
[~,benji_top_peaks] = findpeaks(e20_benji,'MinPeakHeight',MPH,'MinPeakDistance',MPD);
plot(time_benji(benji_top_peaks), e20_benji(benji_top_peaks),'r*');
hold off

% bottom peak indices for benji
benji_trough = benji_volume * -1;
e20_benji_trough = benji_trough / max(benji_trough);
de20_benji_trough = diff(e20_benji_trough); % derivative of this vector
threshold = 0; % peak treshold
ind_benji_trough = find((e20_benji_trough(2:end-1)>threshold)&(de20_benji_trough(1:end-1)>0)&(de20_benji_trough(2:end)<0))+1;
time_benji_trough = (1:length(e20_benji_trough))/sample_rate;
figure(6);
plot(time_benji_trough, e20_benji_trough);
hold on
MPH = threshold;
MPD = 7 * sample_rate;
[~,benji_trough_peaks] = findpeaks(e20_benji_trough,'MinPeakHeight',MPH,'MinPeakDistance',MPD);
plot(time_benji_trough(benji_trough_peaks), e20_benji_trough(benji_trough_peaks),'r*');
axis([0 10 -1.1 1.1]);
hold off

% peak indices for benji
benji_volume = benji.data(benji.datastart(2, 4) : benji.dataend(2, 4));
e20_benji = benji_volume / max(benji_volume);
de20_benji = diff(e20_benji); % derivative of this vector
threshold = 0.1; % emperically determined peak treshold
ind_benji = find((e20_benji(2:end-1)>threshold)&(de20_benji(1:end-1)>0)&(de20_benji(2:end)<0))+1;
time_benji = (1:length(e20_benji))/sample_rate;
figure(5);
plot(time_benji, e20_benji);
hold on
axis([0 10 -1.1 1.1]);
MPH = threshold;
MPD = 7 * sample_rate;
[~,benji_top_peaks] = findpeaks(e20_benji,'MinPeakHeight',MPH,'MinPeakDistance',MPD);
plot(time_benji(benji_top_peaks), e20_benji(benji_top_peaks),'r*');
hold off

% bottom peak indices for benji
benji_trough = benji_volume * -1;
e20_benji_trough = benji_trough / max(benji_trough);
de20_benji_trough = diff(e20_benji_trough); % derivative of this vector
threshold = 0; % peak treshold
ind_benji_trough = find((e20_benji_trough(2:end-1)>threshold)&(de20_benji_trough(1:end-1)>0)&(de20_benji_trough(2:end)<0))+1;
time_benji_trough = (1:length(e20_benji_trough))/sample_rate;
figure(6);
plot(time_benji_trough, e20_benji_trough);
hold on
MPH = threshold;
MPD = 7 * sample_rate;
[~,benji_trough_peaks] = findpeaks(e20_benji_trough,'MinPeakHeight',MPH,'MinPeakDistance',MPD);
plot(time_benji_trough(benji_trough_peaks), e20_benji_trough(benji_trough_peaks),'r*');
axis([0 10 -1.1 1.1]);
hold off

benji_troughs = benji_volume(benji_trough_peaks);
benji_tops = benji_volume(benji_top_peaks);
benji_tidal_volume = benji_tops - benji_troughs;
mean_tv_benji = mean(tidal_volume_benji);
%%

%% IRV
% benji IRV
benji_normal_inhale = benji_volume(benji_top_peak(1)); % take average and subt
benji_max_inhale = max(benji_volume);
benji_IRV = benji_max_inhale - benji_normal_inhale;

benji_normal_exhale = abs(benji_volume(benji_bottom_peak(1)));
benji_max_exhale = abs(min(benji_volume));
benji_ERV = benji_max_exhale - benji_normal_exhale;
%%
