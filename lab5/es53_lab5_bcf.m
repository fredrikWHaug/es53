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
xlabel('Time (s)');
ylabel('Volume (L)');
legend('Labchart', 'Integral');

subplot(3, 2, 3);
plot(time_chris_flow, chris_flow);
xlabel('Time (s)');
ylabel('Flow (L/s)');

subplot(3, 2, 4);
plot(time_chris_volume, chris_volume, 'r');
hold on
plot(time_chris_flow, chris_integrated_flow, 'b');
xlabel('Time (s)');
ylabel('Volume (L)');
legend('Labchart', 'Integral');

subplot(3, 2, 5);
plot(time_fredrik_flow, fredrik_flow);
xlabel('Time (s)');
ylabel('Flow (L/s)');

subplot(3, 2, 6);
plot(time_fredrik_volume, fredrik_volume, 'r');
hold on
plot(time_fredrik_flow, fredrik_integrated_flow, 'b');
xlabel('Time (s)');
ylabel('Volume (L)');
legend('Labchart', 'Integral');
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
%figure(2);
%plot(time_benji, e_benji); for reference to find treshold empirically
hold on
axis([0 10 -1.1 1.1]);
MPH = threshold;
MPD = 2 * sample_rate;
[~,benji_volume_peaks] = findpeaks(e_benji,'MinPeakHeight',MPH,'MinPeakDistance',MPD);
%plot(time_benji(benji_volume_peaks), e_benji(benji_volume_peaks),'r*'); for reference to find treshold empirically
hold off

% peak finding chris
e_chris = chris_volume_60 / max(chris_volume_60);
de_chris = diff(e_chris); % derivative of this vector
threshold = -12; % empirical peak treshold
ind_chris = find((e_chris(2:end-1)>threshold)&(de_chris(1:end-1)>0)&(de_chris(2:end)<0))+1;

% plot
time_chris = (1:length(e_chris))/sample_rate;
% figure(3);
%plot(time_chris, e_chris); for reference to find treshold empirically
hold on
axis([0 10 -1.1 1.1]);
MPH = threshold;
MPD = 2 * sample_rate;
[~,chris_volume_peaks] = findpeaks(e_chris,'MinPeakHeight',MPH,'MinPeakDistance',MPD);
% plot(time_chris(chris_volume_peaks), e_chris(chris_volume_peaks),'r*'); for reference to find treshold empirically
hold off

% peak finding fredrik
e_fredrik = fredrik_volume_60 / max(fredrik_volume_60);
de_fredrik = diff(e_fredrik); % derivative of this vector
threshold = -2; % empirical peak treshold
ind_fredrik = find((e_fredrik(2:end-1)>threshold)&(de_fredrik(1:end-1)>0)&(de_fredrik(2:end)<0))+1;

% plot
time_fredrik = (1:length(e_fredrik))/sample_rate;
% figure(4);
% plot(time_fredrik, e_fredrik); for reference to find treshold empirically
hold on
axis([0 10 -1.1 1.1]);
MPH = threshold;
MPD = 2 * sample_rate;
[~,fredrik_volume_peaks] = findpeaks(e_fredrik,'MinPeakHeight',MPH,'MinPeakDistance',MPD);
% plot(time_fredrik(fredrik_volume_peaks), e_fredrik(fredrik_volume_peaks),'r*');
% for reference to find treshold empirically
hold off

% resperatory rates
benji_respiratory_rate = length(benji_volume_peaks)
chris_respiratory_rate = length(chris_volume_peaks)
fredrik_respiratory_rate = length(fredrik_volume_peaks)

% mean and standard deviation for respiratory rate
group_values_rr = [benji_respiratory_rate, chris_respiratory_rate, fredrik_respiratory_rate];
mean_group_values_rr = mean(group_values_rr)
std_group_values_rr = std(group_values_rr)
%%

