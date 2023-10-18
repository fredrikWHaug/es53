% loading data as struct
pv_loop = load('PVloop.mat');

% extracting volume and pressure respectively
pv_volume = [pv_loop.PVloop(1,:) 60];
pv_pressure = [pv_loop.PVloop(2,:) 3.5];

% taking integral of pressure volume loop with polyarea
stroke_work = polyarea(pv_volume, pv_pressure);

% plot with labeled and ajusted axes
plot(pv_volume, pv_pressure);
xlabel('Volume (ml)');
ylabel('Pressure (mmHG)');
axis([40 160 0 160]);
