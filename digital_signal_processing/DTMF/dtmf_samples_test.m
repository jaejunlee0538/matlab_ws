%
% online dtmf generator : http://onlinetonegenerator.com/dtmf.html
clear all
global sampling_rate

samples = [];
dial_inpts = '0123456789ABCD*#';

for i = 1:1:length(dial_inpts)
    samples = [samples dtmf_samples(dial_inpts(i))];
end

soundsc(samples, sampling_rate);