%% Tidal Inspiration
% peak indices for benji
benji_volume = benji.data(benji.datastart(2, 4) : benji.dataend(2, 4));
e20_benji = benji_volume / max(benji_volume);
de20_benji = diff(e20_benji); % derivative of this vector
threshold = 0.1; % emperically determined peak treshold
ind_benji = find((e20_benji(2:end-1)>threshold)&(de20_benji(1:end-1)>0)&(de20_benji(2:end)<0))+1;
time_benji = (1:length(e20_benji))/sample_rate;
% figure(5);
% plot(time_benji, e20_benji); for reference to find treshold empirically
hold on
axis([0 10 -1.1 1.1]);
MPH = threshold;
MPD = 7 * sample_rate;
[~,benji_top_peaks] = findpeaks(e20_benji,'MinPeakHeight',MPH,'MinPeakDistance',MPD);
% plot(time_benji(benji_top_peaks), e20_benji(benji_top_peaks),'r*');
% for reference to find treshold empirically
hold off

% bottom peak indices for benji
benji_trough = benji_volume * -1;
e20_benji_trough = benji_trough / max(benji_trough);
de20_benji_trough = diff(e20_benji_trough); % derivative of this vector
threshold = 0; % peak treshold
ind_benji_trough = find((e20_benji_trough(2:end-1)>threshold)&(de20_benji_trough(1:end-1)>0)&(de20_benji_trough(2:end)<0))+1;
time_benji_trough = (1:length(e20_benji_trough))/sample_rate;
% figure(6);
% plot(time_benji_trough, e20_benji_trough); for reference to find treshold empirically
hold on
MPH = threshold;
MPD = 7 * sample_rate;
[~,benji_trough_peaks] = findpeaks(e20_benji_trough,'MinPeakHeight',MPH,'MinPeakDistance',MPD);
% plot(time_benji_trough(benji_trough_peaks), e20_benji_trough(benji_trough_peaks),'r*');
% for reference to find treshold empirically
axis([0 10 -1.1 1.1]);
hold off

% peak indices for chris
chris_volume = chris.data(chris.datastart(2, 1) : chris.dataend(2, 1));
e20_chris = chris_volume / max(chris_volume);
de20_chris = diff(e20_chris); % derivative of this vector
threshold = -1.5; % emperically determined peak treshold
ind_chris = find((e20_chris(2:end-1)>threshold)&(de20_chris(1:end-1)>0)&(de20_chris(2:end)<0))+1;
time_chris = (1:length(e20_chris))/sample_rate;
% figure(7);
% plot(time_chris, e20_chris); for reference to find treshold empirically
hold on
axis([0 10 -1.1 1.1]);
MPH = threshold;
MPD = 3 * sample_rate;
[~,chris_top_peaks] = findpeaks(e20_chris,'MinPeakHeight',MPH,'MinPeakDistance',MPD);
% plot(time_chris(chris_top_peaks), e20_chris(chris_top_peaks),'r*');
% for reference to find treshold empirically
hold off

% trough indices for chris
chris_trough = chris_volume * -1;
e20_chris_trough = chris_trough / max(chris_trough);
de20_chris_trough = diff(e20_chris_trough); % derivative of this vector
threshold = 0.3; % peak treshold
ind_chris_trough = find((e20_chris_trough(2:end-1)>threshold)&(de20_chris_trough(1:end-1)>0)&(de20_chris_trough(2:end)<0))+1;
time_chris_trough = (1:length(e20_chris_trough))/sample_rate;
% figure(8);
% plot(time_chris_trough, e20_chris_trough); for reference to find treshold empirically
hold on
MPH = threshold;
MPD = 3 * sample_rate;
[~,chris_trough_peaks] = findpeaks(e20_chris_trough,'MinPeakHeight',MPH,'MinPeakDistance',MPD);
% plot(time_chris_trough(chris_trough_peaks), e20_chris_trough(chris_trough_peaks),'r*');
% for reference to find treshold empirically
axis([0 10 -1.1 1.1]);
hold off

% peak indices for fredrik
fredrik_volume = fredrik.data(fredrik.datastart(2, 1) : fredrik.dataend(2, 1));
e20_fredrik = fredrik_volume / max(fredrik_volume);
de20_fredrik = diff(e20_fredrik); % derivative of this vector
threshold = -3.5; % emperically determined peak treshold
ind_fredrik = find((e20_fredrik(2:end-1)>threshold)&(de20_fredrik(1:end-1)>0)&(de20_fredrik(2:end)<0))+1;
time_fredrik = (1:length(e20_fredrik))/sample_rate;
% figure(9);
% plot(time_fredrik, e20_fredrik); for reference to find treshold empirically
hold on
axis([0 10 -1.1 1.1]);
MPH = threshold;
MPD = 3 * sample_rate;
[~,fredrik_top_peaks] = findpeaks(e20_fredrik,'MinPeakHeight',MPH,'MinPeakDistance',MPD);
% plot(time_fredrik(fredrik_top_peaks), e20_fredrik(fredrik_top_peaks),'r*');
% for reference to find treshold empirically
hold off

