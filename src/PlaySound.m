function PlaySound(sample)
%PlaySound: Playing the audio based on the information in sample.
%   sample: The structure array, containing the sample-points...
%   and frequency.
    sound(sample.points,sample.sampleRate);
end