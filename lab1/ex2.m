clc;
close all;
clear;
format compact;

N = 8;
n = 0:N-1;

x = exp(1i * 4 * pi * n / N); 
y = exp(1i * 8 * pi * n / N); 

energy_x = sum(abs(x).^2); 
energy_y = sum(abs(y).^2); 

avg_power_x = energy_x / N; 
avg_power_y = energy_y / N; 

orthogonality = sum(x .* conj(y)); 

figure;
stem(n, real(x), 'filled', 'LineWidth', 1.5);
hold on;
stem(n, real(y), 'filled', 'LineWidth', 1.5);
title('Signals x[n] and y[n]');
xlabel('n');
ylabel('Amplitude');
legend('x[n] = exp(j4πn/N)', 'y[n] = exp(j8πn/N)');
grid on;

fprintf('Energy of x[n]: %.2f\n', energy_x);
fprintf('Average Power of x[n]: %.2f\n', avg_power_x);
fprintf('Energy of y[n]: %.2f\n', energy_y);
fprintf('Average Power of y[n]: %.2f\n', avg_power_y);
fprintf('Orthogonality Check (should be 0): %.4f\n', orthogonality);