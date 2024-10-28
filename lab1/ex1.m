clc;
close all;
clear;
format compact;

% i manually tried
i = 83333; 
n = -i:i;
N = length(n);

a1 = 0.5;
x1 = a1.^abs(n);

energy_x1 = sum(abs(x1).^2);
avg_power_x1 = energy_x1 / N;

target_error = 1e-5; 

fprintf('Extension size i: %d\n', i);
fprintf('average power: %.10f\n', avg_power_x1);

if avg_power_x1 < target_error
    fprintf('Average power meets the 0.001%% tolerance.\n');
else
    fprintf('Average power does NOT meet the 0.001%% tolerance.\n');
end

figure;
stem(n, x1, 'filled', 'LineWidth', 1.5);
title('Signal x[n] = a^{|n|} for |a| < 1');
xlabel('n');
ylabel('x[n]');
grid on;

a2 = 1.2; 
x2 = a2.^abs(n);

figure;
stem(n, x2, 'filled', 'LineWidth', 1.5);
title('Signal x[n] = a^{|n|} for |a| \geq 1');
xlabel('n');
ylabel('x[n]');
grid on;
