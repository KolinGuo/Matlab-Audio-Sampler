function [ outSample ] = Load(filePath)
%Load: Loading a audio file and saving it as a structure array.
%   filePath: The location of the audio file.
%   outSample: The structure array, containing the sample-points ...
%   and frequency.
    if isnumeric(filePath)
        outSample.points = [];
        outSample.sampleRate = 0;
    else
        [samplePoints, sampleRate] = audioread(filePath);
        outSample.points = samplePoints;
        outSample.sampleRate = sampleRate;
    end
end