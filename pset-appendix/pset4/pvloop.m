% plotting pressure vs volume from PVloop.mat
pv_loop = load('PVloop.mat');

pv_volume = [pv_loop.PVloop(1,:) 60];
pv_pressure = [pv_loop.PVloop(2,:) 3.5];

stroke_work = polyarea(pv_volume, pv_pressure);

plot(pv_volume, pv_pressure);
xlabel('Volume (ml)');
ylabel('Pressure (mmHG)');
axis([40 160 0 160]);
