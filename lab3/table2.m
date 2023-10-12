% load all subjects
subject1 = load('Lab3_Ex2_Sub1.mat');
subject2 = load('Lab3_Ex2_Sub2.mat');
subject3 = load('Lab3_Ex2_Sub3.mat');

% extract sitting data for all subjects
subject1_standing = subject1.data(subject1.datastart(1, 2) : subject1.dataend(1,2));
subject2_standing = subject2.data(subject2.datastart(1, 2) : subject2.dataend(1,2));
subject3_standing = subject3.data(subject3.datastart(1, 2) : subject3.dataend(1,2));

% subject1 peaks
e20_1 = subject1_standing / max(subject1_standing);
de20_1 = diff(e20_1); % derivative of this vector
threshold = 0.8; % peak treshold
ind_1 = find((e20_1(2:end-1)>threshold)&(de20_1(1:end-1)>0)&(de20_1(2:end)<0))+1; % the indices of all peaks in the first 20 second segment

% subject2 peaks
e20_2 = subject2_standing / max(subject2_standing);
de20_2 = diff(e20_2); % derivative of this vector
threshold = 0.8; % peak treshold
ind_2 = find((e20_2(2:end-1)>threshold)&(de20_2(1:end-1)>0)&(de20_2(2:end)<0))+1;

% subject3 peaks
e20_3 = subject3_standing / max(subject3_standing);
de20_3 = diff(e20_3); % derivative of this vector
threshold = 0.5; % peak treshold
ind_3 = find((e20_3(2:end-1)>threshold)&(de20_3(1:end-1)>0)&(de20_3(2:end)<0))+1;

% samplerate
S = subject1.samplerate(1);

% plot for subject 1
time_1 = (1:length(e20_1))/S;
figure(1);
plot(time_1, e20_1);
hold on
xlabel('time (s)');
ylabel('Amplitude a.u.');
axis([0 10 -1.1 1.1]);
MPH = threshold;
MPD = S/2;
[~,locs_Rwave_s1] = findpeaks(e20_1,'MinPeakHeight',MPH,'MinPeakDistance',MPD);
plot(time_1(locs_Rwave_s1), e20_1(locs_Rwave_s1),'g*');
hold off

% plot for subject 2
time_2 = (1:length(e20_2))/S;
figure(2);
plot(time_2, e20_2);
hold on
xlabel('time (s)');
ylabel('Amplitude a.u.');
axis([0 10 -1.1 1.1]);
MPH = threshold;
MPD = S/2;
[~,locs_Rwave_s2] = findpeaks(e20_2,'MinPeakHeight',MPH,'MinPeakDistance',MPD);
plot(time_2(locs_Rwave_s2), e20_2(locs_Rwave_s2),'g*');
hold off

% plot for subject 3
time_3 = (1:length(e20_3))/S;
figure(3);
plot(time_3, e20_3);
hold on
xlabel('time (s)');
ylabel('Amplitude a.u.');
axis([0 10 -1.1 1.1]);
MPH = threshold;
MPD = S/2;
[~,locs_Rwave_s3] = findpeaks(e20_3,'MinPeakHeight',MPH,'MinPeakDistance',MPD);
plot(time_3(locs_Rwave_s3), e20_3(locs_Rwave_s3),'g*');
hold off

% R-R interval subject 1
rr_intervals_s1 = diff(locs_Rwave_s1) / S;
rr_intervals_s2 = diff(locs_Rwave_s2) / S;
rr_intervals_s3 = diff(locs_Rwave_s3) / S;

% mean, max, min, std, and mean heart rate for subject 1
mean_rr_s1 = mean(rr_intervals_s1);
max_rr_s1 = max(rr_intervals_s1);
min_rr_s1 = min(rr_intervals_s1);
std_rr_s1 = std(rr_intervals_s1);
heart_rate_s1 = 60 / mean_rr_s1;

% mean, max, min, std, and mean heart rate for subject 2
mean_rr_s2 = mean(rr_intervals_s2);
max_rr_s2 = max(rr_intervals_s2);
min_rr_s2 = min(rr_intervals_s2);
std_rr_s2 = std(rr_intervals_s2);
heart_rate_s2 = 60 / mean_rr_s2;

% mean, max, min, std, and mean heart rate for subject 3
mean_rr_s3 = mean(rr_intervals_s3);
max_rr_s3 = max(rr_intervals_s3);
min_rr_s3 = min(rr_intervals_s3);
std_rr_s3 = std(rr_intervals_s3);
heart_rate_s3 = 60 / mean_rr_s3;
