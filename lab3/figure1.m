% loading data from subject 1 exercise 1
ex1 = load('Lab3_Ex1_Sub1.mat');

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
