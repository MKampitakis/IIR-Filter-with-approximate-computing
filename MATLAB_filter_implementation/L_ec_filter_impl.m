% left earcup filter implementation
clear all; clc;

% filter coefficients
b1 = [0.997688673703782,    -1.99537734740756,  0.997688673703782];
a1 = [1.000000000000000,    -1.99537200517118,  0.995382689643946];

b2 = [0.996840324347158,    -1.98539089742671,  0.988720680907831];
a2 = [1.000000000000000,    -1.98539089742671,  0.985561005254989];

b3 = [0.989346186734103,  -1.960750017843155,   0.972144876553493];
a3 = [1.000000000000000,  -1.960750017843155,   0.961491063287596];

b4 = [0.979704838449784,  -1.846591769676343,   0.938921295769681];
a4 = [1.000000000000000,  -1.846591769676343,   0.918626134219466];

b5 = [0.979200156266068,  -1.761924633312164,   0.908076593872015];
a5 = [1.000000000000000,  -1.761924633312164,   0.887276750138083];

b6 = [0.952368404985420,  -1.374237116171803,   0.875463937092621];
a6 = [1.000000000000000,  -1.374237116171803,   0.827832342078041];

b7 = [0.963162622458946,  -0.873868016377117,   0.784573410295288];
a7 = [1.000000000000000,  -0.873868016377117,   0.747736032754234];

b8 = [1.005674399766020,  -1.870348822300203,   0.901316722216608];
a8 = [1.000000000000000,  -1.870348822300203,   0.906991121982628];

b9 = [1.053519087055916,  -1.594350294014791,   0.808949105303846];
a9 = [1.000000000000000,  -1.594350294014791,   0.862468192359761];

b10 = [0.952639298115320,  -1.233493017023485,   0.586814240184512];
a10 = [1.000000000000000,  -1.233493017023485,   0.539453538299833];

b11 = [0.995478355661925,  -1.950963366681893,   0.960552124924331];
a11 = [1.000000000000000,  -1.950963366681893,   0.956030480586256];

b12 = [0.992463836436969,  -1.919959329420961,   0.934252759271458];
a12 = [1.000000000000000,  -1.919959329420961,   0.926716595708427];

b13 = [0.946277737939349,   -1.04481549985497,  0.531314512133168];
a13 = [1.000000000000000,   -1.04481549985497,  0.477592250072517];

%% filter implementation

% load sample file
[samples, Fs] = audioread("20to20000Hz_sweep_48000SR.wav");

% buffer initialization
y1  = zeros(3,1);
x1  = zeros(3,1);
y2  = zeros(3,1); 
x2  = zeros(3,1);
y3  = zeros(3,1); 
x3  = zeros(3,1);
y4  = zeros(3,1); 
x4  = zeros(3,1);
y5  = zeros(3,1); 
x5  = zeros(3,1);
y6  = zeros(3,1); 
x6  = zeros(3,1);
y7  = zeros(3,1); 
x7  = zeros(3,1);
y8  = zeros(3,1); 
x8  = zeros(3,1);
y9  = zeros(3,1); 
x9  = zeros(3,1);
y10 = zeros(3,1); 
x10 = zeros(3,1);
y11 = zeros(3,1); 
x11 = zeros(3,1);
y12 = zeros(3,1); 
x12 = zeros(3,1);
y13 = zeros(3,1); 
x13 = zeros(3,1);


output = zeros(size(samples));

