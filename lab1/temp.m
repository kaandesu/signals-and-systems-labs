clc;
close all;
clear;
format compact;

T0 = 4;
n = 0:0.05:2*pi*T0;
x = sin(n);

figure;
plot(n, x, '-^', 'LineWidth', 1.5);
grid on;
ylabel('sin(n)');
xlabel('n');
