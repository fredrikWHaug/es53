clear
close all

% load data and define samplerate 
abby = load('abby_ex2.mat');
sr = abby.samplerate(1);

% specific blood pressure and pulse data based on channels and blocks
abby_blood_pressure = abby.data(abby.datastart(1, 1) : abby.dataend(1, 1));
abby_pulse = abby.data(abby.datastart(2, 1) : abby.dataend(2, 1));
timea = (0 : length(abby_blood_pressure)-1);

% plots within a 1x2 subplot
figure(2);
hold on
subplot(2, 1, 1);
plot(timea, abby_blood_pressure);
title("Abby Blood Pressure")
xlabel("Time (s) - REMEMBER TO CONFIGURE");
ylabel("Blood Pressure (mmHG)");
hold off

figure(2);
hold on
subplot(2, 1, 2);
plot(timea, abby_pulse);
title("Abby Pulse")
xlabel("Time (s) REMEMBER TO CONFIGURE");
ylabel("N/A");
hold off
