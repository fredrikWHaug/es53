%% ENG-SCI 53 Lab 3
% Filename: es53_lab4_laf.m
% Author: Abby Yoon, Lydia, Lydia Shimelis, Fredrik Willumsen Haug
% Created: October 14th 
% Description: Blood Pressure and Blood Flow
%%

%% Figure 1
% load data and define samplerate 
fredrik = load('fredrik_ex2.mat');
sr = fredrik.samplerate(1);

% fredrik blood pressure and pulse data
fredrik_blood_pressure = fredrik.data(fredrik.datastart(1, 1) : fredrik.dataend(1, 1));
fredrik_pulse = fredrik.data(fredrik.datastart(2, 1) : fredrik.dataend(2, 1));
timef = (0 : length(fredrik_blood_pressure)-1);

% plots within a 1x2 subplot
figure(1);
hold on
subplot(2, 1, 1);
plot(timef / sr, fredrik_blood_pressure);
xlabel("Time (s)");
ylabel("Blood Pressure (mmHG)");
hold off

figure(1);
hold on
subplot(2, 1, 2);
plot(timef / sr, fredrik_pulse);
title("Fredrik Pulse");
xlabel("Time (s)");
ylabel("Pulse Wave Magnitude");
hold off
%%

%% Figure 2
% load data and define samplerate 
abby = load('abby_ex2.mat');
sr = abby.samplerate(1);

% specific blood pressure and pulse data based on channels and blocks
abby_blood_pressure = abby.data(abby.datastart(1, 1) : abby.dataend(1, 1));
abby_pulse = abby.data(abby.datastart(2, 1) : abby.dataend(2, 1));
timea = (0 : length(abby_blood_pressure)-1);

% plots within a 1x2 subplot
figure(2);
hold on
subplot(2, 1, 1);
plot(timea / sr, abby_blood_pressure);
xlabel("Time (s)");
ylabel("Blood Pressure (mmHG)");
hold off

figure(2);
hold on
subplot(2, 1, 2);
plot(timea / sr, abby_pulse);
xlabel("Time (s)");
ylabel("Pulse Wave Magnitude");
hold off
%%

%% Figure 3
% load data and define samplerate 
lydia = load('lydia_ex2.mat');
sr = lydia.samplerate(1);

% specific blood pressure and pulse data based on channels and blocks
lydia_blood_pressure = lydia.data(lydia.datastart(1, 1) : lydia.dataend(1, 1));
lydia_pulse = lydia.data(lydia.datastart(2, 1) : lydia.dataend(2, 1));
timel = (0 : length(lydia_blood_pressure)-1);

% plots within a 1x2 subplot
figure(3);
hold on
subplot(2, 1, 1);
plot(timel / sr, lydia_blood_pressure );
xlabel("Time (s)");
ylabel("Blood Pressure (mmHG)");
hold off

figure(3);
hold on
subplot(2, 1, 2);
plot(timel / sr, lydia_pulse);
xlabel("Time (s)");
ylabel("Pulse Wave Magnitude");
hold off
%%

%% Blood Pressure Extraction Based on Korotkoff sound start / end
% section load in case it's helpful
% fredrik = load('fredrik_ex2.mat');
% abby = load('abby_ex2.mat');
% lydia = load('lydia_ex2.mat');

% fredrik blood pressure and mean arterial pressure
fredrik_systolic = fredrik.data(fredrik.com(1, 3));
fredrik_diastolic = fredrik.data(fredrik.com(2, 3));
fredrik_bp_value = fredrik_systolic / fredrik_diastolic;
fredrik_map = ((2/3) * fredrik_diastolic) + ((1/3) * fredrik_systolic);

% abby blood pressure and mean arterial pressure
abby_systolic = abby.data(abby.com(1, 3));
abby_diastolic = abby.data(abby.com(2, 3));
abby_bp_value = abby_systolic / abby_diastolic;
abby_map = ((2/3) * abby_diastolic) + ((1/3) * abby_systolic);

