subject1 = load('Lab3_Ex2_Sub1.mat');
subject2 = load('Lab3_Ex2_Sub2.mat');
subject3 = load('Lab3_Ex2_Sub3.mat');

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