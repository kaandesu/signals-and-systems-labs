clc
clear
close all
format compact

% Parameters
T = 1;                % Symbol duration (seconds)
fs = 100;             % Sampling frequency (Hz)
fc = 10;              % Carrier frequency (Hz)
t = 0:1/fs:(3*T-1/fs);% Time vector (3 symbols duration)
b = [1 -1 1];         % Bipolar sequence for {1, 0, 1}

% Generate the pulse x(t)
x_t = @(t) (t >= 0 & t < T);

% Generate the transmitted signal s(t)
s_t = b(1)*x_t(t) + b(2)*x_t(t-T) + b(3)*x_t(t-2*T);

% Plot the signal
figure;
plot(t, s_t, 'LineWidth', 1.5); grid on;
title('Transmitted Signal s(t)');
xlabel('Time (s)'); ylabel('Amplitude');



% ---FT--- %

% Fourier Transform of the rectangular pulse
f = -50:0.1:50;               % Frequency range
X_f = T * sin(pi*f*T)./(pi*f); % FT of the rectangular pulse
X_f(f == 0) = T;              % Handle division by zero at f = 0

% Fourier Transform of s(t)
S_f = X_f .* (b(1) + b(2)*exp(-1j*2*pi*f*T) + b(3)*exp(-1j*4*pi*f*T));

% Plot the magnitude spectrum of s(t)
figure;
plot(f, abs(S_f), 'LineWidth', 1.5); grid on;
title('Magnitude Spectrum of S(f)');
xlabel('Frequency (Hz)'); ylabel('|S(f)|');


% --- MODULATION --- %

% Modulate s(t) onto a carrier
carrier = cos(2*pi*fc*t);       % Carrier signal
s_mod_t = s_t .* carrier;       % Modulated signal

% Plot the modulated signal
figure;
plot(t, s_mod_t, 'LineWidth', 1.5); grid on;
title('Modulated Signal s_{mod}(t)');
xlabel('Time (s)'); ylabel('Amplitude');

% --- NOISE ---- %

% Add Gaussian noise to the modulated signal
noise = 0.2 * randn(size(s_mod_t)); % Noise amplitude
r_mod_t = s_mod_t + noise;          % Received modulated signal

% Plot the noisy modulated signal
figure;
plot(t, r_mod_t, 'LineWidth', 1.5); grid on;
title('Received Modulated Signal r_{mod}(t)');
xlabel('Time (s)'); ylabel('Amplitude');


% ----DEMODULATE ---%

% Demodulate by multiplying with carrier
r_demod_t = r_mod_t .* carrier;

% Moving Average Filter
window_size = fs / fc;  % Determine filter window size based on cutoff frequency
r_t = filter(ones(1, window_size)/window_size, 1, r_demod_t);

% Plot the demodulated signal after filtering
figure;
plot(t, r_t, 'LineWidth', 1.5); grid on;
title('Demodulated Signal r(t) (Filtered)');
xlabel('Time (s)'); ylabel('Amplitude');


%----- DECODED PULSES----%

% Sample the signal at symbol intervals (nT)
sample_points = T/2:T:(3*T-T/2); % Sampling at the middle of each pulse
r_samples = r_t(round(sample_points * fs)); % Sampled values

% Decode based on threshold
b_decoded = sign(r_samples);     % Recover bipolar values
b_decoded(b_decoded < 0) = 0;    % Map -1 to 0 for binary

% Display the decoded binary sequence
disp('Decoded Binary Sequence:');
disp(b_decoded);


% ---- FT interaction ---- %
% Compute and plot the spectrum of r_mod_t (with noise)
R_mod_f = fftshift(fft(r_mod_t, length(f)));
figure;
plot(f, abs(R_mod_f), 'LineWidth', 1.5); grid on;
title('Spectrum of Received Modulated Signal');
xlabel('Frequency (Hz)'); ylabel('|R_{mod}(f)|');

% Compute and plot the spectrum of r_t (demodulated)
R_f = fftshift(fft(r_t, length(f)));
figure;
plot(f, abs(R_f), 'LineWidth', 1.5); grid on;
title('Spectrum of Demodulated Signal');
xlabel('Frequency (Hz)'); ylabel('|R(f)|');
