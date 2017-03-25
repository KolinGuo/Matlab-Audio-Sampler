function varargout = equalizer(varargin)
% EQUALIZER MATLAB code for equalizer.fig
%      EQUALIZER, by itself, creates a new EQUALIZER or raises the existing
%      singleton*.
%
%      H = EQUALIZER returns the handle to a new EQUALIZER or the handle to
%      the existing singleton*.
%
%      EQUALIZER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EQUALIZER.M with the given input arguments.
%
%      EQUALIZER('Property','Value',...) creates a new EQUALIZER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before equalizer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to equalizer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help equalizer

% Last Modified by GUIDE v2.5 17-Mar-2017 17:35:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @equalizer_OpeningFcn, ...
                   'gui_OutputFcn',  @equalizer_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before equalizer is made visible.
function equalizer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to equalizer (see VARARGIN)

% Choose default command line output for equalizer
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Get the handle of main
hmain = findobj('Tag','main');

% if it doesn't exist, appear an error
if isempty(hmain)
    herror = errordlg({'The ''main'' GUI is not currently running.' 'Please run the ''main'' GUI first.'},...
        'GUI Error','modal');
    uiwait(herror);
    close(hObject);
else    % if the main is already running, save its handles and proceed
    handles.main = guidata(hmain);
    curPad = handles.main.curPad;   % get the current pad
    handles.filterGain = handles.main.samples(curPad).filterGain; % save filterGain
    
    % Draw 18 java sliders
    for i = 1:18
        % create a slider
        jSlider = javax.swing.JSlider(javax.swing.JSlider.VERTICAL,-20,20,0);
        jSlider = javacomponent(jSlider,[10+(i-1)*62,74,45,260],hObject);
        strStateFunc = ['slider' num2str(i) '_StateChangedCallback'];
        strMouseFunc = ['slider' num2str(i) '_MouseReleasedCallback'];
        
        % save the handle of the slider
        handles.sliders(i) = jSlider;
        
        set(jSlider, 'MajorTickSpacing',10, 'MajorTickSpacing',5, ...
            'PaintLabels',false, 'PaintTicks',true,...
            'Value',handles.filterGain(i),...   % change the slider
            'Focusable',0,'SnapToTicks',0,...
            'StateChangedCallback',{str2func(strStateFunc),handles},...
            'MouseReleasedCallback',{str2func(strMouseFunc),handles});
    end
    % Update handles structure
    guidata(hObject, handles);
    % Change edit texts
    ChangeGainEditText(handles);
    PlotGain(handles);
end

% --- Outputs from this function are returned to the command line.
function varargout = equalizer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if(~isempty(handles))
    % Get default command line output from handles structure
    varargout{1} = handles.output;
end

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in resetButton.
function resetButton_Callback(hObject, eventdata, handles)
% hObject    handle to resetButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.filterGain = zeros(1,18);   % reset filterGain
guidata(hObject, handles);      % Update handles structure

% reset sliders
for i = 1:18
    set(handles.sliders(i),'Value',0);
end

% Change Edit Texts
ChangeGainEditText(handles);
% Replot the graph
PlotGain(handles);

% --- Executes on button press in applyButton.
function applyButton_Callback(hObject, eventdata, handles)
% hObject    handle to applyButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Update the filterGain to main
main = handles.main;    % get the handle of main GUI
curPad = main.curPad;   % get the current pad
main.samples(curPad).filterGain = handles.filterGain; % update the filterGain
guidata(main.main,main);    % Update handles structure of main GUI
% Close equalizer GUI
close(handles.equalizer);

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double

% get current value
gainStr = get(hObject,'String');
gain = str2double(gainStr);
% check format
if(isnan(gain) || ~isreal(gain) || gain < -20 || gain > 20) % if it's not a real number
    errordlg('The gain must be a number between -20 to 20',...
        'Input Error','modal');
    ChangeGainEditText(handles);    % change the edit text back
