%% ENG-SCI 53 Lab 3
% Filename: es53_lab3.m
% Author: Abby Yoon, Lydia Shimelis, Fredrik Willumsen Haug
% Created: November 4th
% Description: ECG and Blood Volume Pulse
%%

%% Figure 1
% load data from all subjects
subject1 = load('Lab3_Ex2_Sub1.mat');
subject2 = load('Lab3_Ex2_Sub2.mat');
subject3 = load('Lab3_Ex2_Sub3.mat');

% extracting samplerate
sr = ex1.samplerate(1);

% data extraction for sitting still and defining time vector
% from start to 16 seconds determined empirically 
still = ex1.data(ex1.datastart(1, 1) : ex1.datastart(1, 1) + 16 * sr);
time_still = (0 : length(still) - 1);

% data extraction for arm movement
% from comment 2 (arm movement start)to 16 seconds to allign with still
arm_movement = ex1.data(ex1.datastart(1, 1) + ex1.com(2, 3) : ex1.datastart(1, 1) + ex1.com(2,3) + 16 * sr);
time_arm_movement = (0 : length(arm_movement) - 1);

% plot for displaying data artifacts due to movement
figure(1);
hold on
plot(time_still, still);
plot(time_arm_movement, arm_movement);
xlabel('Time (ms)');
ylabel('Voltage (V)');
legend('Still', 'Arm Movement');
hold off
%%

%% Figure 2
% re-load data from all subjects if helpful
% subject1 = load('Lab3_Ex2_Sub1.mat');
% subject2 = load('Lab3_Ex2_Sub2.mat');
% subject3 = load('Lab3_Ex2_Sub3.mat');

% extract samplerate to get time
sr = subject1.samplerate(1);

% extract sitting data for each subject (channel 1, block 2)
s1Sitting = subject1.data(subject1.datastart(1, 1) : subject1.datastart(1,1) + 10 * sr);
s2Sitting = subject2.data(subject2.datastart(1, 1) : subject2.datastart(1,1) + 10 * sr);
s3Sitting = subject3.data(subject3.datastart(1, 1) : subject3.datastart(1,1) + 10 * sr);

% time vector
time = (0 : length(s1Sitting)-1);

% plot for displaying ECG signal from sitting subjects
figure(2);
hold on
plot(time, s1Sitting);
plot(time, s2Sitting);
plot(time, s3Sitting);
xlabel('Time (ms)');
ylabel('Voltage (V)');
legend('subject1', 'subject2', 'subject3');
hold off
%%

%% Figure 3
% re-load data from all subjects if helpful
% subject1 = load('Lab3_Ex2_Sub1.mat');
% subject2 = load('Lab3_Ex2_Sub2.mat');
% subject3 = load('Lab3_Ex2_Sub3.mat');

% extract samplerate to get time
sr = subject1.samplerate(1);

% extract standing data for each subject (channel 1, block 2)
s1Standing = subject1.data(subject1.datastart(1, 2) : subject1.datastart(1,2) + 10 * sr);
s2Standing = subject2.data(subject2.datastart(1, 2) : subject2.datastart(1,2) + 10 * sr);
s3Standing = subject3.data(subject3.datastart(1, 2) : subject3.datastart(1,2) + 10 * sr);

% time vector
time = (0 : length(s1Standing)-1);

figure(3);
hold on
plot(time, s1Standing);
plot(time, s2Standing);
plot(time, s3Standing);
xlabel('Time (ms)');
ylabel('Voltage (V)');
legend('subject1', 'subject2', 'subject3');
hold off
%%

%% Figure 4
% re-load data from subject 1 if helpful
% subject1 = load('Lab3_Ex2_Sub1.mat');

sr = subject1.samplerate(1);

