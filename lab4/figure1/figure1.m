clear
close all

% load data and define samplerate 
fredrik = load('fredrik_ex2.mat');
sr = fredrik.samplerate(1);

% fredrik blood pressure and pulse data
fredrik_blood_pressure = fredrik.data(fredrik.datastart(1, 1) : fredrik.dataend(1, 1));
fredrik_pulse = fredrik.data(fredrik.datastart(2, 1) : fredrik.dataend(2, 1));
timef = (0 : length(fredrik_blood_pressure)-1);

% plots within a 1x2 subplot
figure(1);
hold on
subplot(2, 1, 1);
plot(timef / sr, fredrik_blood_pressure);
xlabel("Time (s)");
ylabel("Blood Pressure (mmHG)");
hold off

figure(1);
hold on
subplot(2, 1, 2);
title("Fredrik Pulse");
xlabel("Time (s)");
ylabel("Pulse Wave Magnitude");
hold off
