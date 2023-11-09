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
% benji
benji_volume = benji.data(benji.datastart(2, 1) : benji.datastart(2, 1) + 60 * sample_rate);
e20_benji = benji_volume / max(benji_volume);
de20_benji = diff(e20_benji); % derivative of this vector
threshold = -20; % peak treshold
ind_benji = find((e20_benji(2:end-1)>threshold)&(de20_benji(1:end-1)>0)&(de20_benji(2:end)<0))+1;

% reference tidal inspiration line
benji_volume(peak).abs() + benji(trough).abs()

% plot
time_benji = (1:length(e20_benji))/sample_rate;
figure(4);
subplot(3, 1, 1);
plot(time_1, e20_1);
hold on
axis([0 10 -1.1 1.1]);
MPH = threshold;
MPD = sample_rate;
[~,locs_peak_benji] = findpeaks(e20_1,'MinPeakHeight',MPH,'MinPeakDistance',MPD);
plot(time_benji(locs_peak_benji), e20_1(locs_peak_benji),'r*');
hold off

% % chris
% chris_volume = chris.data(chris.datastart(2, 1) : chris.datastart(2, 1) + 60 * sample_rate);
% e20_1 = chris_volume / max(chris_volume);
% de20_1 = diff(e20_1); % derivative of this vector
% threshold = -15; % peak treshold
% ind_1 = find((e20_1(2:end-1)>threshold)&(de20_1(1:end-1)>0)&(de20_1(2:end)<0))+1;
% 
% % plot
% time_1 = (1:length(e20_1))/sample_rate;
% figure(4);
% subplot(3, 1, 1);
% plot(time_1, e20_1);
% hold on
% axis([0 10 -1.1 1.1]);
% MPH = threshold;
% MPD = sample_rate;
% [~,locs_Rwave_s1] = findpeaks(e20_1,'MinPeakHeight',MPH,'MinPeakDistance',MPD);
% plot(time_1(locs_Rwave_s1), e20_1(locs_Rwave_s1),'r*');
% hold off
% 
% chris_respiratory_rate = length(locs_Rwave_s1)

benji_respiratory_rate = length(locs_peak_benji)
%%

%% Tital Inspiration
% peak indices for benji
benji_volume = benji.data(benji.datastart(2, 4) : benji.dataend(2, 4));
e20_benji = benji_volume / max(benji_volume);
de20_benji = diff(e20_benji); % derivative of this vector
threshold = 0.4; % peak treshold
ind_benji = find((e20_benji(2:end-1)>threshold)&(de20_benji(1:end-1)>0)&(de20_benji(2:end)<0))+1;
time_benji = (1:length(e20_benji))/sample_rate;
figure(4);
plot(time_benji, e20_benji);
hold on
axis([0 10 -1.1 1.1]);
MPH = threshold;
MPD = sample_rate;
[~,benji_top_peak] = findpeaks(e20_benji,'MinPeakHeight',MPH,'MinPeakDistance',MPD);
plot(time_benji(benji_top_peak), e20_benji(benji_top_peak),'r*');
hold off

% bottom peak indices for benji
benji_bottom = benji_volume * -1;
e20_benji_bottom = benji_bottom / max(benji_bottom);
de20_benji_bottom = diff(e20_benji_bottom); % derivative of this vector
threshold = -0; % peak treshold
ind_benji_bottom = find((e20_benji_bottom(2:end-1)>threshold)&(de20_benji_bottom(1:end-1)>0)&(de20_benji_bottom(2:end)<0))+1;
time_benji_bottom = (1:length(e20_benji_bottom))/sample_rate;
figure(5);
plot(time_benji_bottom, e20_benji_bottom);
hold on
axis([0 10 -1.1 1.1]);
MPH = threshold;
MPD = sample_rate;
[~,benji_bottom_peak] = findpeaks(e20_benji_bottom,'MinPeakHeight',MPH,'MinPeakDistance',MPD);
plot(time_benji_bottom(benji_bottom_peak), e20_benji_bottom(benji_bottom_peak),'r*');
hold off

benji_tidal_inspirations = [];
for i = 1:8
    inspiration = abs(benji_volume(benji_top_peak(i))) + abs(benji_volume(benji_bottom_peak(i)));
    benji_tidal_inspirations = [benji_tidal_inspirations, inspiration];
end
benji_mean_tidal_respiration = mean(benji_tidal_inspirations);
%%

%% IRV
% benji IRV
benji_normal_inhale = benji_volume(benji_top_peak(1));
benji_max_inhale = max(benji_volume);
benji_IRV = benji_max_inhale - benji_normal_inhale;

benji_normal_exhale = abs(benji_volume(benji_bottom_peak(1)));
benji_max_exhale = abs(min(benji_volume));
benji_ERV = benji_normal_exhale + benji_max_exhale;
%%