sitting = subject1.data(subject1.datastart(1, 1) : subject1.datastart(1,1) + 10 * sr);
standing = subject1.data(subject1.datastart(1, 2) : subject1.datastart(1,2) + 10 * sr);
post_exercise = subject1.data(subject1.datastart(1, 3) : subject1.datastart(1, 3) + 10 * sr);

% time vector
time_sitting = (0 : length(sitting)-1);
time_standing = (0 : length(standing)-1);
time_post_exercise = (0 : length(post_exercise)-1);

% plot
hold on
plot(time_sitting, sitting);
plot(time_standing, standing);
plot(time_post_exercise, post_exercise);
xlabel('Time (ms)');
ylabel('Voltage (V)');
legend('Sitting', 'Standing', 'Post exercise');
hold off
%%

%% Table 1
% load all subjects
subject1 = load('Lab3_Ex2_Sub1.mat');
subject2 = load('Lab3_Ex2_Sub2.mat');
subject3 = load('Lab3_Ex1_Sub3.mat');

% extract sitting data for all subjects
subject1_sitting = subject1.data(subject1.datastart(1, 1) : subject1.dataend(1,1));
subject2_sitting = subject2.data(subject2.datastart(1, 1) : subject2.dataend(1,1));
subject3_sitting = subject3.data(subject3.datastart(1, 1) : subject3.datastart(1,1) + 12.5*subject3.samplerate(1)); % cutoff at 12.5 seconds due to non representative data

% subject1 peaks
e20_1 = subject1_sitting / max(subject1_sitting);
de20_1 = diff(e20_1); % derivative of this vector
threshold = 0.8; % peak treshold
ind_1 = find((e20_1(2:end-1)>threshold)&(de20_1(1:end-1)>0)&(de20_1(2:end)<0))+1; % the indices of all peaks in the first 20 second segment

% subject2 peaks
e20_2 = subject2_sitting / max(subject2_sitting);
de20_2 = diff(e20_2); % derivative of this vector
threshold = 0.8; % peak treshold
ind_2 = find((e20_2(2:end-1)>threshold)&(de20_2(1:end-1)>0)&(de20_2(2:end)<0))+1;

% subject3 peaks
e20_3 = subject3_sitting / max(subject3_sitting);
de20_3 = diff(e20_3); % derivative of this vector
threshold = 0.3; % peak treshold
ind_3 = find((e20_3(2:end-1)>threshold)&(de20_3(1:end-1)>0)&(de20_3(2:end)<0))+1;
% highpass subject 3 data to get clear QRS peaks since P-wave was higher
s3 = highpass(e20_3, 150, subject1.samplerate(1));

% samplerate
S = subject1.samplerate(1);

% plot for subject 1
time_1 = (1:length(e20_1))/S;
figure(1);
plot(time_1, e20_1);
hold on
title('Subject 1 sitting R peaks');
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
title('Subject 2 sitting R peaks');
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
title('Subject 3 sitting R peaks');
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
%%

%% Table 2
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
%%

%% Figure 5
subject1 = load('Lab3_Ex2_Sub1.mat');
subject2 = load('Lab3_Ex2_Sub2.mat');
subject3 = load('Lab3_Ex2_Sub3.mat');

% sitting data 
% extract sitting data for all subjects
subject1_sitting = subject1.data(subject1.datastart(1, 1) : subject1.dataend(1,1));
subject2_sitting = subject2.data(subject2.datastart(1, 1) : subject2.dataend(1,1));
subject3_sitting = subject3.data(subject3.datastart(1, 1) : subject3.dataend(1,1));

% subject1 peaks
e20_1 = subject1_sitting / max(subject1_sitting);
de20_1 = diff(e20_1); % derivative of this vector
threshold = 0.8; % peak treshold
ind_1 = find((e20_1(2:end-1)>threshold)&(de20_1(1:end-1)>0)&(de20_1(2:end)<0))+1; % the indices of all peaks in the first 20 second segment

