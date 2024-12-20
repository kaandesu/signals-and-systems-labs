clc
clear
close all
format compact

T = 1; 
fs = 100;
fc = 10;
b = [1 -1 1];
data_len = length(b);
t = 0:1/fs:(data_len * T - 1/fs);

x_t = @(t) (t >= 0 & t < T);
s_t = 0;

for i = 1:data_len
    s_t = s_t + b(i)*x_t(t-((i-1)*T));
end


figure;
plot(t,s_t,'LineWidth',2);
grid on;
title('Transmitted signal s(t)');


% -- FT ---%


f = -50:0.1:50;
X_f = T * sin(pi*T*f) ./ (pi*f);
X_f(f == 0) = T;

D_f = 0;
for i = 1:data_len
    D_f = D_f + (b(i)*exp(-1j*2*pi*f*T*(i-1)));
end

S_f = X_f .* (b(1) + b(2)*exp(-1j*2*pi*f*T) + b(3)*exp(-1j*4*pi*f*T));

figure;
plot(f,abs(S_f),'LineWidth',1.5);
grid on;
title('Magnitude Spectrum of S(f)');


% -- MODULATION -- %

carrier = cos(2 * pi * fc *t);
s_mod_t = s_t .* carrier;

figure;
plot(t,s_mod_t,'LineWidth',1.5);

% -- NOISE --%
noise = 0.2 * randn(size(s_mod_t));
r_mod_t = s_mod_t + noise;

figure;
plot(t,r_mod_t,'LineWidth',1.5);
grid on;

% ---- DEMODULATE ---- %
r_demod_t = r_mod_t .* carrier;
window_size = fs/fc;

r_t = filter(ones(1, window_size)/window_size , 1 , r_demod_t);

figure;
subplot(2,1,1);
plot(t, r_t,'LineWidth',1.5);
subplot(2,1,2);
plot(t, r_demod_t,'LineWidth',1.5);


% ---- DECODED PULSES ---- %

% sample the signal at symbol intervals (nT)
sample_points = T/2:T:(data_len*T-T/2);
r_samples = r_t(round(sample_points * fs));

b_decoded = sign(r_samples);
b_decoded(b_decoded < 0) = 0

disp('Dcoded Binary Sequence');
disp(b_decoded);