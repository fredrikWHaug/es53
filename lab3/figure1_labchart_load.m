% loading through labchart because load gave positive or local value error
relax = data((datastart(1,1)+comtickpos(2)):datastart(1,1)+comtickpos(3));
moving = data((datastart(1,1)+comtickpos(3)):datastart(1,1)+comtickpos(4));

% defining time vector to get seconds for moving
time_relax = (1 :length(relax)) / 1000;
time_moving = (1 : length(moving)) / 1000;

figure(1);
hold on
plot(time_relax, relax);
plot(time_moving, moving);
hold off