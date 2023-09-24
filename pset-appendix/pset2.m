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
% extracting membrane potential from the state vector
plot(y(:, 1));

% redefining information for conductances

% n gates (activation for K+ ions)
n0 = 0.3177;
nInf = 0.9494;
Tn = 1.2028;

% m gates (activation for Na+ ions)
m0 = 0.0529;
mInf = 0.9953;
Tm = 0.1577;

% h gates (inactivaton for k+ ions)
h0 = 0.5961;
hInf = 0.0009;
Th = 1.0022;

nt = nInf - ((nInf - n0) * exp(1).^(-t/Tn));
mt = mInf - ((mInf - m0) * exp(1).^(-t/Tm));
ht = hInf - ((hInf - h0) * exp(1).^(-t/Th));

gkt = ((nt).^4) .* 36;
gnat = ((mt.^3)) .* (ht) .* (120);

% subplot 2
figure(1);
subplot(3, 1, 2);
hold on
plot(t, gkt);
plot(t, gnat);
hold off

% subplot 2
subplot(3, 1, 3);
hold on 
plot(t, nt);
plot(t, mt);
plot(t, ht);
hold off
%%

%% 1b
figure(2);
hold on
for i=0:101
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
for i=0:100
    [t, y] = run_hh_model(8, i, 0.1);
    membrane = y(:, 1);
    peak = [peak, max(membrane)];
    current = [current, i];
end
plot(current, peak)
%%

%%
