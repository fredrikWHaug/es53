%% ENG-SCI 53 Lab 6
% Filename: es53_lab6.m
% Author: Chris Kim, Benjamin Brenner, Fredrik Willumsen Haug
% Created: November 10th
% Description: Respiration II: Hyperventilation, Rebreathing and Oxygen Saturation
%%

%% Figure 1
% load data from all group subjects
benji = load('Lab6_Benji_Ex1-3.mat');
chris = load('Lab6_Chris_Ex1-3.mat');
fredrik = load('Lab6_Fredrik_Ex1-3.mat');

sample_rate = benji.samplerate(1);

% benji
% 60 seconds normal breathing
benji_normal_breathing = benji.data(benji.datastart(1, 1) : benji.datastart(1, 1) + (60 * sample_rate));
time_benji_normal = (0 : length(benji_normal_breathing) - 1) / sample_rate;

% 60 seconds inhale hold
benji_inhale_hold = benji.data(benji.com(2, 3) : benji.com(3, 3));
time_benji_inhale_hold = (0 : length(benji_inhale_hold) - 1) / sample_rate;

% 60 seconds exhale hold
benji_exhale_hold = benji.data(benji.com(4, 3) - (10 * sample_rate) : benji.com(5, 3) + (25 * sample_rate));
time_benji_exhale_hold = (0 : length(benji_exhale_hold) - 1) / sample_rate;

% chris
% 60 seconds normal breathing
chris_normal_breathing = chris.data(chris.datastart(1, 1) : chris.datastart(1, 1) + (60 * sample_rate));
time_chris_normal = (0 : length(chris_normal_breathing) - 1) / sample_rate;

% 60 seconds inhale hold
chris_inhale_hold = chris.data(chris.com(2, 3) : chris.com(3, 3) - (100 * sample_rate));
time_chris_inhale_hold = (0 : length(chris_inhale_hold) - 1) / sample_rate;

% 60 seconds exhale hold
chris_exhale_hold = chris.data(chris.com(4, 3) - (10 * sample_rate) : chris.com(5, 3) - (40 * sample_rate));
time_chris_exhale_hold = (0 : length(chris_exhale_hold) - 1) / sample_rate;

% fredrik
% 60 seconds normal breathing
fredrik_normal_breathing = fredrik.data(fredrik.datastart(1, 1) : fredrik.datastart(1, 1) + (60 * sample_rate));
time_fredrik_normal = (0 : length(fredrik_normal_breathing) - 1) / sample_rate;

% 60 seconds inhale hold
fredrik_inhale_hold = fredrik.data(fredrik.com(1, 3) : fredrik.com(2, 3) - (30 * sample_rate));
time_fredrik_inhale_hold = (0 : length(fredrik_inhale_hold) - 1) / sample_rate;

% 60 seconds exhale hold
fredrik_exhale_hold = fredrik.data(fredrik.com(3, 3) - (10 * sample_rate) : fredrik.com(4, 3));
time_fredrik_exhale_hold = (0 : length(fredrik_exhale_hold) - 1) / sample_rate;

% all nine plots in order of person
% benji plots (column 1)
subplot(3, 3, 1);
plot(time_benji_normal, benji_normal_breathing);
xlabel('Time (s)');
ylabel('Voltage (mV)');

subplot(3, 3, 4);
plot(time_benji_inhale_hold, benji_inhale_hold);
xlabel('Time (s)');
ylabel('Voltage (mV)');

subplot(3, 3, 7);
plot(time_benji_exhale_hold, benji_exhale_hold);
xlabel('Time (s)');
ylabel('Voltage (mV)');

% chris plots (column 2)
subplot(3, 3, 2);
plot(time_chris_normal, chris_normal_breathing);
xlabel('Time (s)');
ylabel('Voltage (mV)');

subplot(3, 3, 5);
plot(time_chris_inhale_hold, chris_inhale_hold);
xlabel('Time (s)');
ylabel('Voltage (mV)');

subplot(3, 3, 8);
plot(time_chris_exhale_hold, chris_exhale_hold);
xlabel('Time (s)');
ylabel('Voltage (mV)');

% fredrik plots (column 3)
subplot(3, 3, 3);
plot(time_fredrik_normal, fredrik_normal_breathing);
xlabel('Time (s)');
ylabel('Voltage (mV)');

subplot(3, 3, 6);
plot(time_fredrik_inhale_hold, fredrik_inhale_hold);
xlabel('Time (s)');
ylabel('Voltage (mV)');

subplot(3, 3, 9);
plot(time_fredrik_exhale_hold, fredrik_exhale_hold);
xlabel('Time (s)');
ylabel('Voltage (mV)');
%%

%% Average Breathing Rate
% attempt to use the code Daniel suggested
% [pks, locs] = findpeaks(benji_normal_breathing);
% time_benji = time_benji_normal(locs);
% time_interval = diff(time_benji);
% breathing_rate = 1 ./ time_interval * sample_rate;
% mean_breathing_rate = mean(breathing_rate);

% average breathing rate
% peak finding benji
e_benji = benji_normal_breathing / max(benji_normal_breathing); % normalize
de_benji = diff(e_benji); % derivative of this vector
threshold = 0.8; % treshold due to normalization
MPH = threshold;
MPD = 5 * sample_rate;
[~,benji_breath_peaks] = findpeaks(e_benji,'MinPeakHeight',MPH,'MinPeakDistance',MPD);

