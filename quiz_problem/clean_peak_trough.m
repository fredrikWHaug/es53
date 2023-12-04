subject = load('respiratorydata.mat');
sample_rate = subject.samplerate(1);

% peak indices for subject
subject_breath = subject.data(subject.datastart(1, 1) : subject.datastart(1, 1) + 200 * sample_rate);
e20_subject = subject_breath / max(subject_breath);
de20_subject = diff(e20_subject); % derivative of this vector
threshold = 0.3; % emperically determined peak treshold
ind_subject = find((e20_subject(2:end-1)>threshold)&(de20_subject(1:end-1)>0)&(de20_subject(2:end)<0))+1;
time_subject = (1:length(e20_subject))/sample_rate;
figure(1);
plot(time_subject, e20_subject);
hold on
axis([0 10 -1.1 1.1]);
MPH = threshold;
MPD = 2 * sample_rate;
[~,subject_top_peaks] = findpeaks(e20_subject,'MinPeakHeight',MPH,'MinPeakDistance',MPD);
plot(time_subject(subject_top_peaks), e20_subject(subject_top_peaks),'r*');
hold off

% trough indices for subject
subject_trough = subject_breath * -1;
e20_subject_trough = subject_trough / max(subject_trough);
de20_subject_trough = diff(e20_subject_trough); % derivative of this vector
threshold = 1.3; % peak treshold
ind_subject_trough = find((e20_subject_trough(2:end-1)>threshold)&(de20_subject_trough(1:end-1)>0)&(de20_subject_trough(2:end)<0))+1;
time_subject_trough = (1:length(e20_subject_trough))/sample_rate;
figure(2);
plot(time_subject_trough, e20_subject_trough);
hold on
MPH = threshold;
MPD = 2 * sample_rate;
[~,subject_trough_peaks] = findpeaks(e20_subject_trough,'MinPeakHeight',MPH,'MinPeakDistance',MPD);
plot(time_subject_trough(subject_trough_peaks), e20_subject_trough(subject_trough_peaks),'r*');
axis([0 10 -1.1 1.1]);
hold off

% final plot
% final plot
figure(3);
subplot(2, 1, 1);
plot(time_breath, subject_breath, 'black');
hold on
plot(time_subject_breath(subject_breath_peaks), e_subject(subject_breath_peaks),'ro');
plot(time_subject_trough(subject_trough_peaks), e20_subject_trough(subject_trough_peaks),'b*');
hold off
xlabel('Time (s)');
ylabel('Lung expansion (a.u)');

subplot(2, 1, 2);
plot(time_pulse, subject_pulse, 'black');
xlabel('Time (s)');
ylabel('Pulse (a.u)');
