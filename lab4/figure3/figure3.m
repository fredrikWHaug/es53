clear
close all

% load data and define samplerate 
lydia = load('lydia_ex2.mat');
sr = lydia.samplerate(1);

% specific blood pressure and pulse data based on channels and blocks
lydia_blood_pressure = lydia.data(lydia.datastart(1, 1) : lydia.dataend(1, 1));
lydia_pulse = lydia.data(lydia.datastart(2, 1) : lydia.dataend(2, 1));
timel = (0 : length(lydia_blood_pressure)-1);

% plots within a 1x2 subplot
figure(3);
hold on
subplot(2, 1, 1);
plot(timel, lydia_blood_pressure);
title("Lydia Blood Pressure")
xlabel("Time (s) - REMEMBER TO CONFIGURE");
ylabel("Blood Pressure (mmHG)");
hold off

figure(3);
hold on
subplot(2, 1, 2);
plot(timel, lydia_pulse);
title("Lydia Pulse")
xlabel("Time (s) REMEMBER TO CONFIGURE");
ylabel("N/A");
hold off