% peak finding chris
e_chris = chris_normal_breathing / max(chris_normal_breathing); % normalize
de_chris = diff(e_chris); % derivative of this vector
threshold = 0.8; % treshold due to normalization
MPH = threshold;
MPD = 5 * sample_rate;
[~,chris_breath_peaks] = findpeaks(e_chris,'MinPeakHeight',MPH,'MinPeakDistance',MPD);

% peak finding fredrik
e_fredrik = fredrik_normal_breathing / max(fredrik_normal_breathing); % normalize
de_fredrik = diff(e_fredrik); % derivative of this vector
threshold = 0.8; % treshold due to normalization
MPH = threshold;
MPD = 5 * sample_rate;
[~,fredrik_breath_peaks] = findpeaks(e_fredrik,'MinPeakHeight',MPH,'MinPeakDistance',MPD);

% group breathing rates
benji_breathing_rate = length(benji_breath_peaks);
chris_breathing_rate = length(chris_breath_peaks);
fredrik_breathing_rate = length(fredrik_breath_peaks);

benji_breathing_rate
chris_breathing_rate
fredrik_breathing_rate
%%

%% Average Heart Rate
% benji pulse data
% 60 seconds normal breathing pulse
benji_normal_pulse = benji.data(benji.datastart(2, 1) : benji.datastart(2, 1) + (60 * sample_rate));

% 60 seconds inhale hold
benji_inhale_hold = benji.data(benji.com(2, 3) : benji.com(3, 3));

% 60 seconds exhale hold
benji_exhale_hold = benji.data(benji.com(4, 3) - (10 * sample_rate) : benji.com(5, 3) + (25 * sample_rate));

% chris pulse data
% chris pulse data for normal breathing
chris_normal_pulse = chris.data(chris.datastart(2, 1) : chris.datastart(2, 1) + (60 * sample_rate));

% 60 seconds inhale hold
chris_inhale_hold = chris.data(chris.com(2, 3) : chris.com(3, 3) - (100 * sample_rate));

% fredrik pulse data for normal breathing
fredrik_normal_pulse = fredrik.data(fredrik.datastart(2, 1) : fredrik.datastart(2, 1) + (60 * sample_rate));

% peak finding benji
% benji
e_benji = benji_normal_pulse / max(benji_normal_pulse);
de_benji = diff(e_benji); % derivative of this vector
threshold = 0.3; % empirical peak treshold
ind_benji = find((e_benji(2:end-1)>threshold)&(de_benji(1:end-1)>0)&(de_benji(2:end)<0))+1;

% plot
time_benji_normal = (1:length(e_benji))/sample_rate;
figure(2);
plot(time_benji_normal, e_benji);
hold on
axis([0 10 -1.1 1.1]);
MPH = threshold;
MPD = 0.5 * sample_rate;
[~,benji_normal_pulse_peaks] = findpeaks(e_benji,'MinPeakHeight',MPH,'MinPeakDistance',MPD);
plot(time_benji_normal(benji_normal_pulse_peaks), e_benji(benji_normal_pulse_peaks),'r*');
title('Benji pulse normal breathing');
hold off

% peak finding chris
% chris
e_chris = chris_normal_pulse / max(chris_normal_pulse);
de_chris = diff(e_chris); % derivative of this vector
threshold = 0.3; % empirical peak treshold
ind_chris = find((e_chris(2:end-1)>threshold)&(de_chris(1:end-1)>0)&(de_chris(2:end)<0))+1;

% plot
time_chris_normal = (1:length(e_chris))/sample_rate;
figure(3);
plot(time_chris_normal, e_chris);
hold on
axis([0 10 -1.1 1.1]);
MPH = threshold;
MPD = 0.5 * sample_rate;
[~,chris_normal_pulse_peaks] = findpeaks(e_chris,'MinPeakHeight',MPH,'MinPeakDistance',MPD);
plot(time_chris_normal(chris_normal_pulse_peaks), e_chris(chris_normal_pulse_peaks),'r*');
title('Chris pulse normal breathing');
hold off

% peak finding fredrik
% fredrik
e_fredrik = fredrik_normal_pulse / max(fredrik_normal_pulse);
de_fredrik = diff(e_fredrik); % derivative of this vector
threshold = 0.3; % empirical peak treshold
ind_fredrik = find((e_fredrik(2:end-1)>threshold)&(de_fredrik(1:end-1)>0)&(de_fredrik(2:end)<0))+1;

% plot
time_fredrik_normal = (1:length(e_fredrik))/sample_rate;
figure(4);
plot(time_fredrik_normal, e_fredrik);
hold on
axis([0 10 -1.1 1.1]);
MPH = threshold;
MPD = 0.5 * sample_rate;
[~,fredrik_normal_pulse_peaks] = findpeaks(e_fredrik,'MinPeakHeight',MPH,'MinPeakDistance',MPD);
plot(time_fredrik_normal(fredrik_normal_pulse_peaks), e_fredrik(fredrik_normal_pulse_peaks),'r*');
title('Fredrik pulse normal breathing');
hold off

benji_average_heart_rate_normal_breathing = length(benji_pulse_peaks);
chris_average_heart_rate_normal_breathing = length(chris_pulse_peaks);
fredrik_average_hear_rate_normal_breathing = length(fredrik_pulse_peaks);

benji_average_heart_rate_normal_breathing
chris_average_heart_rate_normal_breathing
fredrik_average_hear_rate_normal_breathing
%%
