
% load subject
subject1 = load('Lab3_Ex2_Sub1.mat');

% extract sitting data for subject
subject1_sitting = subject1.data(subject1.datastart(1, 1) : subject1.dataend(1,1));

% subject peaks
e20_1 = subject1_sitting / max(subject1_sitting);
de20_1 = diff(e20_1); % derivative of this vector
threshold = 0.8; % peak treshold
ind = find((e20_1(2:end-1)>threshold)&(de20_1(1:end-1)>0)&(de20_1(2:end)<0))+1; % the indices of all peaks in the first 20 second segment

% time vector for subject
S = subject1.samplerate(1);
time = (1:length(e20_1))/S;

% plot for subject
figure(2);
plot(time, e20_1);
hold on
plot(time(ind), e20_1(ind),'r*');
xlabel('time (s)');
ylabel('Amplitude a.u.');
axis([0 10 -1.1 1.1]);
MPH = threshold;
MPD = S/2;
hold off

[~,locs_Rwave] = findpeaks(e20_1,'MinPeakHeight',MPH,'MinPeakDistance',MPD);
hold on
plot(time(locs_Rwave), e20_1(locs_Rwave),'g*');
hold off

% R-R interval implementation for each subject
rr_intervals_s1 = diff(locs_Rwave) / S;

% mean, max, min, std, and mean heart rate for subject 1
mean_rr_s1 = mean(rr_intervals_s1);
max_rr_s1 = max(rr_intervals_s1);
min_rr_s1 = min(rr_intervals_s1);
std_rr_s1 = std(rr_intervals_s1);
heart_rate_s1 = 60 / mean_rr_s1;