% trough indices for fredrik
fredrik_trough = fredrik_volume * -1;
e20_fredrik_trough = fredrik_trough / max(fredrik_trough);
de20_fredrik_trough = diff(e20_fredrik_trough); % derivative of this vector
threshold = -0.15; % peak treshold
ind_fredrik_trough = find((e20_fredrik_trough(2:end-1)>threshold)&(de20_fredrik_trough(1:end-1)>0)&(de20_fredrik_trough(2:end)<0))+1;
time_fredrik_trough = (1:length(e20_fredrik_trough))/sample_rate;
% figure(10);
% plot(time_fredrik_trough, e20_fredrik_trough); for reference to find treshold empirically
hold on
MPH = threshold;
MPD = 3.5 * sample_rate;
[~,fredrik_trough_peaks] = findpeaks(e20_fredrik_trough,'MinPeakHeight',MPH,'MinPeakDistance',MPD);
% plot(time_fredrik_trough(fredrik_trough_peaks), e20_fredrik_trough(fredrik_trough_peaks),'r*');
% for reference to find treshold empirically
axis([0 10 -1.1 1.1]);
hold off

benji_troughs = benji_volume(benji_trough_peaks);
benji_tops = benji_volume(benji_top_peaks);
benji_tidal_volume = benji_tops - benji_troughs;
benji_mean_tidal_volume = mean(benji_tidal_volume)

chris_troughs = chris_volume(chris_trough_peaks);
chris_tops = chris_volume(chris_top_peaks);
chris_tidal_volume = chris_tops - chris_troughs;
chris_mean_tidal_volume = mean(chris_tidal_volume)

fredrik_troughs = fredrik_volume(fredrik_trough_peaks);
fredrik_tops = fredrik_volume(fredrik_top_peaks);
fredrik_tidal_volume = fredrik_tops - fredrik_troughs;
fredrik_mean_tidal_volume = mean(fredrik_tidal_volume)

group_tidal_volumes = [benji_mean_tidal_volume, chris_mean_tidal_volume, fredrik_mean_tidal_volume];
group_mean_tidal_volumes = mean(group_tidal_volumes)
group_std_tidal_volumes = std(group_tidal_volumes)
%%

%% IRV
% benji IRV
benji_normal_inhale = mean(benji_tops);
benji_max_inhale = max(benji_volume);
benji_IRV = benji_max_inhale - benji_normal_inhale

% benji ERV
benji_normal_exhale = abs(mean(benji_troughs));
benji_max_exhale = abs(min(benji_volume));
benji_ERV = benji_max_exhale - benji_normal_exhale

% chris IRV
chris_normal_inhale = mean(chris_tops);
chris_max_inhale = max(chris_volume);
chris_IRV = chris_max_inhale - chris_normal_inhale

% chris ERV
chris_normal_exhale = abs(mean(chris_troughs));
chris_max_exhale = abs(min(chris_volume));
chris_ERV = chris_max_exhale - chris_normal_exhale

% fredrik IRV
fredrik_normal_inhale = fredrik_tops(9);
fredrik_max_inhale = max(fredrik_volume);
fredrik_IRV = fredrik_max_inhale - fredrik_normal_inhale

% fredrik ERV
fredrik_normal_exhale = abs(fredrik_troughs(9));
fredrik_max_exhale = abs(min(fredrik_volume));
fredrik_ERV = fredrik_max_exhale - fredrik_normal_exhale

group_IRV = [benji_IRV, chris_IRV, fredrik_IRV];
group_mean_IRV = mean(group_IRV)
group_std_IRV = std(group_IRV)

group_ERV = [benji_ERV, chris_ERV, fredrik_ERV];
group_mean_ERV = mean(group_ERV)
group_std_ERV = std(group_ERV)
%%

