
% plotting pressure vs volume from PVloop.mat
pv_loop = load('PVloop.mat');

pv_volume = [pv_loop.PVloop(1,:) 60];
pv_pressure = [pv_loop.PVloop(2,:) 3.5];

plot(PV_volume, PV_pressure);