else    % if the format is correct
    handles.filterGain(1) = gain;   % save the gain
    guidata(hObject, handles);      % Update handles structure
    set(handles.sliders(1),'Value',gain);   % set the slider value
    ChangeGainEditText(handles);    % refresh the edit text
    PlotGain(handles);
end

function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double

% get current value
gainStr = get(hObject,'String');
gain = str2double(gainStr);
% check format
if(isnan(gain) || ~isreal(gain) || gain < -20 || gain > 20) % if it's not a real number
    errordlg('The gain must be a number between -20 to 20',...
        'Input Error','modal');
    ChangeGainEditText(handles);    % change the edit text back
else    % if the format is correct
    handles.filterGain(2) = gain;   % save the gain
    guidata(hObject, handles);      % Update handles structure
    set(handles.sliders(2),'Value',gain);   % set the slider value
    ChangeGainEditText(handles);    % refresh the edit text
    PlotGain(handles);
end

function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double

% get current value
gainStr = get(hObject,'String');
gain = str2double(gainStr);
% check format
if(isnan(gain) || ~isreal(gain) || gain < -20 || gain > 20) % if it's not a real number
    errordlg('The gain must be a number between -20 to 20',...
        'Input Error','modal');
    ChangeGainEditText(handles);    % change the edit text back
else    % if the format is correct
    handles.filterGain(3) = gain;   % save the gain
    guidata(hObject, handles);      % Update handles structure
    set(handles.sliders(3),'Value',gain);   % set the slider value
    ChangeGainEditText(handles);    % refresh the edit text
    PlotGain(handles);
end

function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double

% get current value
gainStr = get(hObject,'String');
gain = str2double(gainStr);
% check format
if(isnan(gain) || ~isreal(gain) || gain < -20 || gain > 20) % if it's not a real number
    errordlg('The gain must be a number between -20 to 20',...
        'Input Error','modal');
    ChangeGainEditText(handles);    % change the edit text back
else    % if the format is correct
    handles.filterGain(4) = gain;   % save the gain
    guidata(hObject, handles);      % Update handles structure
    set(handles.sliders(4),'Value',gain);   % set the slider value
    ChangeGainEditText(handles);    % refresh the edit text
    PlotGain(handles);
end

function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double

% get current value
gainStr = get(hObject,'String');
gain = str2double(gainStr);
% check format
if(isnan(gain) || ~isreal(gain) || gain < -20 || gain > 20) % if it's not a real number
    errordlg('The gain must be a number between -20 to 20',...
        'Input Error','modal');
    ChangeGainEditText(handles);    % change the edit text back
else    % if the format is correct
    handles.filterGain(5) = gain;   % save the gain
    guidata(hObject, handles);      % Update handles structure
    set(handles.sliders(5),'Value',gain);   % set the slider value
    ChangeGainEditText(handles);    % refresh the edit text
    PlotGain(handles);
end

function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double

% get current value
gainStr = get(hObject,'String');
gain = str2double(gainStr);
% check format
if(isnan(gain) || ~isreal(gain) || gain < -20 || gain > 20) % if it's not a real number
    errordlg('The gain must be a number between -20 to 20',...
        'Input Error','modal');
    ChangeGainEditText(handles);    % change the edit text back
else    % if the format is correct
    handles.filterGain(6) = gain;   % save the gain
    guidata(hObject, handles);      % Update handles structure
    set(handles.sliders(6),'Value',gain);   % set the slider value
    ChangeGainEditText(handles);    % refresh the edit text
    PlotGain(handles);
end

function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double

% get current value
gainStr = get(hObject,'String');
gain = str2double(gainStr);
% check format
if(isnan(gain) || ~isreal(gain) || gain < -20 || gain > 20) % if it's not a real number
    errordlg('The gain must be a number between -20 to 20',...
        'Input Error','modal');
    ChangeGainEditText(handles);    % change the edit text back