% subject2 peaks
e20_2 = subject2_sitting / max(subject2_sitting);
de20_2 = diff(e20_2); % derivative of this vector
threshold = 0.8; % peak treshold
ind_2 = find((e20_2(2:end-1)>threshold)&(de20_2(1:end-1)>0)&(de20_2(2:end)<0))+1;

% subject3 peaks
e20_3 = subject3_sitting / max(subject3_sitting);
de20_3 = diff(e20_3); % derivative of this vector
threshold = 0.8; % peak treshold
ind_3 = find((e20_3(2:end-1)>threshold)&(de20_3(1:end-1)>0)&(de20_3(2:end)<0))+1;

% standing data
% extract standing data for all subjects
subject1_standing = subject1.data(subject1.datastart(1, 2) : subject1.dataend(1,2));
subject2_standing = subject2.data(subject2.datastart(1, 2) : subject2.dataend(1,2));
subject3_standing = subject3.data(subject3.datastart(1, 2) : subject3.dataend(1,2));

% subject1 peaks
f20_1 = subject1_standing / max(subject1_standing);
df20_1 = diff(f20_1); % derivative of this vector
threshold = 0.8; % peak treshold
ind_11 = find((f20_1(2:end-1)>threshold)&(df20_1(1:end-1)>0)&(df20_1(2:end)<0))+1; % the indices of all peaks in the first 20 second segment

% subject2 peaks
f20_2 = subject2_standing / max(subject2_standing);
df20_2 = diff(f20_2); % derivative of this vector
threshold = 0.8; % peak treshold
ind_12 = find((f20_2(2:end-1)>threshold)&(df20_2(1:end-1)>0)&(df20_2(2:end)<0))+1; % the indices of all peaks in the first 20 second segment

% subject3 peaks
f20_3 = subject3_standing / max(subject3_standing);
df20_3 = diff(f20_3); % derivative of this vector
threshold = 0.8; % peak treshold
ind_13 = find((f20_3(2:end-1)>threshold)&(df20_3(1:end-1)>0)&(df20_3(2:end)<0))+1; % the indices of all peaks in the first 20 second segment

% post exercise data
% extract exercise data for all subjects 
% NOTE: In Dr. Moyer's data, only Subject 1 had any data on post-exercise
% activity
subject1_exercise = subject1.data(subject1.datastart(1, 3) : subject1.dataend(1,3));
 
% subject1 peaks
g20_1 = subject1_exercise / max(subject1_exercise);
dg20_1 = diff(g20_1); % derivative of this vector
threshold = 0.8; % peak treshold
ind_111 = find((g20_1(2:end-1)>threshold)&(dg20_1(1:end-1)>0)&(dg20_1(2:end)<0))+1; % the indices of all peaks in the first 20 second segment

% table 3 - summary data

% post exercise data
meanExerciseSub1 = mean(subject1_exercise(ind_111))
stdExerciseSub1 = std(subject1_exercise(ind_111))

% standing data
meanStandingSub1 = mean(subject1_standing(ind_11))
meanStandingSub2 = mean(subject2_standing(ind_12))
meanStandingSub3 = mean(subject3_standing(ind_13))

stdStandingSub1 = std(subject1_standing(ind_11))
stdStandingSub2 = std(subject2_standing(ind_12))
stdStandingSub3 = std(subject3_standing(ind_13))

% sitting data
meanSittingSub1 = mean(subject1_sitting(ind_1))
meanSittingSub2 = mean(subject2_sitting(ind_2))
meanSittingSub3 = mean(subject3_sitting(ind_3))

stdSittingSub1 = std(subject1_sitting(ind_1))
stdSittingSub2 = std(subject2_sitting(ind_2))
stdSittingSub3 = std(subject3_sitting(ind_3))

% plot 
std_dev = [stdSittingSub1 stdSittingSub2 stdSittingSub3;
           stdStandingSub1 stdStandingSub2 stdStandingSub3];
