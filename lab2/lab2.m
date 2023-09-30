clear all
close all
%% Data Load
michael = load("Lab2_Ex1_Michael.mat");
aaron = load("Lab2_Ex1_Aaron.mat");
salaidh = load("lab2_ex1_salaidh.mat");
fredrik = load("Lab2_Ex1_Fredrik.mat");
%%

%% 3.1
% get maximum region for michael
michael_max_region = michael.data(michael.datastart(1, 6) + 30 : michael.dataend(1, 6) - 35);

% get max force recorded, mean, and std for michael
michael_max = max(michael_max_region)
michael_mean = mean(michael_max_region)
michael_std = std(michael_max_region)

% get maximum region for fredrik
fredrik_max_region = fredrik.data(fredrik.datastart(1, 6) + 30 : fredrik.dataend(1, 6) - 35);

% get max force recorded, mean, and std for fredrik
fredrik_max = max(fredrik_max_region)
fredrik_mean = mean(fredrik_max_region)
fredrik_std = std(fredrik_max_region)


% get maximum region for salaidh
salaidh_max_region = salaidh.data(salaidh.datastart(1, 6) + 25 : salaidh.dataend(1, 6));

% get max force recorded, mean, and std for salaidh
salaidh_max = max(salaidh_max_region)
salaidh_mean = mean(salaidh_max_region)
salaidh_std = std(salaidh_max_region)


% get maximum regoon for Aaron
aaron_max_region = aaron.data(aaron.datastart(1, 6) + 50 : aaron.dataend(1, 6) - 55);

% get max force recorded, mean, and std for salaidh
aaron_max = max(aaron.data(aaron.datastart(1, 6) : aaron.dataend(1, 6)))
aaron_mean = mean(aaron_max_region)
aaron_std = std(aaron_max_region)

% table generation
name = {'Michael';'Fredrik';'Salaidh';'Aaron'};
max_force_percent = [michael_max;fredrik_max;salaidh_max;aaron_max];
mean_force = [michael_mean;fredrik_mean;salaidh_mean;aaron_mean];
std = [michael_std;fredrik_std;salaidh_std;aaron_std];

table2 = table(name, max_force_percent, mean_force, std);
%%

%% 3.2
% NOTE: we do not have consistent comments for all .mat files, so to get the 
% 20 second region of closed eyes we subtract the first and last 200 data
% points, because the total recording is 800 data points and we want the 
% middle 400

% define samle rate for time axis
dt = 1 / michael.samplerate(1);

% extracting closed eyes section, creating time vector, and calculating
% variance for michael
michael_closed_eyes = michael.data(michael.datastart(1, 8) + 200 : michael.dataend(1, 8) - 240);
t_michael = [1:length(michael_closed_eyes)] * dt;
variance_closed_eyes_michael = var(michael_closed_eyes);

% extracting closed eyes section, creating time vector, and calculating
% variance for fredrik
fredrik_closed_eyes = fredrik.data(fredrik.datastart(1, 8) + 200 : fredrik.dataend(1, 8) - 235);
t_fredrik = [1:length(fredrik_closed_eyes)] * dt;
variance_closed_eyes_fredrik = var(fredrik_closed_eyes);

% extracting closed eyes section, creating time vector, and calculating
% variance for salaidh
salaidh_closed_eyes = salaidh.data(salaidh.datastart(1, 8) + 200 : salaidh.dataend(1, 8) - 300);
t_salaidh = [1:length(salaidh_closed_eyes)] * dt;
variance_closed_eyes_salaidh = var(salaidh_closed_eyes);

% extracting closed eyes section, creating time vector, and calculating
% variance for michael
aaron_closed_eyes = aaron.data(aaron.datastart(1, 8) + 200 : aaron.dataend(1, 8) - 230);
t_aaron = [1:length(aaron_closed_eyes)] * dt;
variance_closed_eyes_aaron = var(aaron_closed_eyes);

% plotting 
figure(4);
hold on
plot(t_michael, michael_closed_eyes);
plot(t_fredrik, fredrik_closed_eyes);
plot(t_salaidh, salaidh_closed_eyes);
plot(t_aaron, aaron_closed_eyes);
hold off
axis([0 20 0 60]);
xlabel('Time (s)');
ylabel('Force (%)');
legend('Michael', 'Fredrik', 'Salaidh', 'Aaron');
%%

%% 3.3
dt = 1 / michael.samplerate(1);

michael_fatigue = michael.data(michael.datastart(1, 6) : michael.dataend(1, 6));
t_michael = [1:length(michael_fatigue)] * dt;

fredrik_fatigue = fredrik.data(fredrik.datastart(1, 6) : fredrik.dataend(1, 6));
t_fredrik = [1:length(fredrik_fatigue)] * dt;

salaidh_fatigue = salaidh.data(salaidh.datastart(1, 6) : salaidh.dataend(1, 6));
t_salaidh = [1:length(salaidh_fatigue)] * dt;

aaron_fatigue = aaron.data(aaron.datastart(1, 6) : aaron.dataend(1, 6));
t_aaron = [1:length(aaron_fatigue)] * dt;

figure(3);
hold on
plot(t_michael, michael_fatigue);
plot(t_fredrik, fredrik_fatigue);
plot(t_salaidh, salaidh_fatigue);
plot(t_aaron, aaron_fatigue);
hold off
axis([0 20, 0 160]);
xlabel('Time (s)')
ylabel('Force (%)');
legend('Michael', 'Aaaron', 'Salaidh', 'Fredrik');
%%