% lydia blood pressure and mean arterial pressure
lydia_systolic = abby.data(lydia.com(1, 3));
lydia_diastolic = fredrik.data(lydia.com(2, 3));
lydia_bp_value = lydia_systolic / lydia_diastolic;
lydia_map = ((2/3) * lydia_diastolic) + ((1/3) * lydia_systolic);

% mean and std of digital group mean arterial pressures
group_map = [fredrik_map, abby_map, lydia_map];
mean_group_map = mean(group_map);
std_group_map = std(group_map);
%%

%% Figure 4

% section load in case it's helpful
% fredrik = load('fredrik_ex2.mat');
% abby = load('abby_ex2.mat');
% lydia = load('lydia_ex2.mat');

% samplerate declaration
S = fredrik.samplerate(1);

% pulse for each subject
fredrik_pulse = fredrik.data(fredrik.datastart(2, 1) : fredrik.dataend(2, 1));
abby_pulse = abby.data(abby.datastart(2, 1) : abby.dataend(2, 1));
lydia_pulse = lydia.data(lydia.datastart(2, 1) : lydia.dataend(2, 1));

% fredrik peaks
e20_1 = fredrik_pulse / max(fredrik_pulse);
de20_1 = diff(e20_1); % derivative of this vector
threshold = 0; % peak treshold
ind_1 = find((e20_1(2:end-1)>threshold)&(de20_1(1:end-1)>0)&(de20_1(2:end)<0))+1; % the indices of all peaks in the first 20 second segment

% abby peaks
e20_abby = abby_pulse / max(abby_pulse);
de20_abby = diff(e20_abby); % derivative of this vector
threshold = 0; % peak treshold
ind_1 = find((e20_abby(2:end-1)>threshold)&(de20_abby(1:end-1)>0)&(de20_abby(2:end)<0))+1; % the indices of all peaks in the first 20 second segment

% abby peaks
e20_lydia = lydia_pulse / max(lydia_pulse);
de20_lydia = diff(e20_lydia); % derivative of this vector
threshold = 0; % peak treshold
ind_1 = find((e20_lydia(2:end-1)>threshold)&(de20_lydia(1:end-1)>0)&(de20_lydia(2:end)<0))+1; % the indices of all peaks in the first 20 second segment

% fredrik plot
time_1 = (1:length(e20_1))/S;
figure(4);
subplot(3, 1, 1);
plot(time_1, e20_1);
hold on
xlabel('time (s)');
ylabel('Pulse Wave Magnitude');
axis([0 10 -1.1 1.1]);
MPH = threshold;
MPD = S/2;
[~,locs_Rwave_s1] = findpeaks(e20_1,'MinPeakHeight',MPH,'MinPeakDistance',MPD);
plot(time_1(locs_Rwave_s1), e20_1(locs_Rwave_s1),'r*');
hold off

% abby plot
timea = (1:length(e20_abby))/S;
figure(4);
subplot(3, 1, 2);
plot(timea, e20_abby);
hold on
xlabel('time (s)');
ylabel('Pulse Wave Magnitude');
axis([0 10 -1.1 1.1]);
MPH = threshold;
MPD = S/2;
[~,locs_Rwave_s2] = findpeaks(e20_abby,'MinPeakHeight',MPH,'MinPeakDistance',MPD);
plot(timea(locs_Rwave_s2), e20_abby(locs_Rwave_s2),'r*');
hold off

% lydia plot
timel = (1:length(e20_lydia))/S;
figure(4);
subplot(3, 1, 3);
plot(timel, e20_lydia);
hold on
xlabel('Time (s)');
ylabel('Pulse Wave Magnitude');
axis([0 10 -1.1 1.1]);
MPH = threshold;
MPD = S/2;
[~,locs_Rwave_s3] = findpeaks(e20_lydia,'MinPeakHeight',MPH,'MinPeakDistance',MPD);
plot(timel(locs_Rwave_s3), e20_lydia(locs_Rwave_s3),'r*');
hold off
%%
