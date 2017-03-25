% end
t = toc(A);
userData = get(handles.end,'UserData');
userData(end,3)=t;
set(handles.end,'UserData',userData);
guidata(hObject,handles);
%3个callback的tag, 修改Timesignature中content变string finalRecordTime = time_value(get(handles.bars,'string'),get(handles.
finalRecord = zeros(timeValue * 44100, 2);
recordingSamplesInfo = get(handles.end,'UserData');
sampleInd = recordingSamplesInfo(:,1);
sampleStartingTime = recordingSamplesInfo(:,2);
sampleDuration = recordingSamplesinfo(:,3);
for i = 1:lenght(sampleInd)
    samplePoints = get(handles.samples(i).points);
    if (size(samplePoints,2) == 2)
        Record((sampleStartingTime(i) * 44100):((sampleStartingTime(i) * 44100)+sampleDuration(i)*44100),:) = samplePoints(1:(sampleDuration * 44100),:);                     
    else
        newSamplePoints = [samplePoints,samplePoints];
        Record((sampleStartingTime(i) * 44100):((sampleStartingTime(i) * 44100)+sampleDuration(i)*44100),:) = newSamplePoints(1:(sampleDuration * 44100),:)
    end
end
totalRecordingTime = sampleSatartingTime(end)+sampleDuration(end);
Rounds = totalRecordingTime/%TimeValue;
timeLeft = totalRecordingTime - Rounds * %TimeValue;
numPointsLeft = 44100 * timeLeft;
finalRecord = Record((Rounds-1) * 44100:Rounds*44100,:);
finalRecord((1:numPointsLeft),:) = Record((end-numPointsLeft:end),:);
%怎么保存finalRecord?　

% Sound……
t = toc(A);
userData = get(handles.end,'UserData');
userData(end,3)=t;
userData = [userData;[(get(hObject,'Value')),(userData(end,2)+t),0];
set(handles.end,'UserData',userData);

%record下
%建end_userData 中的[0,0,0]数列
%A = tic
    handles.samples(1).points;