%% VE
benji_VE = benji_respiratory_rate + benji_mean_tidal_volume
chris_VE = chris_respiratory_rate + chris_mean_tidal_volume
fredrik_VE = fredrik_respiratory_rate + fredrik_mean_tidal_volume

group_VE = [benji_VE, chris_VE, fredrik_VE];
group_mean_VE = mean(group_VE)
group_std_VE = std(group_VE)
%%

%% IC
benji_IC = benji_mean_tidal_volume + benji_IRV
chris_IC = chris_mean_tidal_volume + chris_IRV
fredrik_IC = fredrik_mean_tidal_volume + fredrik_IRV

group_IC = [benji_IC, chris_IC, fredrik_IC];
group_mean_IC = mean(group_IC)
group_std_IC = std(group_IC)
%%

%% EC
benji_EC = benji_mean_tidal_volume + benji_ERV
chris_EC = chris_mean_tidal_volume + chris_ERV
fredrik_EC = fredrik_mean_tidal_volume + fredrik_ERV

group_EC = [benji_EC, chris_EC, fredrik_EC];
group_EC_mean = mean(group_EC)
group_EC_std = std(group_EC)
%%

%% Predicted VD from table
benji_predicted_VC = 4.928;
chris_predicted_VC = 5.248;
fredrik_predicted_VC = 6.848;

group_predicted_VC = [benji_predicted_VC, chris_predicted_VC, fredrik_predicted_VC];
group_VC_mean = mean(group_predicted_VC)
group_VC_std = std(group_predicted_VC)
%%

%% Measured VC
benji_VC = benji_mean_tidal_volume + benji_ERV + benji_IRV
chris_VC = chris_mean_tidal_volume + chris_ERV + chris_IRV
fredrik_VC = fredrik_mean_tidal_volume + fredrik_ERV + fredrik_IRV

group_measured_VC = [benji_VC, chris_VC, fredrik_VC];
group_measured_VC_mean = mean(group_measured_VC)
group_measured_VC_std = std(group_measured_VC)
%%

%% RV
benji_RV = benji_predicted_VC * 0.25
chris_RV = chris_predicted_VC * 0.25
fredrik_RV = fredrik_predicted_VC * 0.25

group_RV = [benji_RV, chris_RV, fredrik_RV];
group_RV_mean = mean(group_RV)
group_RV_std = std(group_RV)
%%

%% TLC
benji_TLC = benji_VC + benji_RV
chris_TLC = chris_VC + chris_RV
fredrik_TLC = fredrik_VC + fredrik_RV

group_TLC = [benji_TLC, chris_TLC, fredrik_TLC];
group_TLC_mean = mean(group_TLC)
group_TLC_std = std(group_TLC)
%%

%% FRC
benji_FRC = benji_ERV + benji_RV
chris_FRC = chris_ERV + chris_RV
fredrik_FRC = fredrik_ERV + fredrik_RV

group_FRC = [benji_FRC, chris_FRC, fredrik_FRC];
group_FRC_mean = mean(group_FRC)
group_FRC_std = std(group_FRC)
%%

