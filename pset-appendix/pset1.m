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
%% 5 a) sinc
t = [-30:1/1000:30];
plot(t, sinc(t), Color='black');
xlabel('Time (t)');
ylabel('sinc(t)(x)');
derivative = gradient(sinc(t));
plot(t, derivative, Color='blue');
xlabel('Time (t)');
ylabel('d(sinc(t)/dt)');
%%
%%
