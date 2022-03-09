% single chanel 48000 sine wave generator

f = 50;
Fs = 48000;
lenSW = 10; % sec
% call function
f_min = 20;
f_max = 20000;
sw = sweep_generator(f_min, f_max, lenSW, Fs);

sound(sw, Fs);

function sw = sine_generator(f, lenSW, Fs)

    filename = string(f)+'Hz_'+string(Fs)+'SR.wav';

    N = lenSW * Fs;
    Ts = 1/Fs;
    t = [0:(N-1)] * Ts;
    t = t(:); % column to vector

    sw = sin(2*pi*f*t);

    audiowrite(filename,sw,Fs);
end

function sw = sweep_generator(f_min, f_max, lenSW, Fs)

    filename = string(f_min)+'to'+string(f_max)+'Hz_sweep_'+string(Fs)+'SR.wav';

    N = lenSW * Fs;
    Ts = 1/Fs;
    f = logspace(log10(f_min), log10(f_max), N);
    f = f(:); % column to vector

    t = [0:(N-1)] * Ts;
    t = t(:); % column to vector

    sw = sin(2*pi*f.*t);

    audiowrite(filename,sw,Fs);
end