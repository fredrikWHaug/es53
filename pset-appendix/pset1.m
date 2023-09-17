%% Question 4

%% 4a)
t = [0:8/200:8];

% n gates (activation for K+ ions)
n0 = 0.3177
nInf = 0.9494
Tn = 1.2028

% m gates (activation for Na+ ions)
m0 = 0.0529
mInf = 0.9953
Tm = 0.1577

% h gates (inactivaton for k+ ions)
h0 = 0.5961
hInf = 0.0009;
Th = 1.0022;

nt = nInf - ((nInf - n0) * exp(1).^(-t/Tn));
mt = mInf - ((mInf - m0) * exp(1).^(-t/Tm));
ht = hInf - ((hInf - h0) * exp(1).^(-t/Th));
%%

%% 4b)
gkt = ((nt).^4) .* 36;
gnat = ((mt.^3)) .* (ht) .* (120);

plot(t, gkt, Color='red');
hold on
plot(t, gnat, Color='green');
hold off;

title('Conductances after a voltage clamp from -65 to +23 mV')
xlabel('Time (ms)');
ylabel('Conductance (mS/cm2)');
% difference: pottasium does not go down. Also, shorter time period for Na
% spike
%%

%% 4e)
Ek = -90;
ENa = 55;

Vmem = ((gkt.*Ek) + (gnat.*ENa)) ./ (gkt + gnat);
plot(t, Vmem);
% explination
%%

%%

%% Question 5

%%
% time vector
time = (-30:1/1000:30);

% sinc function
sinc_function = sinc(time);
figure;
plot(time, sinc_function, 'black');
title('Sinc Function');
xlabel('Time (t)');
ylabel('sinc(t)(x)');
legend('sinc(t)');

% derivative of sinc function
dsincdt = gradient(sinc_function);
figure;
plot(time, dsincdt, "black");
title('Derivative of Sinc Function');
xlabel('Time (t)');
ylabel('d(sinc(t))/dt');
legend('d(sinc(t))/dt')

% mask declaration for graph portions
positive_mask = dsincdt > 0;
zero_mask = find(diff(sign(dsincdt)));
negative_mask = dsincdt < 0;

figure;
hold on;
plot(time(positive_mask), dsincdt(positive_mask), 'green');
plot(time(negative_mask), dsincdt(negative_mask), 'red');
scatter(time(zero_mask), dsincdt(zero_mask), 'y', 's', 'filled');
title('Derivative of Sinc Function');
xlabel('Time (t)');
ylabel('dx/dt')
legend('Positive derivative', 'negative derivative', 'Zero-crossing point');
hold off;
%%

%%
%%
