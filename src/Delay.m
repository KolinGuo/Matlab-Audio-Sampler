function outSample = Delay(sample)
%Delay:To delay the playing of audio by creating an echo effect
%   outSample:The delayed one for input sample.To be played.
%   sample:The input audio sample.
%   many zero to add before the sample array.
    outSample = sample;
    
    % the number of sample points that need to be delayed
    N = sample.delay / 1000 * sample.sampleRate;
    
    % create echo effect by adding sample points
    outSample.points(N+1:end,:) = sample.points(N+1:end,:) + sample.points(1:end-N,:);
end 