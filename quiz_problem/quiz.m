% load data
subject = load('respiratorydata.mat');
sample_rate = subject.samplerate(1);

% extracting 200 seconds of breath data and pulse data
subject_breath = subject.data(subject.datastart(1, 1) : subject.datastart(1, 1) + 200 * sample_rate);
subject_pulse = subject.data(subject.datastart(2, 1) : subject.datastart(2, 1) + 200 * sample_rate);

% time vectors for both breath and pulse
time_breath = (0 : length(subject_breath) - 1) / sample_rate;
time_pulse = (0 : length(subject_pulse) - 1) / sample_rate;

% subject peak finding
ep_subject = subject_breath;
dep_subject = diff(ep_subject); % derivative of this vector
threshold = 10; % empirical peak treshold
time_subject_breath = (1:length(ep_subject))/sample_rate;

% peaks reference plot
figure(1);
plot(time_subject_breath, ep_subject);
hold on
MPH = threshold;
MPD = 2 * sample_rate;
[~,subject_breath_peaks] = findpeaks(ep_subject,'MinPeakHeight',MPH,'MinPeakDistance',MPD);
plot(time_subject_breath(subject_breath_peaks), ep_subject(subject_breath_peaks),'ro');
title('Subject pulse normal breathing');
hold off

% subject trough finding
% subject peak finding
et_subject = subject_breath * -1;
det_subject = diff(et_subject); % derivative of this vector
threshold = -25; % empirical peak treshold
time_subject_breath_troughs = (1:length(et_subject))/sample_rate;

% troughs reference plot
figure(2);
plot(time_subject_breath_troughs, et_subject);
hold on
MPH = threshold;
MPD = 2 * sample_rate;
[~,subject_breath_troughs] = findpeaks(et_subject,'MinPeakHeight',MPH,'MinPeakDistance',MPD);
plot(time_subject_breath_troughs(subject_breath_troughs), e_subject(subject_breath_troughs),'r*');
title('Subject pulse normal breathing');
hold off














% final plot
figure(3);
subplot(2, 1, 1);
plot(time_breath, subject_breath, 'black');
hold on
plot(time_subject_breath(subject_breath_peaks), e_subject(subject_breath_peaks),'ro');
hold off
xlabel('Time (s)');
ylabel('Lung expansion (a.u)');

subplot(2, 1, 2);
plot(time_pulse, subject_pulse, 'black');
xlabel('Time (s)');
ylabel('Pulse (a.u)');

