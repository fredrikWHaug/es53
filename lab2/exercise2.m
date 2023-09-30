clear all
close all
%% 2.1
% loading struct
abby = load('Lab1_Ex2_Abby.mat');

% dt
dt = 1/abby.samplerate(1);

% start time and end time for two cycles of contraction based on visuals
start_time = 58 * abby.samplerate(1);
end_time = 80 * abby.samplerate(1);

% line 14 through 36 extracts and plots raw and RMS data for tricep

% block and channels for raw bicep (single group member)
bn_tricep = 1; 
chn_tricep = 4;

% block and channels for rms bicep (single group member)
bn_rms_tricep = 1;
chn_rms_tricep = 2;

% data extraction for raw tricep based on looking at ADI data
start_tricep = abby.datastart(chn_tricep,bn_tricep) + start_time; % starting index point for tricep
end_tricep = abby.datastart(chn_tricep,bn_tricep) + end_time; % end of cycle 2 index for tricep 
two_tricep_cycles = abby.data(start_tricep:end_tricep); % entire two cycle data

% data extraction for tricep rms
start_rms_tricep = abby.datastart(chn_rms_tricep, bn_rms_tricep) + start_time;
end_rms_tricep = abby.datastart(chn_rms_tricep, bn_rms_tricep) + end_time;
two_tricep_cycles_rms = abby.data(start_rms_tricep : end_rms_tricep);

% time for tricep vector
t = [0:length(two_tricep_cycles)-1]*dt;

figure(1);
subplot(2, 1, 1);
hold on
plot(t, two_tricep_cycles);
plot(t, two_tricep_cycles_rms, 'r');
hold off
xlabel('Time (s)');
ylabel('Tricep EMG amplitude');

% line 33 through 55 extracts data for bicep

% block and channels for bicep (single group member)
bn_bicep = 1; 
chn_bicep = 3;

% block and channels for rms bicep (single group member)
bn_rms_bicep = 1;
chn_rms_bicep = 1;

% data extraction for raw bicep based on looking at ADI data
start_bicep = abby.datastart(chn_bicep,bn_bicep) + start_time; % starting index point for bicep
end_bicep = abby.datastart(chn_bicep,bn_bicep) + end_time; % end of cycle 2 index for bicep 
two_bicep_cycles = abby.data(start_bicep:end_bicep); % entire two cycle data

% data extraction for bicep rms
start_rms_bicep = abby.datastart(chn_rms_bicep, bn_rms_bicep) + start_time;
end_rms_bicep = abby.datastart(chn_rms_bicep, bn_rms_bicep) + end_time;
two_bicep_cycles_rms = abby.data(start_rms_bicep : end_rms_bicep);

% time for bicep vector
t = [0:length(two_bicep_cycles)-1]*dt;

figure(1);
subplot(2, 1, 2);
hold on
plot(t, two_bicep_cycles);
plot(t, two_bicep_cycles_rms);
hold off
xlabel('Time (s)');
ylabel('Bicep EMG amplitude');
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

x = categorical({' ','Biceps',' ', 'Triceps'});
xticklabels(x);

er = errorbar(y,err);                  
er.LineStyle = 'none';  

hold off
%%