%% Figure 2 Table 2
%% Exercise 3:
% Figure 2 Volume graph
% creating cut Benji data
bdata = load('es53_lab5_benji.mat');
bind1 = bdata.datastart(2,5);
bind2 = bdata.datastart(2,5) + bdata.com(4,3)+ bdata.com(5,3);
btime1 = (1:length(bdata.data(bind1:bind2)))/bdata.samplerate(1);
bcutdata1 = bdata.data(bind1:bind2);
bind11 = bdata.datastart(2,6);
bind21 = bdata.datastart(2,6) + bdata.com(6,3) + bdata.com(7,3);
bcutdata12 = bdata.data(bind11:bind21);
btime12 = (1:length(bdata.data(bind11:bind21)))/bdata.samplerate(1);
bind13 = bdata.datastart(2,7);
bind23 = bdata.dataend(2,7);
bcutdata13 = bdata.data(bind13:bind23);
btime13 = (1:length(bdata.data(bind13:bind23)))/bdata.samplerate(1);
%fredrik cut data
fdata = load('es53_lab5_fredrik.mat');
find1 = fdata.datastart(2,2);
find2 = fdata.datastart(2,2) + fdata.com(4,3) + fdata.com(5,3);
fcutdata1 = fdata.data(find1:find2);
ftime1 = (1:length(fdata.data(find1:find2)))/fdata.samplerate(1);
find11 = fdata.datastart(2,3);
find21 = fdata.datastart(2,3) + fdata.com(6,3) + fdata.com(7,3);
fcutdata12 = fdata.data(find11:find21);
ftime12 = (1:length(fdata.data(find11:find21)))/fdata.samplerate(1);
find13 = fdata.datastart(2,4);
find23 = fdata.dataend(2,4);
fcutdata13 = fdata.data(find13:find23);
ftime13 = (1:length(fdata.data(find13:find23)))/fdata.samplerate(1);
% creating cut chris data structures
cdata = load('es53_lab5_chris.mat');
cind1 = cdata.datastart(2,2);
cind2 = cdata.datastart(2,2) + cdata.com(4,3) + cdata.com(5,3);
ccutdata1 = cdata.data(cind1:cind2);
ctime1 = (1:length(cdata.data(cind1:cind2)))/cdata.samplerate(1);
cind11 = cdata.datastart(2,3);
cind21 = cdata.datastart(2,3) + cdata.com(6,3) + cdata.com(7,3);
ccutdata12 = cdata.data(cind11:cind21);
ctime12 = (1:length(cdata.data(cind11:cind21)))/cdata.samplerate(1);
cind13 = cdata.datastart(2,4);
cind23 = cdata.dataend(2,4);
ccutdata13 = cdata.data(cind13:cind23);
ctime13 = (1:length(cdata.data(cind13:cind23)))/cdata.samplerate(1);
%% Figure 2 Flow Graph
%cut benji data
bind3 = bdata.datastart(1,5);
bind4 = bdata.datastart(1,5) + bdata.com(4,3)+ bdata.com(5,3);
btime2 = (1:length(bdata.data(bind3:bind4)))/bdata.samplerate(1);
bcutdata2 = bdata.data(bind3:bind4);
bind32 = bdata.datastart(1,6);
bind42 = bdata.datastart(1,6) + bdata.com(6,3) + bdata.com(7,3);
bcutdata22 = bdata.data(bind32:bind42);
btime22 = (1:length(bdata.data(bind32:bind42)))/bdata.samplerate(1);
bind33 = bdata.datastart(1,7);
bind43 = bdata.dataend(1,7);
bcutdata23 = bdata.data(bind33:bind43);
btime23 = (1:length(bdata.data(bind33:bind43)))/bdata.samplerate(1);
%cut fredriks data
find3 = fdata.datastart(1,2);
find4 = fdata.datastart(1,2) + fdata.com(4,3) + fdata.com(5,3);
fcutdata2 = fdata.data(find3:find4);
ftime2 = (1:length(fdata.data(find3:find4)))/fdata.samplerate(1);
find32 = fdata.datastart(1,3);
find42 = fdata.datastart(1,3) + fdata.com(6,3) + fdata.com(7,3);
fcutdata22 = fdata.data(find32:find42);
ftime22 = (1:length(fdata.data(find32:find42)))/fdata.samplerate(1);
find33 = fdata.datastart(1,4);
find43 = fdata.dataend(1,4);
fcutdata23 = fdata.data(find33:find43);
ftime23 = (1:length(fdata.data(find33:find43)))/fdata.samplerate(1);
% cut Chris data
cind3 = cdata.datastart(1,2);
cind4 = cdata.datastart(1,2) + cdata.com(4,3)+ cdata.com(5,3);
ctime2 = (1:length(cdata.data(cind3:cind4)))/cdata.samplerate(1);
ccutdata2 = cdata.data(cind3:cind4);
cind32 = cdata.datastart(1,3);
cind42 = cdata.datastart(1,3) + cdata.com(6,3) + cdata.com(7,3);
ccutdata22 = cdata.data(cind32:cind42);
ctime22 = (1:length(bdata.data(cind32:cind42)))/cdata.samplerate(1);
cind33 = cdata.datastart(1,4);
cind43 = cdata.dataend(1,4);
ccutdata23 = cdata.data(cind33:cind43);
ctime23 = (1:length(cdata.data(cind33:cind43)))/cdata.samplerate(1);
subplot(2,1,1)
hold on
plot(btime2,bcutdata2)
plot(ctime2,ccutdata2)
plot(ftime2,fcutdata2)
xlabel('Time (s)')
ylabel('Flow (L/s)')
xlim([0 length(ccutdata1)/cdata.samplerate(1)])
legend('Benji','Chris','Fredrik')
hold off
subplot(2,1,2)
hold on
plot(btime1,bcutdata1)
plot(ftime1,fcutdata1)
plot(ctime1,ccutdata1)
xlabel('Time (s)')
ylabel('Volume (L)')
xlim([0 length(ccutdata1)/cdata.samplerate(1)])
legend('Benji','Chris','Fredrik')
hold off
%% Table 2
stomin = (60);
%calculate PIF
cPIF1 = max(ccutdata2) * (stomin);
cPIF2 = max(ccutdata22) * (stomin);
cPIF3 = max(ccutdata23) * (stomin);
fPIF1 = max(fcutdata2) * (stomin);
fPIF2 = max(fcutdata22) * (stomin);
fPIF3 = max(fcutdata23) * (stomin);
bPIF1 = max(bcutdata2) * (stomin);
bPIF2 = max(bcutdata22) * (stomin);
bPIF3 = max(bcutdata23) * (stomin);
cPEF1 = min(ccutdata2) * stomin;
cPEF2 = min(ccutdata22) * stomin;
cPEF3 = min(ccutdata23) * stomin;
fPEF1 = min(fcutdata2) * stomin;
fPEF2 = min(fcutdata22) * stomin;
fPEF3 = min(fcutdata23) * stomin;
bPEF1 = min(bcutdata2) * stomin;
bPEF2 = min(bcutdata22) * stomin;
bPEF3 = min(bcutdata23) * stomin;
%calculate FVC
bFVC1 = max(bcutdata1) - min(bcutdata1);
bFVC2 = max(bcutdata12) - min(bcutdata12);
bFVC3 = max(bcutdata13) - min(bcutdata13);
fFVC1 = max(fcutdata1) - min(fcutdata1);
fFVC2 = max(fcutdata12) - min(fcutdata12);
fFVC3 = max(fcutdata13) - min(fcutdata13);
cFVC1 = max(ccutdata1) - min(ccutdata1);
cFVC2 = max(ccutdata12) - min(ccutdata12);
cFVC3 = max(ccutdata13) - min(ccutdata13);
%calculate FEV1
[cmax1,cindone] = max(ccutdata1);
cFEV1 = cmax1 - ccutdata1(cindone + cdata.samplerate(1));
[cmax2,cindtwo] = max(ccutdata12);
cFEV2 = cmax2 - ccutdata12(cindtwo + cdata.samplerate(1));
[cmax3,cindthree] = max(ccutdata13);
cFEV3 = cmax3 - ccutdata1(cindthree + cdata.samplerate(1));
[fmax1,findone] = max(fcutdata1);
fFEV1 = fmax1 - fcutdata1(findone + fdata.samplerate(1));
[fmax2,findtwo] = max(fcutdata12);
fFEV2 = fmax2 - fcutdata12(findtwo + fdata.samplerate(1));
[fmax3,findthree] = max(fcutdata13);
fFEV3 = fmax3 - fcutdata13(findthree + fdata.samplerate(1));
[bmax1,bindone] = max(bcutdata1);
bFEV1 = bmax1 - bcutdata1(bindone + bdata.samplerate(1));
[bmax2,bindtwo] = max(bcutdata12);
bFEV2 = bmax2 - bcutdata12(bindtwo + bdata.samplerate(1));
[bmax3,bindthree] = max(bcutdata13);
bFEV3 = bmax3 - bcutdata13(bindthree + bdata.samplerate(1));
sFEV1 = std([cFEV1,cFEV2,cFEV3,fFEV1,fFEV2,fFEV3,bFEV1,bFEV2,bFEV3]);
meanFEV1 = mean([cFEV1,cFEV2,cFEV3,fFEV1,fFEV2,fFEV3,bFEV1,bFEV2,bFEV3]);
sFVC = std([bFVC1,bFVC2,bFVC3,fFVC1,fFVC2,fFVC3,cFVC1,cFVC2,cFVC3]);
meanFVC = mean([bFVC1,bFVC2,bFVC3,fFVC1,fFVC2,fFVC3,cFVC1,cFVC2,cFVC3]);
sPEF = std([cPEF1,cPEF2,cPEF3,bPEF1,bPEF2,bPEF3,fPEF1,fPEF2,fPEF3]);
meanPEF = mean([cPEF1,cPEF2,cPEF3,bPEF1,bPEF2,bPEF3,fPEF1,fPEF2,fPEF3]);
sPIF = std([cPIF1,cPIF2,cPIF3,bPIF2,bPIF3,bPIF1,fPIF1,fPIF2,fPIF3]);
meanPIF = mean([cPIF1,cPIF2,cPIF3,bPIF2,bPIF3,bPIF1,fPIF1,fPIF2,fPIF3]);
bmeanFVC = mean([bFVC1,bFVC2,bFVC3]);
bmeanFEV = mean([bFEV1,bFEV2,bFEV3]);
bratio = (bmeanFEV / bmeanFVC) * 100;
fmeanFVC = mean([fFVC1,fFVC2,fFVC3]);
fmeanFEV = mean([fFEV1,fFEV2,fFEV3]);
fratio = (fmeanFEV / fmeanFVC) * 100;
cmeanFVC = mean([cFVC1,cFVC2,cFVC3]);
cmeanFEV = mean([cFEV1,cFEV2,cFEV3]);
cratio = (cmeanFEV / cmeanFVC) * 100;
stdratio = std([bratio,cratio,fratio]);
meanratio = mean([bratio,cratio,fratio]);

