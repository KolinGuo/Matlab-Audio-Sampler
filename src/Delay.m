function outSample = Delay(sample)
%Delay:To delay the playing of audio by creating an echo effect
%   outSample:The delayed one for input sample.To be played.
%   sample:The input audio sample.
%   many zero to add before the sample array.
    outSample = sample;
    
    % the number of samples points that need to be delayed
    N = sample.delay / 1000 * sample.sampleRate;
    
    for i = N + 1:size(sample.points,1)
        outSample.points(i,:) = sample.points(i,:) + sample.points(i - N,:);
    end
end 