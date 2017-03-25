function outSample = VoiceRemove(sample)
%Remove voice from the input sample
%   sample: the input audio stereo sample
%   outSample: the sample with voice removed
    outSample = sample;
    % subtract right channel from left channel
    outSample.points(:,1) = sample.points(:,1) - sample.points(:,2);
    % subtract left channel from right channel
    outSample.points(:,2) = sample.points(:,2) - sample.points(:,1);
end