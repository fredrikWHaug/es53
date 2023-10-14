%% ENG-SCI 53 Lab 3
% Filename: es53_lab4_laf.m
% Author: Abby Yoon, Lydia, Lydia Shimelis, Fredrik Willumsen Haug
% Created: October 14th 
% Description: Blood Pressure and Blood Flow
%%

%% Figure 1
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
plot(timef, fredrik_blood_pressure);
title("Fredrik Blood Pressure")
xlabel("Time (s) - REMEMBER TO CONFIGURE");
ylabel("Blood Pressure (mmHG)");
hold off

figure(1);
hold on
subplot(2, 1, 2);
plot(timef, fredrik_pulse);
title("Fredrik Pulse")
xlabel("Time (s) REMEMBER TO CONFIGURE");
ylabel("N/A");
hold off
%%

%% Figure 2
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
%%

%% Figure 3
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
%%
