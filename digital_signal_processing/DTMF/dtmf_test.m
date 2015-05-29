key_info =  {'1','2','3','A','4','5','6','B','7','8','9','C','*','0','#','D'};
low_freq_array = [697 770 852 941];
high_freq_array = [1209 1336 1477 1633];

key_pressed = menu('DTMf',key_info);

[col ,row] = ind2sub([4 4], key_pressed);



%% generate sound
freq = [low_freq_array(row), high_freq_array(col)];
sampling_rate = 11025; % Hz
dt = 1/sampling_rate;
duration = 1;
t = 0:dt:duration;

samples = sin(2*pi*freq(1)*t) + sin(2*pi*freq(2)*t);

soundsc(samples, sampling_rate); % soundsc is same with sound but contains auto-scaling
% plot(t(1:100),samples(1:100))
