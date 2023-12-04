chris = load('es53_lab5_chris.mat');
sample_rate = chris.samplerate(1);

% peak indices for chris
chris_volume = chris.data(chris.datastart(2, 1) : chris.dataend(2, 1));
e20_chris = chris_volume / max(chris_volume);
de20_chris = diff(e20_chris); % derivative of this vector
threshold = -1.5; % emperically determined peak treshold
ind_chris = find((e20_chris(2:end-1)>threshold)&(de20_chris(1:end-1)>0)&(de20_chris(2:end)<0))+1;
time_chris = (1:length(e20_chris))/sample_rate;
figure(1);
plot(time_chris, e20_chris);
hold on
axis([0 10 -1.1 1.1]);
MPH = threshold;
MPD = 3 * sample_rate;
[~,chris_top_peaks] = findpeaks(e20_chris,'MinPeakHeight',MPH,'MinPeakDistance',MPD);
plot(time_chris(chris_top_peaks), e20_chris(chris_top_peaks),'r*');
hold off

% trough indices for chris
chris_trough = chris_volume * -1;
e20_chris_trough = chris_trough / max(chris_trough);
de20_chris_trough = diff(e20_chris_trough); % derivative of this vector
threshold = 0.3; % peak treshold
ind_chris_trough = find((e20_chris_trough(2:end-1)>threshold)&(de20_chris_trough(1:end-1)>0)&(de20_chris_trough(2:end)<0))+1;
time_chris_trough = (1:length(e20_chris_trough))/sample_rate;
figure(2);
plot(time_chris_trough, e20_chris_trough);
hold on
MPH = threshold;
MPD = 3 * sample_rate;
[~,chris_trough_peaks] = findpeaks(e20_chris_trough,'MinPeakHeight',MPH,'MinPeakDistance',MPD);
plot(time_chris_trough(chris_trough_peaks), e20_chris_trough(chris_trough_peaks),'r*');
axis([0 10 -1.1 1.1]);
hold off
