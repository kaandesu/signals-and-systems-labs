clc
clear 
close all
% Define the impulse response in terms of delta functions
n = 0:10;  % Time index from 0 to 10
h = zeros(size(n));  % Initialize the impulse response array

% Define the delta functions and their respective coefficients
h(n == 0) = 1/4;  % delta[n]
h(n == 1) = 3/4;  % 3*delta[n-1]
h(n == 2) = -3/4; % -3*delta[n-2]

% Plot the impulse response
stem(n, h, 'filled');
title('Impulse Response h[n]');
xlabel('n');
ylabel('h[n]');