else    % if the format is correct
    handles.filterGain(7) = gain;   % save the gain
    guidata(hObject, handles);      % Update handles structure
    set(handles.sliders(7),'Value',gain);   % set the slider value
    ChangeGainEditText(handles);    % refresh the edit text
    PlotGain(handles);
end

function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double

% get current value
gainStr = get(hObject,'String');
gain = str2double(gainStr);
% check format
if(isnan(gain) || ~isreal(gain) || gain < -20 || gain > 20) % if it's not a real number
    errordlg('The gain must be a number between -20 to 20',...
        'Input Error','modal');
    ChangeGainEditText(handles);    % change the edit text back
else    % if the format is correct
    handles.filterGain(8) = gain;   % save the gain
    guidata(hObject, handles);      % Update handles structure
    set(handles.sliders(8),'Value',gain);   % set the slider value
    ChangeGainEditText(handles);    % refresh the edit text
    PlotGain(handles);
end

function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double

% get current value
gainStr = get(hObject,'String');
gain = str2double(gainStr);
% check format
if(isnan(gain) || ~isreal(gain) || gain < -20 || gain > 20) % if it's not a real number
    errordlg('The gain must be a number between -20 to 20',...
        'Input Error','modal');
    ChangeGainEditText(handles);    % change the edit text back
else    % if the format is correct
    handles.filterGain(9) = gain;   % save the gain
    guidata(hObject, handles);      % Update handles structure
    set(handles.sliders(9),'Value',gain);   % set the slider value
    ChangeGainEditText(handles);    % refresh the edit text
    PlotGain(handles);
end

function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double

% get current value
gainStr = get(hObject,'String');
gain = str2double(gainStr);
% check format
if(isnan(gain) || ~isreal(gain) || gain < -20 || gain > 20) % if it's not a real number
    errordlg('The gain must be a number between -20 to 20',...
        'Input Error','modal');
    ChangeGainEditText(handles);    % change the edit text back
else    % if the format is correct
    handles.filterGain(10) = gain;   % save the gain
    guidata(hObject, handles);      % Update handles structure
    set(handles.sliders(10),'Value',gain);   % set the slider value
    ChangeGainEditText(handles);    % refresh the edit text
    PlotGain(handles);
end

function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double

% get current value
gainStr = get(hObject,'String');
gain = str2double(gainStr);
% check format
if(isnan(gain) || ~isreal(gain) || gain < -20 || gain > 20) % if it's not a real number
    errordlg('The gain must be a number between -20 to 20',...
        'Input Error','modal');
    ChangeGainEditText(handles);    % change the edit text back
else    % if the format is correct
    handles.filterGain(11) = gain;   % save the gain
    guidata(hObject, handles);      % Update handles structure
    set(handles.sliders(11),'Value',gain);   % set the slider value
    ChangeGainEditText(handles);    % refresh the edit text
    PlotGain(handles);
end

function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double

% get current value
gainStr = get(hObject,'String');
gain = str2double(gainStr);
% check format
if(isnan(gain) || ~isreal(gain) || gain < -20 || gain > 20) % if it's not a real number
    errordlg('The gain must be a number between -20 to 20',...
        'Input Error','modal');
    ChangeGainEditText(handles);    % change the edit text back
else    % if the format is correct
    handles.filterGain(12) = gain;   % save the gain
    guidata(hObject, handles);      % Update handles structure
    set(handles.sliders(12),'Value',gain);   % set the slider value
    ChangeGainEditText(handles);    % refresh the edit text
    PlotGain(handles);
end

function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double

% get current value
gainStr = get(hObject,'String');
gain = str2double(gainStr);
% check format
if(isnan(gain) || ~isreal(gain) || gain < -20 || gain > 20) % if it's not a real number
    errordlg('The gain must be a number between -20 to 20',...
        'Input Error','modal');
    ChangeGainEditText(handles);    % change the edit text back
else    % if the format is correct
    handles.filterGain(13) = gain;   % save the gain
    guidata(hObject, handles);      % Update handles structure
    set(handles.sliders(13),'Value',gain);   % set the slider value
    ChangeGainEditText(handles);    % refresh the edit text
    PlotGain(handles);
