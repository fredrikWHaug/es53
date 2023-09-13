    %% Header
    % Filename: lab0
    % Author: Fredrik Willumsen Haug
    % Created: September 8th, 2023
    % Description: MATLAB intro
    %%
    
    % vector and matrix declaration and operation (2)
    %% 2.1
    mat1 = 1:5;
    mat2 = [11:15; 21:25];
    transposition_product = mat1 * mat2';
    transposition_quotient = mat1 / mat2; % denominater gets transposed implicitly
    
    sum = mat1 + mat2;
    difference = mat1 - mat2;
    product = mat1 .* mat2;
    quotient = mat1 ./ mat2;
    %%
    
    % conditionals (3)
    %% 3.1
    random_int = randi(20);
    
    if random_int > 10
        fprintf("%i\n", 1)
    elseif random_int < 10
        fprintf("%i\n", 0)
    else 
        fprintf("%i\n", 0)
    end
    %%
    
    %% 3.2
    A = randi(10);
    B = randi(10);
    
    if A == B
        fprintf("A is equal to B\n");
    elseif A > B
        fprintf("A is greater than B\n");
    else
        fprintf("B is greater than B\n");
    end
    %%
    
    % loops (4)
    %% 4.1
    index = 1;
    odd_sum = 0;

    while index <= 3553
    odd_sum = odd_sum + index;
    index = index + 2;
    end

    fprintf("Sum of odd numbers: %d\n", odd_sum);
    %%
    
    %% 4.2
    index = 0;
    even_sum = 0;

    while index <= 3554
        even_sum = even_sum + index;
        index = index + 2;
    end

    fprintf("Sum of even numbers: %d\n", even_sum);
    %%
    
    % searching and indexing (5)
    %% 5.1
    mat = rand(100);
    condition_array = mat(mat < 0.25);            
    %%
    
    %% 5.2
    mat = randi([0, 100], 100);
    tmp = mat(mat >= 35);
    condition_array = tmp(tmp <= 53);
    %%
    
    %% 5.3
    mat  = randi([0, 10], 1, 100);
    squared_mat = mat.^2;
    k = find(squared_mat > 50);
    segregated_mat = mat(k);
    mat_size = size(segregated_mat);
    %%
    
    % greater than implementation (6)
    %% 6.1
    yVector = randi([0, 10], 1, 100);
    xVector = yVector .^2; % arbitrarily choose to square y to get x vector
    
    [newXVector, newYVector] = greaterThan(xVector, yVector, 5);
    %%
    
    %% 6.2
    yVector = randi([0, 10], 1, 100);
    xVector = yVector .^2; % arbitrarily choose to square y to get x vector
    
    negativeYVector = yVector * -1;
    
    [newXVector, newYVector] = greaterThan(xVector, negativeYVector, -6);
    
    finalYVector = newYVector * -1;
    %%
    
    % graph (7)
    %% 7.1
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
