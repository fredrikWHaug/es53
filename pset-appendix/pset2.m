%% Code for ENG-SCI 53 Problem Set 2: Hodgkin Huxley Model and Muscle Tension vs. Velocity
% Filename: lab0
% Author: Fredrik Willumsen Haug
% Created: September 19th, 2023
% Description: Problem Set 1
%%

%% Question 1

%% 1a
% running function and storing output vectors
[t, y] = run_hh_model(8, 100, 0.1);

% subplot 1
subplot(3,1,1);
plot(y(:, 1));% extracting membrane potential from the state vector
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
subplot(3, 1, 2);
hold on
plot(gkt);
plot(gnat);
hold off
xlabel('Time (ms)');
ylabel('Conductance [INSERT UNIT HERE]'); % remember to update unit

% subplot 3
subplot(3, 1, 3);
hold on 
plot(y(:, 2));
plot(y(:, 3));
plot(y(:, 4));
hold off
xlabel('Time (ms)');
ylabel('Probabilities [INSERT UNIT HERE]'); % remember to insert unit
%%

%% 1b
figure(2);
hold on
for i=0:101
[t, y] = run_hh_model(8, i, 0.1);
plot(t, y(:, 1));
end
ylabel('Vm (mV)');
xlabel('Time (ms)');
hold off
%%

%% 1c
% do scatter here to match the pset handout
peak = [];
current = [];
for i=0:100
    [t, y] = run_hh_model(8, i, 0.1);
    membrane = y(:, 1);
    peak = [peak, max(membrane)];
    current = [current, i];
end
figure;
hold on
scatter(current, peak); % check scatter situation here
plot(current, peak, 'b');
hold off
%%

%% 1d
[t1, y1] = run_hh_model(15, 16, 0.1);
vmembrane1 = y1(:, 1);
[t2, y2] = run_hh_model(15, 80, 0.1);
vmembrane2 = y2(:, 1);

figure;
plot(t1, vmembrane1);
hold on
plot(t2, vmembrane2);
xlabel('Time (ms)');
ylabel('Vm (mV)');
legend('Barely treshold', 'fully treshold');
hold off
%%

%%

%% Question 5

%% 5a
a = 20;
b = 0.2;
vmax = 1;
t=0;
t0 = 100;
tension = (0:100);
v = ((b .* (t0+a)) ./ (tension+a)) - b;

figure;
plot(tension, v);
xlabel('Tension (N)');
ylabel('Velocity (m/s)');
%%

%% 5b
a = linspace(5, 30, 6);
b = linspace(0.05, 0.3, 6);
vmax = 1;
t = 0;
t0 = 100;
tension = (0:100);
figure;
hold on
for i=1:length(b)
    aloop = a(i);
    bloop = b(i);
    v = (bloop .* (t0 + aloop)) ./ ((tension + aloop) - bloop);
    plot(tension, v);
    xlabel('Tension (N)');
    ylabel('Velocity (m/s)');
    grid on;
end
hold off
%%

%%
