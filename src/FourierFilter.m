function outSample = FourierFilter(sample)
%Use Fourier Transform to filter the sample
%   sample: the input audio sample
%   outSample: the filtered sample
    points = sample.points;         % get the sample points
    rate = sample.sampleRate;       % get the sample rate
    complex = fft(points);          % perform fourier transform to the sample

    N = size(points,1);             % determine the number of sample points
    bin_Vals = [0:N-1];             % the bin frequency value
    fax_Hz = bin_Vals * rate / N;   % convert bin-frequency to Hz         
    Hz = fax_Hz(1:ceil(N/2));       % extract the lower half of frequency in Hz

    clear bin_Vals fax_Hz;          % release memory

    freq = [55 77 110 156 220 311 440 622 880 1200 1800 2500 3500 5000 7000 10000 14000 20000];     % the frequency of the 18 sliders
    gain = sample.filterGain;       % get the filterGain from sample 

    gainInter = pchip(freq,gain,Hz)';     % perform Piecewise Cubic Hermite Interpolating Polynomial

    % Set gain below 20 Hz and above 20000 Hz to 0
    gainInter(Hz < 20 | Hz > 25000) = 0;
    % Set gain that exceed 20 dB to 20 dB those that below -20 dB to -20 dB
    gainInter(gainInter > 20) = 20;
    gainInter(gainInter < -20) = -20;

    gainMagnitude = 10.^(gainInter./20);    % convert to gain in magnitude

    filter = gainMagnitude .* 0.75 + gainMagnitude .* 0.25 * j;     % real weight = 0.75, imaginary weight = 0.25

    clear Hz gainInter gainMagnitude;          % release memory

    filter = [filter;flipud(filter)];       % add filter for the other half of frequency
    filter = ifft(filter);                  % perform inverse fourier transform
    filter = real(filter);                  % get rid of the complex part
    actualFilter = fft(filter);         % perform fourier transform to get the actual filter
    if(size(points,2) == 2)     % if the sample is stereo
        actualFilter = [actualFilter  actualFilter];    % add filter to the right channel
    end
    filtComplex = actualFilter .* complex;  % apply the filter

    clear points filter actualFilter complex;      % release memory

    filtPoints = ifft(filtComplex);         % perform inverse fourier transform to get the filted points

    outSample = sample;                 % copy original sample
    outSample.points = filtPoints;      % substitute the sample points
end

