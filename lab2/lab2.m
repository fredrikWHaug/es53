
michael = load("Lab2_Ex1_Michael.mat");
aaron = load("Lab2_Ex1_Aaron.mat");
salaidh = load("lab2_ex1_salaidh.mat");
fredrik = load("Lab2_Ex1_Fredrik.mat");

%% 3.1
% remember to ask Dr. Moyer about units
michael = load("Lab2_Ex1_Michael.mat");
aaron = load("Lab2_Ex1_Aaron.mat");
salaidh = load("lab2_ex1_salaidh.mat");
fredrik = load("Lab2_Ex1_Fredrik.mat");

michael_max_region = michael.data(michael.datastart(1, 6) + 30 : michael.dataend(1, 6)-35);
michael_max = max(michael.data(michael.datastart(1, 6) : michael.dataend(1, 6)))
michael_mean = mean(michael_max)
micheal_std = std(michael_max_region)
figure;
plot(michael_max_region);
xlabel('Time');
ylabel('% of max force');
% note: units are in mV, because
% we're using electronics that encode
% force into an electrical signal (why
% we're using percentages
% repeat for every person for this specific exersice and metric
%%

%% 3.2
michael = load("Lab2_Ex1_Michael.mat");
aaron = load("Lab2_Ex1_Aaron.mat");
salaidh = load("lab2_ex1_salaidh.mat");
fredrik = load("Lab2_Ex1_Fredrik.mat");

group_member_data = [aaron, salaidh, fredrik, michael];
variance_group_members = [];
time = 0;
dt = 1 / michael.samplerate(1);

figure;
hold on
for i = 1:4
group_member = group_member_data(i).data(group_member_data(i).datastart(1,8):group_member_data(i).dataend(1,8));
time = dt:dt:length(group_member)*dt
plot(time, group_member);
variance_group_members(i) = var(group_member);
end
hold off
xlabel('Time');
ylabel('% of max force');
legend('Michael', 'Salaidh', 'Aaron', 'Fredrik')
%%
