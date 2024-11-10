clc;
clear;
close all;
format compact;

N = 128;
x = [zeros(1, 5), ones(1, 88), zeros(1, N - 93)]; % Define r88[n-5] over [0, N-1]

U_delta = eye(N);
c_delta = U_delta' * x';

figure;
stem(0:N-1, x, 'filled', 'LineWidth', 1.5);
title('Original Signal x[n]');
xlabel('Index');
ylabel('Magnitude');
grid on;

figure;
stem(0:N-1, c_delta, 'filled', 'LineWidth', 1.5);
title('Projection Coefficients on Canonical Basis');
xlabel('Index');
ylabel('Magnitude');
grid on;

% Creating the Fourier Basis
n = 0:N-1;
UF = zeros(N);
for k = 0:N-1
    for m = 0:N-1
        UF(k+1, m+1) = exp(1i * (2 * pi / N) * k * m);
    end
end


UF = (1/sqrt(N)) * UF;

UB = eye(N);

c_Fourier = UF' * x';

U_W = (1/sqrt(N)) * hadamard(N);

c_Walsh = U_W' * x';

testMatrix = UF * conj(UF');
testMatrix2 = UB * conj(UB');
testMatrix3 = U_W * conj(U_W');

sum(testMatrix(:)) % good if ~128
sum(testMatrix2(:)) % good if ~128
sum(testMatrix3(:)) % good if ~128

% Plot Fourier Basis
% Real part
figure(2)
subplot(2, 1, 1); % 2 rows, 1 column, first subplot
stem(0:N-1, real(c_Fourier), 'filled', 'LineWidth', 1.5);
title('Real Part of Projection Coefficients on Fourier Basis');
xlabel('Index');
ylabel('Magnitude');
grid on;

% Imaginary part
subplot(2, 1, 2); % 2 rows, 1 column, second subplot
stem(0:N-1, imag(c_Fourier), 'filled', 'LineWidth', 1.5);
title('Imaginary Part of Projection Coefficients on Fourier Basis');
xlabel('Index');
ylabel('Magnitude');
grid on;

% Plot Walsh Basis
figure
stem(0:N-1, real(c_Walsh),'filled','LineWidth',1.5);
title('Projection Coefficients on Walsh Basis');
xlabel('Index');
ylabel('Magnitude');
grid on;
