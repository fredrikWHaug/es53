%% 3.2
group_member_data = [aaron, salaidh, fredrik, michael];
variance_group_members = [];
time = 0;
dt = 1 / michael.samplerate(1);

figure(2);
hold on
for i = 1:length(group_member_data)
group_member = group_member_data(i).data(group_member_data(i).datastart(1,8):group_member_data(i).dataend(1,8));
time = dt:dt:length(group_member)*dt;
plot(time, group_member);
variance_group_members(i) = var(group_member);
end
hold off
xlabel('Time');
ylabel('% of max force');
legend('Michael', 'Salaidh', 'Aaron', 'Fredrik');
%%
