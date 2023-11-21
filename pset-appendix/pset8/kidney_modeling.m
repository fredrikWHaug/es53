%% a
% Define the range of x values
time_a = 0:.1:10;

% Compute e^(-x) for each x value
function_a = exp(-time_a);
asteriks_a = find(time_a == 1);

% Plot
figure(1);
plot(time, fun1);
hold on
plot(time_a(asteriks_a), function_a(asteriks_a), 'r*');
hold off
grid on
%%

%% b
time_b = 0:.1:10;
function_b = (1) - (exp(-time_b));
asteriks_b = find(time_b == 1);
figure(2);
plot(time_b, function_b);
hold on
plot(time_b(asteriks_b), function_b(asteriks_b), 'r*');
hold off
grid on
%%

%% c
time_c = 0:.1:20;
a_0 = 2;
tau = 3;
function_c = a_0*exp(-time_c/tau);

figure(3);
plot(time_c, function_c);
hold on
hold off
grid on
%%

%%
syms x
t_50 = double(solve(a_0 == 2*(a_0*exp(-x/tau))))
t_37 = double(solve(a_0 == 1/.37*(a_0*exp(-x/tau))))
%%