end

function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double

% get current value
gainStr = get(hObject,'String');
gain = str2double(gainStr);
% check format
if(isnan(gain) || ~isreal(gain) || gain < -20 || gain > 20) % if it's not a real number
    errordlg('The gain must be a number between -20 to 20',...
        'Input Error','modal');
    ChangeGainEditText(handles);    % change the edit text back
else    % if the format is correct
    handles.filterGain(14) = gain;   % save the gain
    guidata(hObject, handles);      % Update handles structure
    set(handles.sliders(14),'Value',gain);   % set the slider value
    ChangeGainEditText(handles);    % refresh the edit text
    PlotGain(handles);
end

function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double

% get current value
gainStr = get(hObject,'String');
gain = str2double(gainStr);
% check format
if(isnan(gain) || ~isreal(gain) || gain < -20 || gain > 20) % if it's not a real number
    errordlg('The gain must be a number between -20 to 20',...
        'Input Error','modal');
    ChangeGainEditText(handles);    % change the edit text back
else    % if the format is correct
    handles.filterGain(15) = gain;   % save the gain
    guidata(hObject, handles);      % Update handles structure
    set(handles.sliders(15),'Value',gain);   % set the slider value
    ChangeGainEditText(handles);    % refresh the edit text
    PlotGain(handles);
end

function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double

% get current value
gainStr = get(hObject,'String');
gain = str2double(gainStr);
% check format
if(isnan(gain) || ~isreal(gain) || gain < -20 || gain > 20) % if it's not a real number
    errordlg('The gain must be a number between -20 to 20',...
        'Input Error','modal');
    ChangeGainEditText(handles);    % change the edit text back
else    % if the format is correct
    handles.filterGain(16) = gain;   % save the gain
    guidata(hObject, handles);      % Update handles structure
    set(handles.sliders(16),'Value',gain);   % set the slider value
    ChangeGainEditText(handles);    % refresh the edit text
    PlotGain(handles);
end

function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double

% get current value
gainStr = get(hObject,'String');
gain = str2double(gainStr);
% check format
if(isnan(gain) || ~isreal(gain) || gain < -20 || gain > 20) % if it's not a real number
    errordlg('The gain must be a number between -20 to 20',...
        'Input Error','modal');
    ChangeGainEditText(handles);    % change the edit text back
else    % if the format is correct
    handles.filterGain(17) = gain;   % save the gain
    guidata(hObject, handles);      % Update handles structure
    set(handles.sliders(17),'Value',gain);   % set the slider value
    ChangeGainEditText(handles);    % refresh the edit text
    PlotGain(handles);
end

function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double

% get current value
gainStr = get(hObject,'String');
gain = str2double(gainStr);
% check format
if(isnan(gain) || ~isreal(gain) || gain < -20 || gain > 20) % if it's not a real number
    errordlg('The gain must be a number between -20 to 20',...
        'Input Error','modal');
    ChangeGainEditText(handles);    % change the edit text back
else    % if the format is correct
    handles.filterGain(18) = gain;   % save the gain
    guidata(hObject, handles);      % Update handles structure
    set(handles.sliders(18),'Value',gain);   % set the slider value
    ChangeGainEditText(handles);    % refresh the edit text
    PlotGain(handles);
end

% --- Executes on dragging the slider.
function slider1_StateChangedCallback(hObject, eventdata, handles)
% hObject    handle to slider1
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data
% Update handles structure
% guidata(handles.equalizer,handles);

% Retrieve Latest handles structure
handles = guidata(handles.equalizer);

% get current value
gain = hObject.getValue();

% apply change to filterGain
handles.filterGain(1) = gain;
% Update handles structure
guidata(handles.equalizer,handles);

% change the gain edit text
ChangeGainEditText(handles);

