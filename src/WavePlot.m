function WavePlot( ax, samplePoints, sampleRate )
%WavePlot: To plot the wave shape of sound according to the audio.
%   ax: The axis that the sample will be plotted on
%   samplePoints: The sample points of the audio
%   sampleRate: The sample rate of the audio
    t = size(samplePoints,1)/sampleRate;
    x = linspace(0,t,size(samplePoints,1));
    y = samplePoints;
    axes(ax);
    plot(x,y);
    box on;
    xlim([0 t]);
    ylim([-1 1]);
    ylabel('dB');
    set(ax,'YTick',[-1 0 1],'YTickLabel',{'0','-\infty','0'});
end

