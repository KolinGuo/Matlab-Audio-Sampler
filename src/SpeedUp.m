function outSample = SpeedUp(sample)
%SpeedUp:To change the velocity that the audio is played.
%   sample:The input audio sample.
%   outSample:The data sample to be played in different velocity.
    outSample = sample;
    
    if(sample.speedUp > 0)  % speed up
        if (outSample.sampleRate * sample.speedUp > 192000)
            outSample.points = outSample.points((1:sample.speedUp:end),:);
        else
            outSample.sampleRate= outSample.sampleRate * sample.speedUp;
        end
    elseif(sample.speedUp < 0)  % slow down
        outSample.sampleRate= outSample.sampleRate * (1/abs(sample.speedUp));
    else    % for debug purpose
        errordlg('Bug Detected: speedUp','Bug Detected','modal');
    end
end