% cascaded output calculation
for n = 1:length(samples)
    z_indexes = circularBuffer_read_indexes(3, n);
    z   = z_indexes(1); 
    z_1 = z_indexes(2);
    z_2 = z_indexes(3);
    
    f_out = samples(n); % initialization
    
    % filter 1 (high pass)
    x1(z) = f_out;
    [x1, y1] = hp_filter(x1, y1, a1, b1, z_indexes);
    f_out = y1(z);

    % filter 2 (notch)
    x2(z) = f_out;
    [x2, y2] = pk_filter(x2, y2, a2, b2, z_indexes);
    f_out = y2(z);

    % filter 3 (notch)
    x3(z) = f_out;
    [x3, y3] = pk_filter(x3, y3, a3, b3, z_indexes);
    f_out = y3(z);

    % filter 4 (notch)
    x4(z) = f_out;
    [x4, y4] = pk_filter(x4, y4, a4, b4, z_indexes);
    f_out = y4(z);

    % filter 5 (notch)
    x5(z) = f_out;
    [x5, y5] = pk_filter(x5, y5, a5, b5, z_indexes);
    f_out = y5(z);

    % filter 6 (notch)
    x6(z) = f_out;
    [x6, y6] = pk_filter(x6, y6, a6, b6, z_indexes);
    f_out = y6(z);

    % filter 7 (notch)
    x7(z) = f_out;
    [x7, y7] = pk_filter(x7, y7, a7, b7, z_indexes);
    f_out = y7(z);

    % filter 8 (notch)
    x8(z) = f_out;
    [x8, y8] = pk_filter(x8, y8, a8, b8, z_indexes);
    f_out = y8(z);

    % filter 9 (notch)
    x9(z) = f_out;
    [x9, y9] = pk_filter(x9, y9, a9, b9, z_indexes);
    f_out = y9(z);

    % filter 10 (notch)
    x10(z) = f_out;
    [x10, y10] = pk_filter(x10, y10, a10, b10, z_indexes);
    f_out = y10(z);

    % filter 11 (notch)
    x11(z) = f_out;
    [x11, y11] = pk_filter(x11, y11, a11, b11, z_indexes);
    f_out = y11(z);
    
    % filter 12 (notch)
    x12(z) = f_out;
    [x12, y12] = pk_filter(x12, y12, a12, b12, z_indexes);
    f_out = y12(z);

    % filter 13 (notch)
    x13(z) = f_out;
    [x13, y13] = pk_filter(x13, y13, a13, b13, z_indexes);
    f_out = y13(z);

    output(n) = f_out; % final filter output
end

figure
plot(1:length(samples), samples)
title('original')
figure
plot(1:length(output), output)
title('filtered')
figure
plot(1:length(output), filter(b2,a2,samples))
title('MATLAB filtered')

sound(output, Fs);

%% plot results
figure

subplot(1,2,1);
original_spectrum = fft(samples);
n_or = length(samples);                             % number of samples
f = (0:n_or-1)*(Fs/n_or);                           % frequency range
original_power = abs(original_spectrum).^2/n_or;    % original_power of the DFT
plot(f,original_power)
xlabel('Frequency')
ylabel('original_power')

subplot(1,2,2);
filtered_spectrum = fft(output);
n_fl = length(output);                              % number of samples
f = (0:n_fl-1)*(Fs/n_fl);                           % frequency range
filtered_power = abs(filtered_spectrum).^2/n_fl;    % original_power of the DFT
plot(f,filtered_power)
xlabel('Frequency')
ylabel('filtered_power')


%% filters

function [x, y] = hp_filter(x, y, a, b, z_indexes)
    z   = z_indexes(1); 
    z_1 = z_indexes(2);
    z_2 = z_indexes(3);
    %
    a1 = a(2); a2 = a(3);
    b0 = b(1); b1 = b(2); b2 = b(3);
    B = b0*x(z) + b1*x(z_1) + b2*x(z_2);
    A = - a1*y(z_1) - a2*y(z_2);
    y(z) = B + A;
end

function [x, y] = pk_filter(x, y, a, b, z_indexes)
    z   = z_indexes(1); 
    z_1 = z_indexes(2);
    z_2 = z_indexes(3);
    %
    a1 = a(2); a2 = a(3);
    b0 = b(1); b1 = b(2); b2 = b(3);
    B = + b0*x(z) + b1*x(z_1) + b2*x(z_2);
    A = - a1*y(z_1) - a2*y(z_2);
    y(z) = B + A;
end

%% buffer function

function indexesC = circularBuffer_read_indexes(buffer_len, n)
    z = (1:buffer_len)';
    indexesC = mod(n-z,buffer_len)+1;
end