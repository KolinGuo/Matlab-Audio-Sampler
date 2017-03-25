function [ outSample ] = Load(filePath)
%Load: Loading a audio file and saving it as a structure array.
%   filePath: The location of the audio file.
%   outSample: The structure array, containing the sample-points ...
%   and frequency.
    if isnumeric(filePath)
        outSample.points = [];
        outSample.sampleRate = 0;
        outSample.selectPeriod = [];
        outSample.filterGain = [];
        outSample.isReversed = false;
        outSample.delay = 0;
        outSample.speedUp = 0;
        outSample.isVoiceRemoved = false;
        outSample.origSample = outSample;
    else
        [samplePoints, sampleRate] = audioread(filePath);
        outSample.points = samplePoints;
        outSample.sampleRate = sampleRate;
        outSample.selectPeriod = [1 size(samplePoints,1)];
        outSample.filterGain = zeros(1,18);
        outSample.isReversed = false;
        outSample.delay = 0;
        outSample.speedUp = 0;
        outSample.isVoiceRemoved = false;
        outSample.origSample = outSample;
    end
end