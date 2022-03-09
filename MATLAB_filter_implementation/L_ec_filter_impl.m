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

% buffer initialization
y1 = zeros(3,1);
x1 = zeros(3,1);
y2 = zeros(3,1); 
x2 = zeros(3,1);
y3 = zeros(3,1); 
x3 = zeros(3,1);
y4 = zeros(3,1); 
x4 = zeros(3,1);
y5 = zeros(3,1); 
x5 = zeros(3,1);
y6 = zeros(3,1); 
x6 = zeros(3,1);
y7 = zeros(3,1); 
x7 = zeros(3,1);
y8 = zeros(3,1); 
x8 = zeros(3,1);
y9 = zeros(3,1); 
x9 = zeros(3,1);
y10 = zeros(3,1); 
x10 = zeros(3,1);
y11 = zeros(3,1); 
x11 = zeros(3,1);
y12 = zeros(3,1); 
x12 = zeros(3,1);
y13 = zeros(3,1); 
x13 = zeros(3,1);

% load sample file
[samples, Fs] = audioread("20to20000Hz_sweep_48000SR.wav");

%samples = [1:20];
output = zeros(size(samples));

% cascaded output calculation
for n = 1:length(samples)
    % delay indexes
    z = circularBuffer_read_indexes(3, n);
    z0 = z(1); z1 = z(2); z2 = z(3); % (z0 = no delay)

    f_out = samples(n); % initialization
    
    % filter 1 (high pass)
    x1(z0) = f_out;
    y1(z2) = b1(1)*x1(z2) - b1(2)*x1(z1) - b1(3)*x1(z0) + a1(2)*y1(z1) + a1(3)*y1(z0);
    f_out = y1(z2);

    % filter 2 (notch)
    x2(z0) = f_out;
    y2(z2) = b2(1)*x2(z2) - b2(2)*x2(z1) + b2(3)*x2(z0) + a2(2)*y2(z1) - a2(3)*y2(z0);
    %disp(x2(z0))
    %disp(y2(z2))
    %disp('  -------')
    f_out = y2(z2);

    %x3(z0) = f_out;
    %y3(z2) = b3(1)*x3(z2) - b3(2)*x3(z1) + b3(3)*x3(z0) + a3(2)*y3(z1) - a3(3)*y3(z0);
    %f_out = y3(z2);

    output(n) = f_out; % final filter output
end

figure
plot(1:length(samples), samples)
figure
plot(1:length(output), output)

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


%% buffer function

function indexesC = circularBuffer_read_indexes(buffer_len, n)
    z = (1:buffer_len)';
    indexesC = mod(n-z,buffer_len)+1;
end