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