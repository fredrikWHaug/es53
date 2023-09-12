%%
% (1) new script
% Filename: lab0
% Author: Fredrik Willumsen Haug
% Created: September 8th, 2023
% Description: MATLAB intro
%%

%%
% (2) vector and matrix declaration and operation

% multiplication and division with transposition
mat1 = 1:5;

mat2 = [11:15; 21:25];

transposition_product = mat1 * mat2';

transposition_quotient = mat1 / mat2; % denominater gets transposed implicitly

% elementwise operations
sum = mat1 + mat2;
difference = mat1 - mat2;
product = mat1 .* mat2;
quotient = mat1 ./ mat2;

%%

%%
% (3) conditionals

% 3.1 - else if with numerical output
% random number with seed 1
rng(1);
random_int = randi(20);

if random_int > 10
    DISP(1)
elseif random_int < 10
    DISP(0)
else 
    DISP(2)
end

% 3.2 - comparison with string output
% random numers assigned to A and with seed 1
A = randi(10);
B = randi(10);

if A == B
    DISP("A is equal to B")
elseif A > B
    DISP("A is greater than B")
else
    DISP("B is greater than A")
end

%%

%%
% (4) loops
% 4.1 - while loop adding all odd numbers from 1 to 3553
index = 1;
odd_sum = 0;
while index <= 3553
odd_sum = odd_sum + index;
index = index + 2;
end
fprintf("Sum of odd numbers: %d", odd_sum);

% 4.2 while loop adding all even numbers from 0 to 3554
index = 0;
even_sum = 0;
while index <= 3554
    even_sum = even_sum + index;
    index = index + 2;
end
fprintf("Sum of even numbers: %d", even_sum);

%%


% (5) searching and indexing
%% 5.1
mat = rand(100);

condition = mat < 0.25;

condition_array = mat(condition); % array containing numbers fulfilling 
                                  % condition
%%

%% 5.2
mat = randi([0, 100], 100);
condition = 35 <= mat <= 53;
conditional_mat = mat(condition);
%%

%% 5.3
mat  = randi([0, 10], 1, 100);
squared_mat = mat.^2;
k = find(squared_mat > 50);

segregated_mat = mat(k);
mat_size = size(segregated_mat);
%%

%(6) greater than implementation
%% 6.1

yVector = randi([0, 10], 1, 100);
xVector = yVector .^2;

[newXVector, newYVector] = greaterThan(xVector, yVector, 5);
%%

%% 6.2
yVector = 10*rand(1,100);
xVector = [1:100];

negativeYVector = yVector * -1;

[newXVector, newYVector] = greaterThan(xVector, negativeYVector, -5);

newYVector2 = newYVector * -1;

%%

%%
% graph
% functions and documentation
t = 0:1/4000:3-1/4000;
q = chirp(t-3,4,1/2,6,'quadratic',100,'convex').*exp(-4*(t-1).^2);
plot(t,q)

[up, lo] = envelope(q);
hold on
plot(t, up, 'LineWidth',5, Color="red");
plot(t, lo, 'LineWidth',10, Color="blue");
legend('q', 'up', 'lo');
hold off
%%
