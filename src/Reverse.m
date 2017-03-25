function outSample = Reverse(sample)
%Reverse:Function to reversely play the audio.
%   outSample:The reversed one for input sample.To be played.
%   sample:The input audio sample.
    outSample = sample;
    outSample.points = flipud(outSample.points);
end
