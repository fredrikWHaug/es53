
% section load in case it's helpful
fredrik = load('fredrik_ex2.mat');
abby = load('abby_ex2.mat');
lydia = load('lydia_ex2.mat');

% samplerate declaration
S = fredrik.samplerate(1);

% pulse for each subject
fredrik_pulse = fredrik.data(fredrik.datastart(2, 1) : fredrik.dataend(2, 1));
abby_pulse = abby.data(abby.datastart(2, 1) : abby.dataend(2, 1));
lydia_pulse = lydia.data(lydia.datastart(2, 1) : lydia.dataend(2, 1));

% fredrik peaks
e20_1 = fredrik_pulse / max(fredrik_pulse);
de20_1 = diff(e20_1); % derivative of this vector
threshold = 0; % peak treshold
ind_1 = find((e20_1(2:end-1)>threshold)&(de20_1(1:end-1)>0)&(de20_1(2:end)<0))+1; % the indices of all peaks in the first 20 second segment

% abby peaks
e20_abby = abby_pulse / max(abby_pulse);
de20_abby = diff(e20_abby); % derivative of this vector
threshold = 0; % peak treshold
ind_1 = find((e20_abby(2:end-1)>threshold)&(de20_abby(1:end-1)>0)&(de20_abby(2:end)<0))+1; % the indices of all peaks in the first 20 second segment

% abby peaks
e20_lydia = lydia_pulse / max(lydia_pulse);
de20_lydia = diff(e20_lydia); % derivative of this vector
threshold = 0; % peak treshold
ind_1 = find((e20_lydia(2:end-1)>threshold)&(de20_lydia(1:end-1)>0)&(de20_lydia(2:end)<0))+1; % the indices of all peaks in the first 20 second segment

% fredrik plot
time_1 = (1:length(e20_1))/S;
figure(4);
subplot(3, 1, 1);
plot(time_1, e20_1);
hold on
xlabel('time (s)');
ylabel('Pulse Wave Magnitude');
axis([0 10 -1.1 1.1]);
MPH = threshold;
MPD = S/2;
[~,locs_Rwave_s1] = findpeaks(e20_1,'MinPeakHeight',MPH,'MinPeakDistance',MPD);
plot(time_1(locs_Rwave_s1), e20_1(locs_Rwave_s1),'r*');
hold off

% abby plot
timea = (1:length(e20_abby))/S;
figure(4);
subplot(3, 1, 2);
plot(timea, e20_abby);
hold on
xlabel('time (s)');
ylabel('Pulse Wave Magnitude');
axis([0 10 -1.1 1.1]);
MPH = threshold;
MPD = S/2;
[~,locs_Rwave_s2] = findpeaks(e20_abby,'MinPeakHeight',MPH,'MinPeakDistance',MPD);
plot(timea(locs_Rwave_s2), e20_abby(locs_Rwave_s2),'r*');
hold off

% lydia plot
timel = (1:length(e20_lydia))/S;
figure(4);
subplot(3, 1, 3);
plot(timel, e20_lydia);
hold on
xlabel('Time (s)');
ylabel('Pulse Wave Magnitude');
axis([0 10 -1.1 1.1]);
MPH = threshold;
MPD = S/2;
[~,locs_Rwave_s3] = findpeaks(e20_lydia,'MinPeakHeight',MPH,'MinPeakDistance',MPD);
plot(timel(locs_Rwave_s3), e20_lydia(locs_Rwave_s3),'r*');
hold off
