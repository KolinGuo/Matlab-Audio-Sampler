function Save(filePath, sample)
%Save: Save a audio file.
%   filePath: The saving location of the audio file.
%   sample: The structure array, containing the sample that needs to be
%   saved
    audiowrite(filePath, sample.points, sample.sampleRate);
end