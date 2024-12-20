clc;
clear;
close all;
format compact;

% Parameters
A = 4;
a = -3/4;
B = 2;
n_min = 0;
n_max = 15;
n = n_min:n_max;
n_conv = 2*n_min:2*n_max;

% Signal Definitions
x_n = A * (a.^n) .* (n >= 0); % x[n] = A * a^n * u[n]
y_n = B * ((n >= 5) & (n <= 15)); % y[n] = B * r10[n - 5]

% Convolution using Definition Formula
z_def = zeros(1, length(n_conv));
for i = 1:length(n_conv)
    for k = 1:length(x_n)
        m = i - k + 1; % Adjust index for y[n-k]
        if m >= 1 && m <= length(y_n)
            z_def(i) = z_def(i) + x_n(k) * y_n(m);
        end
    end
end

% Convolution using Matrix Multiplication
conv_row = 2 * length(n) - 1;
conv_col = length(n);
M = zeros(conv_row, conv_col);
for r = 1:conv_row
    for c = 1:conv_col
        if r - c + 1 > 0 && r - c + 1 <= length(y_n)
            M(r, c) = y_n(r - c + 1);
        end
    end
end
z_matrix = x_n * M';

% Convolution using Built-in Function
z_builtin = conv(x_n, y_n, 'full');

% Plots
figure(1);
stem(n, x_n, 'filled', 'LineWidth', 1.5);
title('Signal x[n] = A * a^n * u[n]');
xlabel('n');
ylabel('x[n]');
grid on;

figure(2);
stem(n, y_n, 'filled', 'LineWidth', 1.5);
title('Signal y[n]');
xlabel('n');
ylabel('y[n]');
grid on;

figure(3);
stem(n_conv, z_def, 'filled', 'LineWidth', 1.5);
title('Convolution using Definition Formula');
xlabel('n');
ylabel('z[n]');
grid on;

figure(4);
stem(n_conv, z_matrix, 'filled', 'LineWidth', 1.5);
title('Convolution using Matrix Multiplication');
xlabel('n');
ylabel('z[n]');
grid on;

figure(5);
stem(n_conv, z_builtin, 'filled', 'LineWidth', 1.5);
title('Convolution using Built-in Function');
xlabel('n');
ylabel('z[n]');
grid on;

% Comparison
disp('Comparison of results:');
disp(['Sum of Absolute Differences (Definition vs Built-in): ', num2str(sum(abs(z_def - z_builtin)))]);
disp(['Sum of Absolute Differences (Matrix vs Built-in): ', num2str(sum(abs(z_matrix - z_builtin)))]);
