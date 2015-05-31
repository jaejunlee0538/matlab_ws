function [ samples ] = dtmf_samples(key)
global sampling_rate
digits_per_seconds = 5;    
valid_key_input =  ['1','2','3','A','4','5','6','B','7','8','9','C','*','0','#','D'];
low_freq_array = [697 770 852 941];
high_freq_array = [1209 1336 1477 1633];
sampling_rate = 11025;

%% DTMF Mark & Space
% http://www.genave.com/dtmf-mark-space.htm
mark_duration = 1/digits_per_seconds/2;
space_duration = 1/digits_per_seconds/2;

%%
key_pressed = find(valid_key_input==key);
if isempty(key_pressed)
    samples = [];
    return;
end

[col ,row] = ind2sub([4 4], key_pressed);
freq = [low_freq_array(row), high_freq_array(col)];
dt = 1/sampling_rate;
t_mark = 0:dt:mark_duration;
t_space = 0:dt:space_duration;
t_space = t_space + mark_duration;
samples_marks = sin(2*pi*freq(1)*t_mark) + sin(2*pi*freq(2)*t_mark);
samples_space = zeros(size(t_space));
samples = [samples_marks samples_space];


% soundsc(samples, sampling_rate); % soundsc is same with sound but contains auto-scaling

end