%%
%%

%% Figure 3 Table 3
%group data
c_data = load("es53_lab5_chris_obstruction.mat");

c1_flow = (c_data.data(c_data.datastart(1,1):c_data.dataend(1,1)));

c2_flow = (c_data.data(c_data.datastart(1,2):c_data.dataend(1,2)));

c3_flow = (c_data.data(c_data.datastart(1,3):c_data.dataend(1,3)));

c1_volume = (c_data.data(c_data.datastart(2,1):c_data.dataend(2,1)));

c2_volume = (c_data.data(c_data.datastart(2,2):c_data.dataend(2,2)));

c3_volume = (c_data.data(c_data.datastart(2,3):c_data.dataend(2,3)));

c_unob = load("es53_lab5_chris.mat");

c_unob1 = (c_unob.data(c_unob.datastart(2,1):c_unob.dataend(2,1)));
c_unob2 = (c_unob.data(c_unob.datastart(2,2):c_unob.dataend(2,2)));
c_unob3 = (c_unob.data(c_unob.datastart(2,3):c_unob.dataend(2,3)));

%sample rate
sr = c_data.samplerate(1,1);

length1 = c_data.dataend(1,1) - c_data.datastart(1,1);
t1 = 1/sr:1/sr:length1/sr;

length2 = c_data.dataend(1,2) - c_data.datastart(1,2);
t2 = 1/sr:1/sr:length2/sr;

