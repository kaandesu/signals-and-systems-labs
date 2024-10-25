clc;
close all;
clear;
format compact;

x = [3, 2, -1, 4]; % x[n] = 3δ[n] + 2δ[n - 1] - δ[n - 2] + 4δ[n - 3]

N = length(x);
U_delta = eye(N);

% Fourier Basis
n = 0:N-1;
UF = zeros(N);
for k = 0:N-1
    for m = 0:N-1
        UF(k+1, m+1) = exp(1i * (2 * pi / N) * k * m);
    end
end

% Kaan basis
U_kaan = [1, 0, 0, 0; 
          0, 1/sqrt(2), 1/sqrt(2), 0; 
          0, 0, 0, 1; 
          0, 1/sqrt(2), -1/sqrt(2), 0];

% projections 
c_delta = U_delta' * x'; % Projection onto canonical basis
c_F = UF' * x';          % Projection onto Fourier basis
c_new = U_kaan' * x';    % Projection onto the coolest basis

% Reconstruct the signal from each basis
x_reconstructed_delta = U_delta * c_delta;
x_reconstructed_F = UF * c_F;
x_new = U_kaan * c_new;

% Plot the original signal
figure;
stem(0:N-1, x, 'filled', 'LineWidth', 1.5);
title('Original Signal x[n]');
xlabel('Index');
ylabel('Magnitude');
grid on;

% Plot reconstructed signal from Canonical Basis
figure;
stem(0:N-1, (x_reconstructed_delta), 'filled', 'LineWidth', 1.5);
title('Reconstructed Signal from Canonical Basis (U_{\delta})');
xlabel('Index');
ylabel('Magnitude');
grid on;

% Plot reconstructed signal from Fourier Basis
figure;
stem(0:N-1, (x_reconstructed_F), 'filled', 'LineWidth', 1.5);
title('Reconstructed Signal from Fourier Basis (U_F)');
xlabel('Index');
ylabel('Magnitude');
grid on;

% Plot reconstructed signal from Kaan Basis
figure;
stem(0:N-1, (x_new), 'filled', 'LineWidth', 1.5);
title('Reconstructed Signal from Kaan Basis');
xlabel('Index');
ylabel('Magnitude');
grid on;


% Display the results
disp('Projection Coefficients on the Canonical Basis:');
disp(c_delta);
disp('Projection Coefficients on the Fourier Basis:');
disp(c_F);
disp('Projection Coefficients on the Kaan Basis:');
disp(c_new);
disp('Reconstructed Signal using Canonical Basis:');
disp(x_reconstructed_delta);
disp('Reconstructed Signal using Fourier Basis:');
disp(x_reconstructed_F);
disp('Reconstructed Signal using Kaan Basis:');
disp(x_new);
