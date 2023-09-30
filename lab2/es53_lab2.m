%%
% FileName: es53_lab2.m
% Author: Aaron Bradford, Fredrik Willumsen Haug
% Created: September 30, 2023
% Description: source code for lab 2
%%

clear all
close all
%% Figure 1
b = load('Lab1_Ex2_Coby.mat');

dt = 1/b.samplerate(1);

% Selects data based on timestamps
bfromtri = b.datastart(4,1)+26*b.samplerate(1)-1;
btotri = b.datastart(4,1) + 50*b.samplerate(1)-1;
bsniptri = b.data(bfromtri:btotri);
t = [0:length(bsniptri)-1]*dt;
figure (1), subplot(2,1,1);
plot(t, bsniptri, 'blue');
xlabel('Time (Sec)')
ylabel ('Tricep EMG or RMS Amplitude (mV)')

[up, lo] = envelope(bsniptri, 50, 'rms');
hold on
plot(t, up, 'red', 'LineWidth',3)
hold off

% Selects data based on timestamps
bfrombi = b.datastart(3,1)+26*b.samplerate(1)-1; 
btobi = b.datastart(3,1) + 50*b.samplerate(1)-1; 
bsnipbi = b.data(bfrombi:btobi); 
t = [0:length(bsnipbi)-1]*dt;
figure (1), subplot(2,1,2);
plot(t, bsnipbi, 'blue');
xlabel('Time (Sec)')
ylabel ('Bicep EMG or RMS Amplitude (mV)')

[up, lo] = envelope(bsnipbi, 50, 'rms');
hold on
plot(t, up, 'red', 'LineWidth',3)
hold off
%%


%% Table 1 and Figure 2
% Bicep Contraction
bsniptri1 = b.data(b.datastart(2,1)+29*b.samplerate(1)-1:b.datastart(2,1) + 34*b.samplerate(1)-1); %select data between "from" and "to"

bsnipbi1 = b.data(b.datastart(1,1)+29*b.samplerate(1)-1:b.datastart(1,1) + 34*b.samplerate(1)-1); %select data between "from" and "to"

bsniptri2 = b.data(b.datastart(2,1)+40*b.samplerate(1)-1:b.datastart(2,1) + 45*b.samplerate(1)-1); %select data between "from" and "to"

bsnipbi2 = b.data(b.datastart(1,1)+40*b.samplerate(1)-1:b.datastart(1,1) + 45*b.samplerate(1)-1); %select data between "from" and "to"

abirms = mean(bsniptri1 + bsniptri2);

atrirms = mean(bsnipbi1 + bsnipbi2);

aratio = (bsnipbi1 + bsnipbi2)/(bsniptri1 + bsniptri2);

% Tricep Contraction

bsniptrir1 = b.data(b.datastart(2,1)+34*b.samplerate(1)-1:b.datastart(2,1) + 41*b.samplerate(1)-1); %select data between "from" and "to"

bsnipbir1 = b.data(b.datastart(1,1)+34*b.samplerate(1)-1:b.datastart(1,1) + 41*b.samplerate(1)-1); %select data between "from" and "to"

bsniptrir2 = b.data(b.datastart(2,1)+45*b.samplerate(1)-1:b.datastart(2,1) + 52*b.samplerate(1)-1); %select data between "from" and "to"

bsnipbir2 = b.data(b.datastart(1,1)+45*b.samplerate(1)-1:b.datastart(1,1) + 52*b.samplerate(1)-1); %select data between "from" and "to"

bbirms = mean(bsniptrir1 + bsniptrir2);

btrirms = mean(bsnipbir1 + bsnipbir2);

bratio = (bsniptrir1 + bsniptrir2)/(bsnipbir1 + bsnipbir2);

b1 = load('Lab1_Ex2_Abby.mat');

% Bicep Contraction
absniptri1 = b1.data(b1.datastart(2,1)+29*b1.samplerate(1)-1:b1.datastart(2,1) + 34*b1.samplerate(1)-1); %select data between "from" and "to"

absnipbi1 = b1.data(b1.datastart(1,1)+29*b1.samplerate(1)-1:b1.datastart(1,1) + 34*b1.samplerate(1)-1); %select data between "from" and "to"

absniptri2 = b1.data(b1.datastart(2,1)+40*b1.samplerate(1)-1:b1.datastart(2,1) + 45*b1.samplerate(1)-1); %select data between "from" and "to"

absnipbi2 = b1.data(b1.datastart(1,1)+40*b1.samplerate(1)-1:b1.datastart(1,1) + 45*b1.samplerate(1)-1); %select data between "from" and "to"

aabirms = mean(absniptri1 + absniptri2);

aatrirms = mean(absnipbi1 + absnipbi2);

aaratio = (absnipbi1 + absnipbi2)/(absniptri1 + absniptri2);

