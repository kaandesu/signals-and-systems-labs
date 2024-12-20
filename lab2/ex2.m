% Define the coefficients of the numerator and denominator
numerator = [1 2];  % Coefficients of (z + 2)
denominator = [1 -3/5 -1/9];  % Coefficients of (z^2 - (3/5)z - 1/9)

% Calculate zeros (roots of numerator) and poles (roots of denominator)
zeros = roots(numerator);
poles = roots(denominator);

% Gain factor (leading coefficient of numerator divided by leading coefficient of denominator)
gain = numerator(1) / denominator(1);

% Display results
disp('Zeros of H(z):');
disp(zeros);
disp('Poles of H(z):');
disp(poles);
disp('Gain factor of H(z):');
disp(gain);

% Plot pole-zero diagram manually
figure;
plot(real(zeros), imag(zeros), 'go', 'MarkerSize', 10, 'LineWidth', 2); % Zeros in green
hold on;
plot(real(poles), imag(poles), 'rx', 'MarkerSize', 10, 'LineWidth', 2); % Poles in red
xlabel('Real Part');
ylabel('Imaginary Part');
title('Pole-Zero Plot of H(z)');
grid on;
legend('Zeros', 'Poles');
hold off;

% Display ROC information
disp('Region of Convergence (ROC):');
disp('|z| > max(abs(poles)) (assuming causal system)');
