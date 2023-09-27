%% Code for ENG-SCI 53 Problem Set 2: Hodgkin Huxley Model and Muscle Tension vs. Velocity
% Filename: Problem Set 2
% Author: Fredrik Willumsen Haug
% Creaed: September 19th, 2023
% Last Edited: September 26th, 2023
% Description: Problem Set 2
%%

%% Question 1

%% 1a
% running function and storing output vectors
[t, y] = run_hh_model(8, 100, 0.1);

% subplot 1
figure(1);
subplot(3,1,1);
plot(t, y(:, 1));% extracting membrane potential from the state vector
xlabel('Time (ms)');
ylabel('Vm (mV)');

% n gate constants
nInf = 0.9494;
Tn = 1.2028;

% m gate constants
mInf = 0.9953;
Tm = 0.1577;

% h gate constants
hInf = 0.0009;
Th = 1.0022;

nt = nInf - ((nInf - y(:, 4)) .* exp(1).^(-t/Tn));
mt = mInf - ((mInf - y(:, 2)) .* exp(1).^(-t/Tm));
ht = hInf - ((hInf - y(:, 3)) .* exp(1).^(-t/Th));

gkt = ((nt).^4) .* 36;
gnat = ((mt.^3)) .* (ht) .* (120);

% subplot 2
figure(1);
subplot(3, 1, 2);
hold on
plot(t, gkt);
plot(t, gnat);
hold off
xlabel('Time (ms)');
ylabel('Conductance (mS)'); 

% subplot 3
figure(1);
subplot(3, 1, 3);
hold on 
plot(t, y(:, 2));
plot(t, y(:, 3));
plot(t, y(:, 4));
hold off
xlabel('Time (ms)');
ylabel('Probability'); 
%%

%% 1b
figure(2);
hold on
for i=1:101
[t, y] = run_hh_model(8, i, 0.1);
plot(t, y(:, 1));
end
ylabel('Membrane Potential (mV)');
xlabel('Time (ms)');
hold off
%%

%% 1c
peak = [];
current = [];

for i=1:101
    [t, y] = run_hh_model(20, i, 0.1);
    membrane = y(:, 1);
    peak = [peak, max(membrane)];
    current = [current, i];
end
figure(3);
hold on
xlim([0, 100]);
plot(current, peak, Marker='o',MarkerFaceColor='blue');
xlabel('Amplitude of 0.1 Current Pulse (uA/cm)');
ylabel('Peak Depolarization (mV)');
hold off
%%

%% 1d
[t1, y1] = run_hh_model(15, 16, 0.1);
vmembrane1 = y1(:, 1);
[t2, y2] = run_hh_model(15, 80, 0.1);
vmembrane2 = y2(:, 1);

figure(4);
plot(t1, vmembrane1);
hold on
plot(t2, vmembrane2);
xlabel('Time (ms)');
ylabel('Membrane Potential mV');
legend('barely supertreshold', 'fully supertreshold');
hold off
%%

%%

%% Question 5

%% 5a
a = 20;
b = 0.2;
vmax = 1;
t0 = (vmax * a) / b;
t = linspace(0, 200);
v = b*(t0 - t) ./ (t + a);

figure(5);
plot(t, v);
xlabel('Tension (N)');
ylabel('Velocity (m/s)');
%%

%% 5b
t = linspace(0, 200);
na = linspace(5, 30, 6);
nb = linspace(0.05, 0.30, 6); % calculated by vmax = t0*b/a

figure(6);
hold on
for i = 1:6
    v = nb(i) * (t0 - t) ./ (t + na(i));
    plot(t, v);
    xlabel('Force (N)');
    ylabel('Velocity (m/s)');
    legend('a = 5N', 'a = 10N', 'a = 15N', 'a = 20N', 'a = 25N', 'a = 30N')
end
hold off
%%

%%

%% Tetany Code With Comments

%%
% tetany.m - simulates the summation of muscle twitches to reach tetany
% For ES 53, designed by L. Moyer
% Last modified 9/16/22
% Students – please add comments to show that you understand
% what is going on in each line of this code
clear all
close all

dt = 10; % time period between twitches in ms

frequency = 1/dt; % twitch frequency
numtwitches = 25; % number of twitches to initiate
x = [0:0.1:40];
twamp = zeros(1,2001);
twamps = zeros(1,2001);

% Generate time delayed twitches and sum
for i= 1:numtwitches;
y(i,:) = gampdf(x,3,1); %approximates a fast twitch response
start = round((i-1)*dt)+1;
twamp(i,start:(start+length(x)-1)) = y(i,:);
end

tetf = sum(twamp,1);
figure(5)
subplot(211)
plot(tetf,'r')
axis([0 500 0 1.1*max(max(tetf))])
xlabel('Time (ms)')
ylabel('Twitch Force (a.u.)')
legend('Fast Twitch','location','southeast')

% Now you generate time delayed slow twitches and sum them.
% Write your own code (or modify below) and plot your results in subplot(212)in
% blue

for j= 1:numtwitches;
y2(j,:) = gampdf(x,3,4); %approximates a slow twitch response
star = round((j-1)*dt)+1;
twamps(j,star:(star+length(x)-1)) = y2(j,:);
end
tets = sum(twamps,1);

subplot(212)
plot(tets,'b')
axis([0 500 0 1.1*max(max(tets))])
xlabel('Time (ms)')
ylabel('Twitch Force (a.u.)')
legend('Slow Twitch','location','southeast')
%%

%%
