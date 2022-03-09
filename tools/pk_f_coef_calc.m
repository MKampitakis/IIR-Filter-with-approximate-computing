% pk filter coefficient calculator
clear all; clc;
format long;

fs = 48000; % sampling frequency
fc = 640; % center freqnecy
lambda = -2; % gain
Q = 1.1; % quality factor

 
phi_c = fc * 2 * pi / (fs);
nu = 10^(lambda/20);


% Calculating coefficients
a0 = 1;
a2 = (2*Q - sin(phi_c))/(2*Q+sin(phi_c));
a1 = -(1+a2)*cos(phi_c);
b1 = a1;
b0 = 0.5*(1+a2) + 0.5*(1-a2) * nu;
b2 = 0.5*(1+a2) - 0.5*(1-a2) * nu;

% Creating digital transfer functions
%z = tf('z', -1);
H = tf([b0 b1 b2],[a0 a1 a2], 1/fs)
[b,a] = tfdata(H, 'v');
disp(b)
disp(a)
%fvtool(b,a)

%% export to .txt
%T = table(b, a, 'VariableNames', { 'b', 'a'} );
%writetable(T, '13_filter_coefficients.txt')