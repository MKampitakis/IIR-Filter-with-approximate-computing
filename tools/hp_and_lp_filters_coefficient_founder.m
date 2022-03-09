% this script translates the Second order section (SOS) coefficients 
% into numerators (b) and denumerators (a). 
% For use: 
%       open matlab filter design 
%       design any HP or LP filter 
%       export into ASCII .txt file
%       copy paste the SOS and scaler accordingly
clear all; clc;
format long;

f_SOS = [1  -2  1  1  -1.995372005171181628568888299923855811357  0.995382689643946494406634428742108866572];
f_SOS_scaler = 0.997688673703782002988305066537577658892;
[b,a] = sos2tf(f_SOS);
b = b .* f_SOS_scaler;

disp(b)
disp(a)

%% export to .txt
%T = table(b, a, 'VariableNames', { 'b', 'a'} );
%writetable(T, 'hp_filter_coefficients.txt')