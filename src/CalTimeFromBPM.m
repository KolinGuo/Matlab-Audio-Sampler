function duration = CalTimeFromBPM(bars,str,bpm)
% This is a fuction used to calculate the time value using
% number of bars, time signature and beats per minute
%   bars: number of bars
%   str:  time signature
%   bpm:  beats per minute
%   duration: the duration of the recording
    if(strcmp(str,'4/4'))
        duration = (bars * 4) * (60 / bpm);
    elseif(strcmp(str,'6/8'))
        duration = (bars * 6) * (60 / bpm / 2);
    end
end