length3 = c_data.dataend(1,3) - c_data.datastart(1,3);
t3 = 1/sr:1/sr:length3/sr;

c1_flow_data = c1_flow(1:length1);
c2_flow_data = c2_flow(1:length2);
c3_flow_data = c3_flow(1:length3);

c1_volume_data = c1_volume(1:length1);
c2_volume_data = c2_volume(1:length2);
c3_volume_data = c3_volume(1:length3);

length11 = c_unob.dataend(2,1) - c_unob.datastart(2,1);
t11 = 0:1/sr:length11/sr;

length21 = c_unob.dataend(2,2) - c_unob.datastart(2,2);
t21 = 1/sr:1/sr:length21/sr;

length31 = c_unob.dataend(2,3) - c_unob.datastart(2,3);
t31 = 1/sr:1/sr:length31/sr;



%% Figure 3
figure 
hold on 

subplot (211)

plot(t11, c_unob1)
xlabel('Time(s)')
ylabel('Volume(L)')
legend('Lung Volume')
axis([0 (length1/sr) min(c_unob1)*1.2 max(c_unob1)*1.2])

subplot (212)

plot(t1, c1_volume_data)
xlabel('Time(s)')
ylabel('Volume(L)')
legend('Lung Volume')
axis([0 (length1/sr) min(c1_volume_data)*1.2 max(c1_volume_data)*1.2])

