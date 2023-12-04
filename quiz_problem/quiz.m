
% load data
subject = load('respiratorydata.mat');
sample_rate = subject.samplerate(1);

% extracting 200 seconds of breath data and pulse data
subject_breath = subject.data(subject.datastart(1, 1) : subject.datastart(1, 1) + 200 * sample_rate);
subject_pulse = subject.data(subject.datastart(2, 1) : subject.datastart(2, 1) + 200 * sample_rate);

% time vectors for both breath and pulse
time_breath = (0 : length(subject_breath) - 1) / sample_rate;
time_pulse = (0 : length(subject_pulse) - 1) / sample_rate;

figure(1);
subplot(2, 1, 1);
plot(time_breath, subject_breath, 'black');
xlabel('Time (s)');
ylabel('Lung expansion (a.u)');

subplot(2, 1, 2);
plot(time_pulse, subject_pulse, 'black');
xlabel('Time (s)');
ylabel('Pulse (a.u)');

% peak finding
e_subject = subject_breath / max(benji_normal_breathing); % normalize
de_benji = diff(e_benji); % derivative of this vector
threshold = 0.8; % treshold due to normalization
MPH = threshold;
MPD = 5 * sample_rate;
[~,benji_breath_peaks] = findpeaks(e_benji,'MinPeakHeight',MPH,'MinPeakDistance',MPD);