% --- Executes on dragging the slider.
function slider2_StateChangedCallback(hObject, eventdata, handles)
% hObject    handle to slider2
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data
% Update handles structure
% guidata(handles.equalizer,handles);

% Retrieve Latest handles structure
handles = guidata(handles.equalizer);

% get current value
gain = hObject.getValue();

% apply change to filterGain
handles.filterGain(2) = gain;
% Update handles structure
guidata(handles.equalizer,handles);

% change the gain edit text
ChangeGainEditText(handles);

% --- Executes on dragging the slider.
function slider3_StateChangedCallback(hObject, eventdata, handles)
% hObject    handle to slider3
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data
% Update handles structure
% guidata(handles.equalizer,handles);

% Retrieve Latest handles structure
handles = guidata(handles.equalizer);

% get current value
gain = hObject.getValue();

% apply change to filterGain
handles.filterGain(3) = gain;
% Update handles structure
guidata(handles.equalizer,handles);

% change the gain edit text
ChangeGainEditText(handles);

% --- Executes on dragging the slider.
function slider4_StateChangedCallback(hObject, eventdata, handles)
% hObject    handle to slider4
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data
% Update handles structure
% guidata(handles.equalizer,handles);

% Retrieve Latest handles structure
handles = guidata(handles.equalizer);

% get current value
gain = hObject.getValue();

% apply change to filterGain
handles.filterGain(4) = gain;
% Update handles structure
guidata(handles.equalizer,handles);

% change the gain edit text
ChangeGainEditText(handles);

% --- Executes on dragging the slider.
function slider5_StateChangedCallback(hObject, eventdata, handles)
% hObject    handle to slider5
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data
% Update handles structure
% guidata(handles.equalizer,handles);

% Retrieve Latest handles structure
handles = guidata(handles.equalizer);

% get current value
gain = hObject.getValue();

% apply change to filterGain
handles.filterGain(5) = gain;
% Update handles structure
guidata(handles.equalizer,handles);

% change the gain edit text
ChangeGainEditText(handles);

% --- Executes on dragging the slider.
function slider6_StateChangedCallback(hObject, eventdata, handles)
% hObject    handle to slider6
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data
% Update handles structure
% guidata(handles.equalizer,handles);

% Retrieve Latest handles structure
handles = guidata(handles.equalizer);

% get current value
gain = hObject.getValue();

% apply change to filterGain
handles.filterGain(6) = gain;
% Update handles structure
guidata(handles.equalizer,handles);

% change the gain edit text
ChangeGainEditText(handles);

% --- Executes on dragging the slider.
function slider7_StateChangedCallback(hObject, eventdata, handles)
% hObject    handle to slider7
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data
% Update handles structure
% guidata(handles.equalizer,handles);

% Retrieve Latest handles structure
handles = guidata(handles.equalizer);

% get current value
gain = hObject.getValue();

% apply change to filterGain
handles.filterGain(7) = gain;
% Update handles structure
guidata(handles.equalizer,handles);

% change the gain edit text
ChangeGainEditText(handles);

% --- Executes on dragging the slider.
function slider8_StateChangedCallback(hObject, eventdata, handles)
% hObject    handle to slider8
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data
% Update handles structure
% guidata(handles.equalizer,handles);

% Retrieve Latest handles structure
handles = guidata(handles.equalizer);

% get current value
gain = hObject.getValue();

% apply change to filterGain
handles.filterGain(8) = gain;
% Update handles structure
guidata(handles.equalizer,handles);

% change the gain edit text
ChangeGainEditText(handles);

% --- Executes on dragging the slider.
function slider9_StateChangedCallback(hObject, eventdata, handles)
% hObject    handle to slider9
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data
% Update handles structure
% guidata(handles.equalizer,handles);

% Retrieve Latest handles structure
handles = guidata(handles.equalizer);

% get current value
gain = hObject.getValue();

% apply change to filterGain
handles.filterGain(9) = gain;
% Update handles structure
guidata(handles.equalizer,handles);