% Tricep Contraction

absniptrir1 = b1.data(b1.datastart(2,1)+34*b1.samplerate(1)-1:b1.datastart(2,1) + 41*b1.samplerate(1)-1); %select data between "from" and "to"

absnipbir1 = b1.data(b1.datastart(1,1)+34*b1.samplerate(1)-1:b1.datastart(1,1) + 41*b1.samplerate(1)-1); %select data between "from" and "to"

absniptrir2 = b1.data(b1.datastart(2,1)+45*b1.samplerate(1)-1:b1.datastart(2,1) + 52*b1.samplerate(1)-1); %select data between "from" and "to"

absnipbir2 = b1.data(b1.datastart(1,1)+45*b1.samplerate(1)-1:b1.datastart(1,1) + 52*b1.samplerate(1)-1); %select data between "from" and "to"

abbirms = mean(absniptrir1 + absniptrir2);

abtrirms = mean(absnipbir1 + absnipbir2);

abratio2 = (absniptrir1 + absniptrir2)/(absnipbir1 + absnipbir2);

b2 = load('Lab1_Ex2_Benji.mat');

% Bicep Contraction
bbsniptri1 = b2.data(b2.datastart(2,1)+29*b2.samplerate(1)-1:b2.datastart(2,1) + 34*b2.samplerate(1)-1); %select data between "from" and "to"

bbsnipbi1 = b2.data(b2.datastart(1,1)+29*b2.samplerate(1)-1:b2.datastart(1,1) + 34*b2.samplerate(1)-1); %select data between "from" and "to"

bbsniptri2 = b2.data(b2.datastart(2,1)+40*b2.samplerate(1)-1:b2.datastart(2,1) + 45*b2.samplerate(1)-1); %select data between "from" and "to"

bbsnipbi2 = b2.data(b2.datastart(1,1)+40*b2.samplerate(1)-1:b2.datastart(1,1) + 45*b2.samplerate(1)-1); %select data between "from" and "to"

babirms = mean(bbsniptri1 + bbsniptri2);

batrirms = mean(bbsnipbi1 + bbsnipbi2);

baratio = (bbsnipbi1 + bbsnipbi2)/(bbsniptri1 + bbsniptri2);

% Tricep Contraction

bbsniptrir1 = b2.data(b2.datastart(2,1)+34*b2.samplerate(1)-1:b2.datastart(2,1) + 41*b2.samplerate(1)-1); %select data between "from" and "to"

bbsnipbir1 = b2.data(b2.datastart(1,1)+34*b2.samplerate(1)-1:b2.datastart(1,1) + 41*b2.samplerate(1)-1); %select data between "from" and "to"

bbsniptrir2 = b2.data(b2.datastart(2,1)+45*b2.samplerate(1)-1:b2.datastart(2,1) + 52*b2.samplerate(1)-1); %select data between "from" and "to"

bbsnipbir2 = b2.data(b2.datastart(1,1)+45*b2.samplerate(1)-1:b2.datastart(1,1) + 52*b2.samplerate(1)-1); %select data between "from" and "to"

bbbirms = mean(bbsniptrir1 + bbsniptrir2);

bbtrirms = mean(bbsnipbir1 + bbsnipbir2);

bbratio2 = (bbsniptrir1 + bbsniptrir2)/(bbsnipbir1 + bbsnipbir2);


% Mean ratios
% Bicep Contrations
meanratiobi = (aratio +aaratio + baratio)/3;
meanratiotri = (bratio +abratio2 + bbratio2)/3;

x = [1,2];

y = [meanratiobi, meanratiotri];
err = [0.1 0.1];

figure (2)
hold on
bar(x,y,"FaceColor","white");

x = categorical({' ','Biceps Contracting',' ', 'Triceps Contracting'});
xticklabels(x);
ylabel('Ratio');

er = errorbar(y,err);                  
er.LineStyle = 'none';  

hold off

% Standard Deviations
A = [aratio, aaratio, baratio];
B = [bratio, abratio2, bbratio2];

Bicep_S = std(A);
Tricep_S = std(B);
%%

clear all
close all

%% Data Load exercise 3
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

group_max_force_data = [michael_max_region, fredrik_max_region, salaidh_max_region, aaron_max_region];
group_max_data_force_mean = mean(group_data);
group_max_data_std = std(group_data);

% table generation
force = {'Max (%)'};
michael = michael_max;
fredrik = fredrik_max;
salaidh = salaidh_max;
aaron= aaron_max;
average = group_mean;
std = group_std;

table2 = table(force, michael, fredrik, salaidh, aaron, average, std);
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

group_closed_eyes_data = [michael_closed_eyes, fredrik_closed_eyes, salaidh_closed_eyes, aaron_closed_eyes];

group_closed_eyes_variance = var(group_closed_eyes_data);

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