
% R-R intervals for subject1
subject1 = load('Lab3_Ex2_Sub1.mat');
subject1_sitting = subject1.data(subject1.datastart(1, 1) : subject1.dataend(1,1));

% define samplerate
sr = subject1.samplerate(1);

e20 = subject1_sitting/max(subject1_sitting);
de20 = diff(e20); %and the derivative of this vector
threshold = 0.8; %Adjust this on your own
ind = find((e20(2:end-1)>threshold)&(de20(1:end-1)>0)&(de20(2:end)<0))+1; % the indices of all peaks in the first 20 second segment

%UNCOMMENT THIS FOR SECOND PLOT
%figure(1);
% plot(e20);
% title('ECG');
% xlabel('Time (s)'); %Fix this on your own
% ylabel('ECG');
hold on;
%plot(ind, e20(ind),'r*');


% now we need to create the corresponding time vector
S = subject1.samplerate(1);
dt = 1/S;
time = (1:length(e20))/S;
figure(2)
plot(time, e20)
hold on
plot(time(ind), e20(ind),'r*');
xlabel('time (s)')
ylabel('Amplitude a.u.')
axis([0 10 -1.1 1.1])
MPH = threshold;
MPD = S/2;

[~,locs_Rwave] = findpeaks(e20,'MinPeakHeight',MPH,'MinPeakDistance',MPD);
hold on
plot(time(locs_Rwave), e20(locs_Rwave),'g*');

% get all R-R intervals for subject 1 (in seconds)
rr_intervals_s1 = diff(locs_Rwave) / sr;

% mean, max, min, and std for subject 1
mean_rr_s1 = mean(rr_intervals_s1);
max_rr_s1 = max(rr_intervals_s1);
min_rr_s1 = min(rr_intervals_s1);
std_rr_s1 = std(rr_intervals_s1);
