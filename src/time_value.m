function out = time_value(bars,str,bpm)
% This is a fuction used to calculate the time value using
% number of bars, time signature and beats per minute
%   bars: number of bars
%   str:  time signature
%   bpm:  beats per minute
    if(strcmp(str,'4/4'))
        out = ((bars * 4) / bpm) * 60;
    elseif(strcmp(str,'6/8'))
        out = ((bars * 6) / (bpm * 2)) * 60;
    end
end