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

% benji breathing rate
benji_breathing_rate = length(benji_breath_peaks);
benji_breathing_rate
%%
