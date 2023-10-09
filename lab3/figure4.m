
subject1 = load('Lab3_Ex2_Sub1.mat');

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
