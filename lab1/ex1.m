clc;
close all;
clear;
format compact;

i = 20;
n = -i:1:i;
N = length(n);

% Case a: |a| < 1
a1 = 0.5; 
x1 = a1.^abs(n); 
% Energy of x1
energy_x1 = sum(abs(x1).^2);
% Average power of x1
avg_power_x1 = energy_x1 / N

figure;
stem(n, x1, 'filled', 'LineWidth', 1.5);
title('Signal x[n] = a^{|n|} for |a| < 1');
xlabel('n');
ylabel('x[n]');
grid on;

% Case 1: |a| > 1
a2 = 1.2; 
x2 = a2.^abs(n);

figure;
stem(n, x2, 'filled', 'LineWidth', 1.5);
title('Signal x[n] = a^{|n|} for |a| \geq 1');
xlabel('n');
ylabel('x[n]');
grid on;
