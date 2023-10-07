subject1 = load('Lab3_Ex2_Sub1.mat');
subject2 = load('Lab3_Ex2_Sub2.mat');
subject3 = load('Lab3_Ex2_Sub3.mat');

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