hold off

%peak inspiratory flow (PIV)

max1 = max(c1_flow_data)*60;
max2 = max(c2_flow_data)*60;
max3 = max(c3_flow_data)*60;

PIV_mean = mean([max1,max2,max3]);
PIV_SD = std([max1,max2,max3]);

%peak expiratory flow (PEV)

min1 = min(c1_flow_data)*60;
min2 = min(c2_flow_data)*60;
min3 = min(c3_flow_data)*60;

PEV_mean = mean([min1,min2,min3]);
PEV_SD = std([min1,min2,min3]);

%Forced Vital Capacity

forced1 = c_data.data(c_data.datastart(2,1)+c_data.com(2,3):c_data.datastart(2,1)+c_data.com(3,3));
forced2 = c_data.data(c_data.datastart(2,2)+c_data.com(4,3):c_data.datastart(2,2)+c_data.com(5,3));
forced3 = c_data.data(c_data.datastart(2,3)+c_data.com(6,3):c_data.datastart(2,3)+c_data.com(7,3));

FVC1 = max(forced1) - min(forced1);
FVC2 = max(forced2) - min(forced2);
FVC3 = max(forced3) - min(forced3);

FVC_mean = mean([FVC1,FVC2,FVC3]);
FVC_SD = std([FVC1,FVC2,FVC3]);

%Forced Expired Capacity in 1 second (FEV1)

[FEV1value1, FEV1start1] = max(c1_volume);
[FEV1value2, FEV1start2] = max(c2_volume);
[FEV1value3, FEV1start3] = max(c3_volume);

FEV1_1_start = c_data.data(c_data.datastart(2,1)+FEV1start1);
FEV1_1_end = c_data.data(c_data.datastart(2,1)+FEV1start1+sr);
FEV1_1 = FEV1_1_start - FEV1_1_end;

FEV1_2_start = c_data.data(c_data.datastart(2,2)+FEV1start2);
FEV1_2_end = c_data.data(c_data.datastart(2,2)+FEV1start2+sr);
FEV1_2 = FEV1_2_start - FEV1_2_end;

FEV1_3_start = c_data.data(c_data.datastart(2,3)+FEV1start3);
FEV1_3_end = c_data.data(c_data.datastart(2,3)+FEV1start3+sr);
FEV1_3 = FEV1_3_start - FEV1_3_end;

FEV1_mean = mean([FEV1_1, FEV1_2, FEV1_3]);
FEV1_SD = std([FEV1_1, FEV1_2, FEV1_3]);

figure 

hold on 

subplot (211)

plot(t1, c1_flow_data)
xlabel('Time(s)')
ylabel('FLow(L/s)')
legend('Air Flow')
axis([0 (length1/sr) min(c1_flow_data)*1.2 max(c1_flow_data)*1.2])

subplot (212)

plot(t1, c1_volume_data)
xlabel('Time(s)')
ylabel('Volume(L)')
legend('Lung Volume')
axis([0 (length1/sr) min(c1_volume_data)*1.2 max(c1_volume_data)*1.2])

hold off

figure 

hold on 

subplot (211)

plot(t2, c2_flow_data)
xlabel('Time(s)')
ylabel('FLow(L/s)')
legend('Air Flow')
axis([0 (length1/sr) min(c2_flow_data)*1.2 max(c2_flow_data)*1.2])

subplot (212)

plot(t2, c2_volume_data)
xlabel('Time(s)')
ylabel('Volume(L)')
legend('Lung Volume')
axis([0 (length1/sr) min(c2_volume_data)*1.2 max(c2_volume_data)*1.2])

hold off

figure 

hold on 

subplot (211)

plot(t3, c3_flow_data)
xlabel('Time(s)')
ylabel('FLow(L/s)')
legend('Air Flow')
axis([0 (length3/sr) min(c3_flow_data)*1.2 max(c3_flow_data)*1.2])

subplot (212)

plot(t3, c3_volume_data)
xlabel('Time(s)')
ylabel('Volume(L)')
legend('Lung Volume')
axis([0 (length3/sr) min(c3_volume_data)*1.2 max(c3_volume_data)*1.2])

hold off
%%