% change the gain edit text
ChangeGainEditText(handles);

% --- Executes on dragging the slider.
function slider10_StateChangedCallback(hObject, eventdata, handles)
% hObject    handle to slider10
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data
% Update handles structure
% guidata(handles.equalizer,handles);

% Retrieve Latest handles structure
handles = guidata(handles.equalizer);

% get current value
gain = hObject.getValue();

% apply change to filterGain
handles.filterGain(10) = gain;
% Update handles structure
guidata(handles.equalizer,handles);

% change the gain edit text
ChangeGainEditText(handles);

% --- Executes on dragging the slider.
function slider11_StateChangedCallback(hObject, eventdata, handles)
% hObject    handle to slider11
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data
% Update handles structure
% guidata(handles.equalizer,handles);

% Retrieve Latest handles structure
handles = guidata(handles.equalizer);

% get current value
gain = hObject.getValue();

% apply change to filterGain
handles.filterGain(11) = gain;
% Update handles structure
guidata(handles.equalizer,handles);

% change the gain edit text
ChangeGainEditText(handles);

% --- Executes on dragging the slider.
function slider12_StateChangedCallback(hObject, eventdata, handles)
% hObject    handle to slider12
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data
% Update handles structure
% guidata(handles.equalizer,handles);

% Retrieve Latest handles structure
handles = guidata(handles.equalizer);

% get current value
gain = hObject.getValue();

% apply change to filterGain
handles.filterGain(12) = gain;
% Update handles structure
guidata(handles.equalizer,handles);

% change the gain edit text
ChangeGainEditText(handles);

% --- Executes on dragging the slider.
function slider13_StateChangedCallback(hObject, eventdata, handles)
% hObject    handle to slider13
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data
% Update handles structure
% guidata(handles.equalizer,handles);

% Retrieve Latest handles structure
handles = guidata(handles.equalizer);

% get current value
gain = hObject.getValue();

% apply change to filterGain
handles.filterGain(13) = gain;
% Update handles structure
guidata(handles.equalizer,handles);

% change the gain edit text
ChangeGainEditText(handles);

% --- Executes on dragging the slider.
function slider14_StateChangedCallback(hObject, eventdata, handles)
% hObject    handle to slider14
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data
% Update handles structure
% guidata(handles.equalizer,handles);

% Retrieve Latest handles structure
handles = guidata(handles.equalizer);

% get current value
gain = hObject.getValue();

% apply change to filterGain
handles.filterGain(14) = gain;
% Update handles structure
guidata(handles.equalizer,handles);

% change the gain edit text
ChangeGainEditText(handles);

% --- Executes on dragging the slider.
function slider15_StateChangedCallback(hObject, eventdata, handles)
% hObject    handle to slider15
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data
% Update handles structure
% guidata(handles.equalizer,handles);

% Retrieve Latest handles structure
handles = guidata(handles.equalizer);

% get current value
gain = hObject.getValue();

% apply change to filterGain
handles.filterGain(15) = gain;
% Update handles structure
guidata(handles.equalizer,handles);

% change the gain edit text
ChangeGainEditText(handles);

% --- Executes on dragging the slider.
function slider16_StateChangedCallback(hObject, eventdata, handles)
% hObject    handle to slider16
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data
% Update handles structure
% guidata(handles.equalizer,handles);

% Retrieve Latest handles structure
handles = guidata(handles.equalizer);

% get current value
gain = hObject.getValue();

% apply change to filterGain
handles.filterGain(16) = gain;
% Update handles structure
guidata(handles.equalizer,handles);

% change the gain edit text
ChangeGainEditText(handles);

% --- Executes on dragging the slider.
function slider17_StateChangedCallback(hObject, eventdata, handles)
% hObject    handle to slider17
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data
% Update handles structure
% guidata(handles.equalizer,handles);

% Retrieve Latest handles structure
handles = guidata(handles.equalizer);

% get current value
gain = hObject.getValue();

