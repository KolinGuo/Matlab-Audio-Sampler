function [ outSample ] = Load()
%Load: Loading a audio file and saving it as a structure array.
%   str: The name of the audio file.
%   outSample: The structure array, containing the sample-points ...
%   and frequency.
    [filename, pathname] = uigetfile(...
            {'*.aiff;*.au;*.flac;*.m4a;*.mp3;*.mp4;*.oga;*.ogg;*.snd;*.wav',....
            'Audio (*.aiff, *.au, *.flac, *.m4a, *.mp3, *.mp4, *.oga, *.ogg, *.snd, *.wav)'},...
            'Select an audio file');
    if isequal(filename,0)
        outSample.points = [];
        outSample.sampleRate = 0;
    else
        [samplePoints, sampleRate] = audioread([pathname,filename]);
        outSample.points = samplePoints;
        outSample.sampleRate = sampleRate;
    end
end

