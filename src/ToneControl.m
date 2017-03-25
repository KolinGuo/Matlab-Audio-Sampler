function [ output_args ] = ToneControl( input_args )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

N = length(points);
bin_Vals = [0:N-1];
fax_Hz = bin_Vals*rate/N;
N_2 = ceil(N/2);
Hz = fax_Hz(1:N_2);
complex = fft(points);
x = [55  77  110 156 220 311 440 622 880 1200 1800 2500 3500 5000 7000 10000 14000 20000];
y = [-20 -20 -20 -20 -20   0   0   0   0   0    0    0    20   20   20    20     20     20];
cs = pchip(x,y);
modHz = ppval(cs,Hz)';
modHz = 10.^(modHz./20);
filter = modHz .* 0.75 + modHz .* 0.25 * j;
filter = [filter;flipud(filter)];
filter = ifft(filter);
realFilter = real(filter);
actualFilter = fft(realFilter);
actualFilter = [actualFilter  actualFilter];
modComplex = actualFilter.*complex;
modPoints = ifft(modComplex);
sound(modPoints,rate)

end