% apply change to filterGain
handles.filterGain(17) = gain;
% Update handles structure
guidata(handles.equalizer,handles);

% change the gain edit text
ChangeGainEditText(handles);

% --- Executes on dragging the slider.
function slider18_StateChangedCallback(hObject, eventdata, handles)
% hObject    handle to slider18
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data
% Update handles structure
% guidata(handles.equalizer,handles);

% Retrieve Latest handles structure
handles = guidata(handles.equalizer);

% get current value
gain = hObject.getValue();

% apply change to filterGain
handles.filterGain(18) = gain;
% Update handles structure
guidata(handles.equalizer,handles);

% change the gain edit text
ChangeGainEditText(handles);

% --- Executes on releasing the mouse on the slider.
function slider1_MouseReleasedCallback(hObject, eventdata, handles)
% hObject    handle to slider1
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data
% Update handles structure
% guidata(handles.equalizer,handles);

% Retrieve Latest handles structure
handles = guidata(handles.equalizer);

PlotGain(handles);

% --- Executes on releasing the mouse on the slider.
function slider2_MouseReleasedCallback(hObject, eventdata, handles)
% hObject    handle to slider2
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data
% Update handles structure
% guidata(handles.equalizer,handles);

% Retrieve Latest handles structure
handles = guidata(handles.equalizer);

PlotGain(handles);

% --- Executes on releasing the mouse on the slider.
function slider3_MouseReleasedCallback(hObject, eventdata, handles)
% hObject    handle to slider3
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data
% Update handles structure
% guidata(handles.equalizer,handles);

% Retrieve Latest handles structure
handles = guidata(handles.equalizer);

PlotGain(handles);

% --- Executes on releasing the mouse on the slider.
function slider4_MouseReleasedCallback(hObject, eventdata, handles)
% hObject    handle to slider4
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data
% Update handles structure
% guidata(handles.equalizer,handles);

% Retrieve Latest handles structure
handles = guidata(handles.equalizer);

PlotGain(handles);

% --- Executes on releasing the mouse on the slider.
function slider5_MouseReleasedCallback(hObject, eventdata, handles)
% hObject    handle to slider5
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data
% Update handles structure
% guidata(handles.equalizer,handles);

% Retrieve Latest handles structure
handles = guidata(handles.equalizer);

PlotGain(handles);

% --- Executes on releasing the mouse on the slider.
function slider6_MouseReleasedCallback(hObject, eventdata, handles)
% hObject    handle to slider6
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data
% Update handles structure
% guidata(handles.equalizer,handles);

% Retrieve Latest handles structure
handles = guidata(handles.equalizer);

PlotGain(handles);

% --- Executes on releasing the mouse on the slider.
function slider7_MouseReleasedCallback(hObject, eventdata, handles)
% hObject    handle to slider7
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data
% Update handles structure
% guidata(handles.equalizer,handles);

% Retrieve Latest handles structure
handles = guidata(handles.equalizer);

PlotGain(handles);

% --- Executes on releasing the mouse on the slider.
function slider8_MouseReleasedCallback(hObject, eventdata, handles)
% hObject    handle to slider8
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data
% Update handles structure
% guidata(handles.equalizer,handles);

% Retrieve Latest handles structure
handles = guidata(handles.equalizer);

PlotGain(handles);

% --- Executes on releasing the mouse on the slider.
function slider9_MouseReleasedCallback(hObject, eventdata, handles)
% hObject    handle to slider9
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data
% Update handles structure
% guidata(handles.equalizer,handles);

% Retrieve Latest handles structure
handles = guidata(handles.equalizer);

PlotGain(handles);

% --- Executes on releasing the mouse on the slider.
function slider10_MouseReleasedCallback(hObject, eventdata, handles)
% hObject    handle to slider10
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data
% Update handles structure
% guidata(handles.equalizer,handles);

% Retrieve Latest handles structure
handles = guidata(handles.equalizer);

PlotGain(handles);

