% Coefficients of the difference equation
a = 2;  % Numerator coefficient for x[n - 2]
b = 3/5;  % Feedback coefficient for y[n - 1]
c = 1/9;  % Feedback coefficient for y[n - 2]

N = 20;  % Number of samples for impulse response
h = zeros(1, N);  % Initialize impulse response array
x = zeros(1, N);  % Impulse input
x(1) = 1;  % Impulse at n = 0

% Compute impulse response using the difference equation
for n = 1:N
    if n == 1
        h(n) = x(n);  % No feedback for n = 0
    elseif n == 2
        h(n) = x(n - 1) + b * h(n - 1);
    else
        h(n) = a * x(n - 2) + x(n - 1) + c * h(n - 2) + b * h(n - 1);
    end
end

% Display the computed impulse response
disp('Impulse Response h[n] (computed):');
disp(h);

% Define h2[n] using your hand-derived formula
A = 3.064;  % Coefficient for the first term
B = -1.95;  % Coefficient for the second term
p1 = 0.7485;  % First pole
p2 = -0.1485;  % Second pole
n = 0:N-1;  % Discrete time indices
h2 = A * (p1.^n) + B * (p2.^n);  % Hand-derived impulse response

% Display the hand-derived impulse response
disp('Impulse Response h2[n] (hand-derived):');
disp(h2);

% Plot both impulse responses for comparison
figure;
stem(n, h, 'filled', 'r', 'DisplayName', 'Computed h[n] (Difference Eq.)'); hold on;
stem(n, h2, 'b', 'DisplayName', 'Hand-Derived h2[n]');
title('Comparison of Impulse Responses');
xlabel('n');
ylabel('h[n]');
legend;
grid on;

% Plot the absolute error between the two impulse responses
figure;
stem(n, abs(h - h2), 'k', 'DisplayName', 'Error |h[n] - h2[n]|');
title('Error Between Computed and Hand-Derived Impulse Responses');
xlabel('n');
ylabel('Error');
legend;
grid on;
