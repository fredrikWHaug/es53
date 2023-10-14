% section load in case it's helpful
% fredrik = load('fredrik_ex2.mat');
% abby = load('abby_ex2.mat');
% lydia = load('lydia_ex2.mat');

% fredrik blood pressure and mean arterial pressure
fredrik_systolic = fredrik.data(fredrik.com(1, 3));
fredrik_diastolic = fredrik.data(fredrik.com(2, 3));
fredrik_bp_value = fredrik_systolic / fredrik_diastolic;
fredrik_map = ((2/3) * fredrik_diastolic) + ((1/3) * fredrik_systolic);

% abby blood pressure and mean arterial pressure
abby_systolic = abby.data(abby.com(1, 3));
abby_diastolic = abby.data(abby.com(2, 3));
abby_bp_value = abby_systolic / abby_diastolic;
abby_map = ((2/3) * abby_diastolic) + ((1/3) * abby_systolic);

% lydia blood pressure and mean arterial pressure
lydia_systolic = abby.data(lydia.com(1, 3));
lydia_diastolic = fredrik.data(lydia.com(2, 3));
lydia_bp_value = lydia_systolic / lydia_diastolic;
lydia_map = ((2/3) * lydia_diastolic) + ((1/3) * lydia_systolic);

% mean and std of digital group mean arterial pressures
group_map = [fredrik_map, abby_map, lydia_map];
mean_group_map = mean(group_map);
std_group_map = std(group_map);
