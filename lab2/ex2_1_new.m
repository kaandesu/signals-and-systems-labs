% Define the system parameters
a = 2;  % Given value for a
b = 3/5;  % Feedback coefficient for y[n - 1]
c = 1/9;  % Feedback coefficient for y[n - 2]

% Define the coefficients of the transfer function
numerator = [1 2];  % Coefficients of (z + 2)
denominator = [1 -b -c];  % Coefficients of (z^2 - (3/5)z - 1/9)

% Define input signal x[n] = (1/a)^n * u[n]
N = 20;  % Number of samples
n = 0:N-1;  % Time indices
x = (1/a).^n;  % Input signal

% Compute the impulse response h[n] using the difference equation
h = zeros(1, N);  % Initialize impulse response array
impulse = zeros(1, N);  % Impulse input
impulse(1) = 1;  % Impulse at n = 0

for k = 1:N
    if k == 1
        h(k) = impulse(k);
    elseif k == 2
        h(k) = impulse(k - 1) + b * h(k - 1);
    else
        h(k) = a * impulse(k - 2) + impulse(k - 1) + c * h(k - 2) + b * h(k - 1);
    end
end

% Compute output y[n] using convolution
y_conv = conv(x, h);  % Convolution of x[n] and h[n]
y_conv = y_conv(1:N);  % Truncate to N samples

% Compute output y[n] analytically using inverse Z-transform
syms z k;  % Define symbolic variables
H_z = (z + 2) / (z^2 - b*z - c);  % Transfer function H(z)
X_z = 1 / (1 - (1/a)*z^(-1));  % Z-transform of x[n]
Y_z = H_z * X_z;  % Output Y(z) in the Z-domain
y_analytical = double(subs(iztrans(Y_z, z, k), k, n));  % Inverse Z-transform

% Plot x[n], h[n], and y[n]
figure;
subplot(3, 1, 1);
stem(n, x, 'b', 'filled');
title('Input Signal x[n] = (1/a)^n * u[n]');
xlabel('n');
ylabel('x[n]');
grid on;

subplot(3, 1, 2);
stem(n, h, 'g', 'filled');
title('Impulse Response h[n]');
xlabel('n');
ylabel('h[n]');
grid on;

subplot(3, 1, 3);
stem(n, y_conv, 'r', 'filled', 'DisplayName', 'y[n] (Convolution)');
hold on;
stem(n, y_analytical, 'k--', 'DisplayName', 'y[n] (Analytical)');
title('Output Signal y[n]');
xlabel('n');
ylabel('y[n]');
legend;
grid on;

% Display the computed outputs for comparison
disp('Computed Output y[n] using Convolution:');
disp(y_conv);

disp('Computed Output y[n] using Analytical Method:');
disp(y_analytical);

% Plot error between the two methods
figure;
stem(n, abs(y_conv - y_analytical), 'k', 'filled');
title('Error Between Analytical and Convolution Outputs');
xlabel('n');
ylabel('Error |y[n] (Conv) - y[n] (Analytical)|');
grid on;