figure 
y = [meanSittingSub1 meanSittingSub2 meanSittingSub3;
   meanStandingSub1 meanStandingSub2 meanStandingSub3 ];
bar1 = bar(y);
% set the x-axis labels
x = ["Sitting" "Standing"];
xticks(1:numel(x));  % set the x-ticks at positions 1 and 2
xticklabels(x);     % set the x-tick labels to the categories in 'x'
title("Average Amplitude for R Wave Across Team Members")
ylabel("Voltage (V)")
xlabel("Position")
legend("Subject 1", "Subject 2", "Subject 3")
hold on 
[groups, bars] = size(y);
x = nan(bars, groups);
for i = 1:bars
    x(i,:) = bar1(i).XEndPoints;
end
errorbar(x', y, std_dev, 'k', 'linestyle', 'none', 'HandleVisibility', 'off', "LineWidth", 1.5)
hold off
%%

%% Figure 6
% load data from exercise 3
sub1 = load('Lab3_Ex3_Sub1');
sub2 = load('Lab3_Ex3_Sub2');
sub3 = load('Lab3_Ex3_Sub3');

% set sample rate
sr = sub1.samplerate(1);

% extract ecg data for all subjects
sub1_ecg = sub1.data(sub1.datastart(3,1) : sub1.datastart(3,1) + 15 * sr);
sub2_ecg = sub2.data(sub2.datastart(3,1) : sub2.datastart(3,1) + 15 * sr);
sub3_ecg = sub3.data(sub3.datastart(3,1) : sub3.datastart(3,1) + 15 * sr);

% extract bvp data for all subjects
sub1_bvp = sub1.data(sub1.datastart(2,1) : sub1.datastart(2,1) + 15 * sr);
sub2_bvp = sub2.data(sub2.datastart(2,1) : sub2.datastart(2,1) + 15 * sr);
sub3_bvp = sub3.data(sub3.datastart(2,1) : sub3.datastart(2,1) + 15 * sr);

% time array
time_sub_1 = (1 : length(sub1_ecg)) /sr; 
time_sub_2 = (1 : length(sub2_ecg)) /sr;
time_sub_3 = (1 : length(sub3_ecg)) /sr;

figure (6)
subplot(2,1, 1)
% plot ECG in subplot 
hold on;
plot (time_sub_1, sub1_ecg, 'LineWidth',.55) % plot subject 1 ECG

plot(time_sub_1, sub2_ecg, 'LineWidth',.55) % plot subject 2 ECG

plot(time_sub_1, sub3_ecg, 'LineWidth',.55) % plot subject 3 ECG
hold off;
title('ECG Plot: All Group Members')
xlabel('Time(s)')
ylabel('ECG Amplitude (V)')
legend('Subject 1','Subject 2', 'Subject 3')

subplot(2, 1, 2)
hold on;
% plot bvp in subplot
plot (time_sub_1, sub1_bvp, 'LineWidth',1) % plot subject 1 bvp
plot(time_sub_2, sub2_bvp,'LineWidth',1) % plot subject 2 bvp
plot(time_sub_3, sub3_bvp,'LineWidth',1) % plot subject 3 bvp
hold off;

title('Blood Volume Pulse: All Group Members')
xlabel('Time(s)')
ylabel('Transducer Output (V)')
legend('Subject 1','Subject 2', 'Subject 3','Location', 'northwest')

% finding ecg peaks and other important information
% subject1 ecg threshold
e20_1 = sub1_ecg / max(sub1_ecg);
de20_1 = diff(e20_1); % derivative of this vector
threshold = 0.0005; % peak treshold
ind_1 = find((e20_1(2:end-1)>threshold)&(de20_1(1:end-1)>0)&(de20_1(2:end)<0))+1; % the indices of all peaks in the first 20 second segment

% subject2 ecg threshold
e20_2 = sub2_ecg / max(sub2_ecg);
de20_2 = diff(e20_2); % derivative of this vector
threshold = 0.0004; % peak treshold
ind_2 = find((e20_2(2:end-1)>threshold)&(de20_2(1:end-1)>0)&(de20_2(2:end)<0))+1;

% subject3 ecg threshold
e20_3 = sub3_ecg / max(sub3_ecg);
de20_3 = diff(e20_3); % derivative of this vector
threshold = 0.00035; % peak treshold, note large t-waves which may be counted?
ind_3 = find((e20_3(2:end-1)>threshold)&(de20_3(1:end-1)>0)&(de20_3(2:end)<0))+1;

% subject 1 peaks
time_1 = (1:length(e20_1))/sr;
MPH = threshold;
MPD = sr/2;
[~,locs_Rwave_s1] = findpeaks(e20_1,'MinPeakHeight',MPH,'MinPeakDistance',MPD);

% subject 2 peaks
time_2 = (1:length(e20_2))/sr;
MPH = threshold;
MPD = sr/2;
[~,locs_Rwave_s2] = findpeaks(e20_2,'MinPeakHeight',MPH,'MinPeakDistance',MPD);

% subject 3 peaks
time_3 = (1:length(e20_3))/sr;
MPH = threshold;
MPD = sr/2;
[~,locs_Rwave_s3] = findpeaks(e20_3,'MinPeakHeight',MPH,'MinPeakDistance',MPD);

% R-R interval subject 1, 2, & 3
rr_intervals_s1 = diff(locs_Rwave_s1) / sr;
rr_intervals_s2 = diff(locs_Rwave_s2) / sr;
rr_intervals_s3 = diff(locs_Rwave_s3) / sr;

% mean, max, min, std, and mean heart rate for subject 1
mean_rr_s1 = mean(rr_intervals_s1)
std_rr_s1 = std(rr_intervals_s1)
heart_rate_s1 = 60 / mean_rr_s1

% mean, max, min, std, and mean heart rate for subject 2
mean_rr_s2 = mean(rr_intervals_s2)
std_rr_s2 = std(rr_intervals_s2)
heart_rate_s2 = 60 / mean_rr_s2

% mean, max, min, std, and mean heart rate for subject 3
mean_rr_s3 = mean(rr_intervals_s3)
std_rr_s3 = std(rr_intervals_s3)
heart_rate_s3 = 60 / mean_rr_s3
std_hr_s3 = std(heart_rate_s3)

% bvp peaks
% subject1 bvp threshold
e20_1a = sub1_bvp / max(sub1_bvp);
de20_1a = diff(e20_1a); % derivative of this vector
threshold = 0.003; % peak treshold
ind_1a = find((e20_1a(2:end-1)>threshold)&(de20_1a(1:end-1)>0)&(de20_1a(2:end)<0))+1; % the indices of all peaks in the first 20 second segment

% subject2 bvp threshold
e20_2a = sub2_bvp / max(sub2_bvp);
de20_2a = diff(e20_2a); % derivative of this vector
threshold = 0.002; % peak treshold
ind_2a = find((e20_2a(2:end-1)>threshold)&(de20_2a(1:end-1)>0)&(de20_2a(2:end)<0))+1;

% subject3 bvp threshold
e20_3a = sub3_bvp / max(sub3_bvp);
de20_3a = diff(e20_3a); % derivative of this vector
threshold = 0.0025; % peak treshold
ind_3a = find((e20_3a(2:end-1)>threshold)&(de20_3a(1:end-1)>0)&(de20_3a(2:end)<0))+1;

% subject 1 bvp peaks
time_1a = (1:length(e20_1a))/sr;
MPH = threshold;
MPD = sr/2;
[~,locs_pulse_s1] = findpeaks(e20_1a,'MinPeakHeight',MPH,'MinPeakDistance',MPD);

% sub 2 bvp peaks
time_2a = (1:length(e20_2a))/sr;
MPH = threshold;
MPD = sr/2;
[~,locs_pulse_s2] = findpeaks(e20_2a,'MinPeakHeight',MPH,'MinPeakDistance',MPD);


% sub 3 bvp peaks
time_3a = (1:length(e20_3a))/sr;
MPH = threshold;
MPD = sr/2;
[~,locs_pulse_s3] = findpeaks(e20_3a,'MinPeakHeight',MPH,'MinPeakDistance',MPD);

% pulse interval subject 1, 2, & 3
pi_intervals_s1 = diff(locs_pulse_s1) / sr;
pi_intervals_s2 = diff(locs_pulse_s2) / sr;
pi_intervals_s3 = diff(locs_pulse_s3) / sr;

% mean, max, min, std, and mean heart rate for subject 1
mean_pi_s1 = mean(pi_intervals_s1)
std_pi_s1 = std(pi_intervals_s1)
pulse_rate_s1 = 60 / mean_pi_s1

% mean, max, min, std, and mean heart rate for subject 2
mean_pi_s2 = mean(pi_intervals_s2)
std_pi_s2 = std(pi_intervals_s2)
pulse_rate_s2 = 60 / mean_pi_s2

% mean, max, min, std, and mean heart rate for subject 3
mean_pi_s3 = mean(pi_intervals_s3)
std_pi_s3 = std(pi_intervals_s3)
pulse_rate_s3 = 60 / mean_pi_s3

% Figure 7
% load in data from exercise 4
sub1 = load('Lab3_Ex4_Sub1');
sub2 = load('Lab3_Ex4_Sub2');
sub3 = load('Lab3_Ex4_Sub3');

% set sample rate
sr = sub1.samplerate(1);

% extract above the head data
sub1_above = sub1.data(sub1.datastart(1,2) : sub1.datastart(1,2) + 15 * sr);
sub2_above = sub2.data(sub2.datastart(1,2) : sub2.datastart(1,2) + 15 * sr);
sub3_above = sub3.data(sub3.datastart(1,2) : sub3.datastart(1,2) + 15 * sr);

% extract below the head data
sub1_below = sub1.data(sub1.datastart(1,1) : sub1.datastart(1,1) + 15 * sr);
sub2_below = sub2.data(sub2.datastart(1,1) : sub2.datastart(1,1) + 15 * sr);
sub3_below = sub3.data(sub3.datastart(1,1) : sub3.datastart(1,1) + 15 * sr);

% create time array
time_sub_1 = (1 : length(sub1_above)) /sr;
time_sub_2 = (1 : length(sub2_above)) /sr;
time_sub_3 = (1 : length(sub3_above)) /sr;

% plot figure 7
figure (7)
subplot(2,1, 1)
hold on;
plot (time_sub_1, sub1_above, 'LineWidth',1) % plot subject 1 ECG

plot(time_sub_1, sub2_above, 'LineWidth',1) % plot subject 2 ECG

plot(time_sub_1, sub3_above, 'LineWidth',1) % plot subject 3 ECG
hold off;
title('Blood Volume Pulse Above Head: All Group Members')
xlabel('Time(s)')
ylabel('Transducer Output (V)')
legend('Subject 1','Subject 2', 'Subject 3')

subplot(2, 1, 2)

hold on;
plot(time_sub_1, sub1_below, 'LineWidth',1) % plot subject 1 bvp

plot(time_sub_2, sub2_below, 'LineWidth',1) % plot subject 2 bvp

plot(time_sub_3, sub3_below, 'LineWidth',1) % plot subject 3 bvp
hold off;

title('Blood Volume Pulse Below Hip: All Members')
xlabel('Time(s)')
ylabel('Transducer Output (V)')
legend('Subject 1','Subject 2', 'Subject 3')

% Figure 8 (bar graph)
% finding subject1 peaks
e20_1 = sub1_above / max(sub1_above);
de20_1 = diff(e20_1); % derivative of this vector
threshold = 0.8; % peak treshold
ind_1 = find((e20_1(2:end-1)>threshold)&(de20_1(1:end-1)>0)&(de20_1(2:end)<0))+1; % the indices of all peaks in the first 20 second segment

% finding subject2 peaks
e20_2 = sub2_above / max(sub2_above);
de20_2 = diff(e20_2); % derivative of this vector
threshold = 0.8; % peak treshold
ind_2 = find((e20_2(2:end-1)>threshold)&(de20_2(1:end-1)>0)&(de20_2(2:end)<0))+1;
% finding subject3 peaks
e20_3 = sub3_above / max(sub3_above);
de20_3 = diff(e20_3); % derivative of this vector
threshold = 0.8; % peak treshold
ind_3 = find((e20_3(2:end-1)>threshold)&(de20_3(1:end-1)>0)&(de20_3(2:end)<0))+1;

% find average of peaks / R  waves 
mean_sub1_above = mean(sub1_above(ind_1))
mean_sub2_above = mean(sub2_above(ind_2))
mean_sub3_above = mean(sub3_above(ind_3))

% finding subject1 peaks
f20_1 = sub1_below / max(sub1_below);
df20_1 = diff(f20_1); % derivative of this vector
threshold = 0.8; % peak treshold
ind_11 = find((f20_1(2:end-1)>threshold)&(df20_1(1:end-1)>0)&(df20_1(2:end)<0))+1; % the indices of all peaks in the first 20 second segment

% finding subject2 peaks
f20_2 = sub2_below / max(sub2_below);
df20_2 = diff(f20_2); % derivative of this vector
threshold = 0.8; % peak treshold
ind_12 = find((f20_2(2:end-1)>threshold)&(df20_2(1:end-1)>0)&(df20_2(2:end)<0))+1; % the indices of all peaks in the first 20 second segment

% subject3 peaks
f20_3 = sub3_below / max(sub3_below);
df20_3 = diff(f20_3); % derivative of this vector
threshold = 0.8; % peak treshold
ind_13 = find((f20_3(2:end-1)>threshold)&(df20_3(1:end-1)>0)&(df20_3(2:end)<0))+1; % the indices of all peaks in the first 20 second segment

% find average of peaks / R  waves 
mean_sub1_below = mean(sub1_below(ind_11))
mean_sub2_below = mean(sub2_below(ind_12))
mean_sub3_below = mean(sub3_below(ind_13))

% generate standard deviations of above and below conditions
std_sub1_above = std(sub1_above(ind_1))
std_sub2_above = std(sub2_above(ind_2))
std_sub3_above = std(sub3_above(ind_3))
std_sub1_below = std(sub1_below(ind_11))
std_sub2_below = std(sub2_below(ind_12))
std_sub3_below = std(sub3_below(ind_13))

% plot  as a bar graph with error bars
figure (8)
y = [mean_sub1_above mean_sub2_above mean_sub3_above ;
   mean_sub1_below mean_sub2_below mean_sub3_below ];

bar1 = bar(y);
% Set the x-axis labels
x = ["Avg Pulse Amp Above Head" "Avg Pulse Amp Below Hip"];
xticks(1:numel(x));  % set the x-ticks at positions 1 and 2
xticklabels(x);     % set the x-tick labels to the categories in 'x'
title("Pulse Amplitude with hands above head vs below hip")
ylabel("Voltage (V)")
xlabel("Position")
legend("Subject 1", "Subject 2", "Subject 3")
hold on 
std_dev = [std_sub1_above std_sub2_above std_sub3_above;
           std_sub1_below std_sub2_below std_sub3_below];
[groups, bars] = size(y);
x = nan(bars, groups);
for i = 1:bars
    x(i,:) = bar1(i).XEndPoints;
end

% plot error bar
errorbar(x', y, std_dev, 'k', 'linestyle', 'none', 'HandleVisibility', 'off', "LineWidth", 1.5)
hold off
%%