% --- Executes on releasing the mouse on the slider.
function slider11_MouseReleasedCallback(hObject, eventdata, handles)
% hObject    handle to slider11
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data
% Update handles structure
% guidata(handles.equalizer,handles);

% Retrieve Latest handles structure
handles = guidata(handles.equalizer);

PlotGain(handles);

% --- Executes on releasing the mouse on the slider.
function slider12_MouseReleasedCallback(hObject, eventdata, handles)
% hObject    handle to slider12
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data
% Update handles structure
% guidata(handles.equalizer,handles);

% Retrieve Latest handles structure
handles = guidata(handles.equalizer);

PlotGain(handles);

% --- Executes on releasing the mouse on the slider.
function slider13_MouseReleasedCallback(hObject, eventdata, handles)
% hObject    handle to slider13
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data
% Update handles structure
% guidata(handles.equalizer,handles);

% Retrieve Latest handles structure
handles = guidata(handles.equalizer);

PlotGain(handles);

% --- Executes on releasing the mouse on the slider.
function slider14_MouseReleasedCallback(hObject, eventdata, handles)
% hObject    handle to slider14
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data
% Update handles structure
% guidata(handles.equalizer,handles);

% Retrieve Latest handles structure
handles = guidata(handles.equalizer);

PlotGain(handles);

% --- Executes on releasing the mouse on the slider.
function slider15_MouseReleasedCallback(hObject, eventdata, handles)
% hObject    handle to slider15
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data
% Update handles structure
% guidata(handles.equalizer,handles);

% Retrieve Latest handles structure
handles = guidata(handles.equalizer);

PlotGain(handles);

% --- Executes on releasing the mouse on the slider.
function slider16_MouseReleasedCallback(hObject, eventdata, handles)
% hObject    handle to slider16
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data
% Update handles structure
% guidata(handles.equalizer,handles);

% Retrieve Latest handles structure
handles = guidata(handles.equalizer);

PlotGain(handles);

% --- Executes on releasing the mouse on the slider.
function slider17_MouseReleasedCallback(hObject, eventdata, handles)
% hObject    handle to slider17
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data
% Update handles structure
% guidata(handles.equalizer,handles);

% Retrieve Latest handles structure
handles = guidata(handles.equalizer);

PlotGain(handles);

% --- Executes on releasing the mouse on the slider.
function slider18_MouseReleasedCallback(hObject, eventdata, handles)
% hObject    handle to slider18
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data
% Update handles structure
% guidata(handles.equalizer,handles);

% Retrieve Latest handles structure
handles = guidata(handles.equalizer);

PlotGain(handles);

function ChangeGainEditText(handles)
% Change all edit texts above the 18 sliders
% handles: structure with handles and user data

% Update edit texts
for i = 1:18
    strEditText = ['edit' num2str(i)];    % get the tag name of edit text
    set(handles.(strEditText), 'String',num2str(handles.filterGain(i)));     % set the edit text to gain
end

function PlotGain(handles)
% Plot the graph of gain in dB vs frequency in Hz
% handles: structure with handles and user data

% Retrieve gain value
freq = [55 77 110 156 220 311 440 622 880 1200 1800 2500 3500 5000 7000 10000 14000 20000];
gain = handles.filterGain;
% Use Piecewise Cubic Hermite Interpolating Polynomial
freqInter = linspace(0,30000,100000);
gainInter = pchip(freq,gain,freqInter);

% Set gain below 20 Hz and above 20000 Hz to 0
gainInter(freqInter < 20 | freqInter > 25000) = 0;

% Set gain that exceed 20 dB to 20 dB those that below -20 dB to -20 dB
gainInter(gainInter > 20) = 20;
gainInter(gainInter < -20) = -20;

% Plot the graph using logscale on x-axis
axes(handles.axes1);
semilogx(freq,gain,'o',freqInter,gainInter,'-');
axis([1 30000 -20 20]);
xlabel('Frequency / Hz');
ylabel('Gain / dB');