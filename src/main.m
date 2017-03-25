function varargout = main(varargin)
% MAIN MATLAB code for main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main

% Last Modified by GUIDE v2.5 16-Mar-2017 10:24:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
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

% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)

% Choose default command line output for main
handles.output = hObject;

% Initiate the array of structures refer to samples
for i = 1:16
    handles.samples(i).points = [];
    handles.samples(i).sampleRate = 0;
    handles.samples(i).selectPeriod = [];   % unit: samplePoints(used in chopping and graphing)
    handles.samples(i).filterGain = [];     % filter gain for tone control (units: dB, range: -20~20)
end

% Save the pad number of current selected sample
handles.curPad = 0;

% Draw a java slider
jRangeSlider = com.jidesoft.swing.RangeSlider(1,192000*10,1,192000*10);  % min,max,low,high
jRangeSlider = javacomponent(jRangeSlider, [174,680,939,25], hObject);
set(jRangeSlider, 'PaintTicks',true,...
        'Visible',0, 'Focusable',0,'SnapToTicks',0,...
        'StateChangedCallback',{@slider_StateChangedCallback,handles},...
        'MouseReleasedCallback',{@slider_MouseReleasedCallback,handles});
handles.slider = jRangeSlider;
    
% Update handles structure
guidata(hObject, handles);

function main_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to main (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear sound;    % stop playing when the GUI is closed

% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes during object creation, after setting all properties.
function chopStartEditText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to chopStartEditText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function chopEndEditText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to chopEndEditText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pad1.
function pad1_Callback(hObject, eventdata, handles)
% hObject    handle to pad1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% If in Load Mode, load samples into pad 1
if(get(handles.loadButton,'Value') == get(handles.loadButton,'Max'))
    LoadToPad(hObject,handles,1);
% If in Copy Mode
elseif(get(handles.copyButton,'Value') == get(handles.copyButton,'Max')) 
    CopyFromPadToPad(hObject,handles,1);
% If in Cut Mode
elseif(get(handles.cutButton,'Value') == get(handles.cutButton,'Max'))
    CutFromPadToPad(hObject,handles,1)
elseif(strcmp(get(handles.button1,'Visible'),'off')) % if no sample
    EmptyPadStatus(handles,1);
else    % if there is a sample
    % If in Save Mode, save samples from pad 1
    if(get(handles.saveButton,'Value') == get(handles.saveButton,'Max'))
        SaveFromPad(handles,1);
    % If in Delete Mode, delete samples from pad 1
    elseif(get(handles.deleteButton,'Value') == get(handles.deleteButton,'Max'))
        DelFromPad(hObject,handles,1);
    % Normal Play sound
    else
        SelectButton(hObject, handles, 1);
        PlayFromPad(handles, 1);
    end
end

% --- Executes on button press in pad2.
function pad2_Callback(hObject, eventdata, handles)
% hObject    handle to pad2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% If in Load Mode, load samples into pad 2
if(get(handles.loadButton,'Value') == get(handles.loadButton,'Max'))
    LoadToPad(hObject,handles,2);
% If in Copy Mode
elseif(get(handles.copyButton,'Value') == get(handles.copyButton,'Max')) 
    CopyFromPadToPad(hObject,handles,2);
% If in Cut Mode
elseif(get(handles.cutButton,'Value') == get(handles.cutButton,'Max'))
    CutFromPadToPad(hObject,handles,2)
elseif(strcmp(get(handles.button2,'Visible'),'off')) % if no sample
    EmptyPadStatus(handles,2);
else    % if there is a sample
    % If in Save Mode, save samples from pad 2
    if(get(handles.saveButton,'Value') == get(handles.saveButton,'Max'))
        SaveFromPad(handles,2);
    % If in Delete Mode, delete samples from pad 2
    elseif(get(handles.deleteButton,'Value') == get(handles.deleteButton,'Max'))
        DelFromPad(hObject,handles,2);
    % Normal Play sound
    else
        SelectButton(hObject, handles, 2);
        PlayFromPad(handles, 2);
    end
end

% --- Executes on button press in pad3.
function pad3_Callback(hObject, eventdata, handles)
% hObject    handle to pad3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% If in Load Mode, load samples into pad 3
if(get(handles.loadButton,'Value') == get(handles.loadButton,'Max'))
    LoadToPad(hObject,handles,3);
% If in Copy Mode
elseif(get(handles.copyButton,'Value') == get(handles.copyButton,'Max')) 
    CopyFromPadToPad(hObject,handles,3);
% If in Cut Mode
elseif(get(handles.cutButton,'Value') == get(handles.cutButton,'Max'))
    CutFromPadToPad(hObject,handles,3)
elseif(strcmp(get(handles.button3,'Visible'),'off')) % if no sample
    EmptyPadStatus(handles,3);
else    % if there is a sample
    % If in Save Mode, save samples from pad 3
    if(get(handles.saveButton,'Value') == get(handles.saveButton,'Max'))
        SaveFromPad(handles,3);
    % If in Delete Mode, delete samples from pad 3
    elseif(get(handles.deleteButton,'Value') == get(handles.deleteButton,'Max'))
        DelFromPad(hObject,handles,3);
    % Normal Play sound
    else
        SelectButton(hObject, handles, 3);
        PlayFromPad(handles, 3);
    end
end

% --- Executes on button press in pad4.
function pad4_Callback(hObject, eventdata, handles)
% hObject    handle to pad4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% If in Load Mode, load samples into pad 4
if(get(handles.loadButton,'Value') == get(handles.loadButton,'Max'))
    LoadToPad(hObject,handles,4);
% If in Copy Mode
elseif(get(handles.copyButton,'Value') == get(handles.copyButton,'Max')) 
    CopyFromPadToPad(hObject,handles,4);
% If in Cut Mode
elseif(get(handles.cutButton,'Value') == get(handles.cutButton,'Max'))
    CutFromPadToPad(hObject,handles,4)
elseif(strcmp(get(handles.button4,'Visible'),'off')) % if no sample
    EmptyPadStatus(handles,4);
else    % if there is a sample
    % If in Save Mode, save samples from pad 4
    if(get(handles.saveButton,'Value') == get(handles.saveButton,'Max'))
        SaveFromPad(handles,4);
    % If in Delete Mode, delete samples from pad 4
    elseif(get(handles.deleteButton,'Value') == get(handles.deleteButton,'Max'))
        DelFromPad(hObject,handles,4);
    % Normal Play sound
    else
        SelectButton(hObject, handles, 4);
        PlayFromPad(handles, 4);
    end
end

% --- Executes on button press in pad5.
function pad5_Callback(hObject, eventdata, handles)
% hObject    handle to pad5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% If in Load Mode, load samples into pad 5
if(get(handles.loadButton,'Value') == get(handles.loadButton,'Max'))
    LoadToPad(hObject,handles,5);
% If in Copy Mode
elseif(get(handles.copyButton,'Value') == get(handles.copyButton,'Max')) 
    CopyFromPadToPad(hObject,handles,5);
% If in Cut Mode
elseif(get(handles.cutButton,'Value') == get(handles.cutButton,'Max'))
    CutFromPadToPad(hObject,handles,5)
elseif(strcmp(get(handles.button5,'Visible'),'off')) % if no sample
    EmptyPadStatus(handles,5);
else    % if there is a sample
    % If in Save Mode, save samples from pad 5
    if(get(handles.saveButton,'Value') == get(handles.saveButton,'Max'))
        SaveFromPad(handles,5);
    % If in Delete Mode, delete samples from pad 5
    elseif(get(handles.deleteButton,'Value') == get(handles.deleteButton,'Max'))
        DelFromPad(hObject,handles,5);
    % Normal Play sound
    else
        SelectButton(hObject, handles, 5);
        PlayFromPad(handles, 5);
    end
end

% --- Executes on button press in pad6.
function pad6_Callback(hObject, eventdata, handles)
% hObject    handle to pad6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% If in Load Mode, load samples into pad 6
if(get(handles.loadButton,'Value') == get(handles.loadButton,'Max'))
    LoadToPad(hObject,handles,6);
% If in Copy Mode
elseif(get(handles.copyButton,'Value') == get(handles.copyButton,'Max')) 
    CopyFromPadToPad(hObject,handles,6);
% If in Cut Mode
elseif(get(handles.cutButton,'Value') == get(handles.cutButton,'Max'))
    CutFromPadToPad(hObject,handles,6)
elseif(strcmp(get(handles.button6,'Visible'),'off')) % if no sample
    EmptyPadStatus(handles,6);
else    % if there is a sample
    % If in Save Mode, save samples from pad 6
    if(get(handles.saveButton,'Value') == get(handles.saveButton,'Max'))
        SaveFromPad(handles,6);
    % If in Delete Mode, delete samples from pad 6
    elseif(get(handles.deleteButton,'Value') == get(handles.deleteButton,'Max'))
        DelFromPad(hObject,handles,6);
    % Normal Play sound
    else
        SelectButton(hObject, handles, 6);
        PlayFromPad(handles, 6);
    end
end

% --- Executes on button press in pad7.
function pad7_Callback(hObject, eventdata, handles)
% hObject    handle to pad7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% If in Load Mode, load samples into pad 7
if(get(handles.loadButton,'Value') == get(handles.loadButton,'Max'))
    LoadToPad(hObject,handles,7);
% If in Copy Mode
elseif(get(handles.copyButton,'Value') == get(handles.copyButton,'Max')) 
    CopyFromPadToPad(hObject,handles,7);
% If in Cut Mode
elseif(get(handles.cutButton,'Value') == get(handles.cutButton,'Max'))
    CutFromPadToPad(hObject,handles,7)
elseif(strcmp(get(handles.button7,'Visible'),'off')) % if no sample
    EmptyPadStatus(handles,7);
else    % if there is a sample
    % If in Save Mode, save samples from pad 7
    if(get(handles.saveButton,'Value') == get(handles.saveButton,'Max'))
        SaveFromPad(handles,7);
    % If in Delete Mode, delete samples from pad 7
    elseif(get(handles.deleteButton,'Value') == get(handles.deleteButton,'Max'))
        DelFromPad(hObject,handles,7);
    % Normal Play sound
    else
        SelectButton(hObject, handles, 7);
        PlayFromPad(handles, 7);
    end
end

% --- Executes on button press in pad8.
function pad8_Callback(hObject, eventdata, handles)
% hObject    handle to pad8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% If in Load Mode, load samples into pad 8
if(get(handles.loadButton,'Value') == get(handles.loadButton,'Max'))
    LoadToPad(hObject,handles,8);
% If in Copy Mode
elseif(get(handles.copyButton,'Value') == get(handles.copyButton,'Max')) 
    CopyFromPadToPad(hObject,handles,8);
% If in Cut Mode
elseif(get(handles.cutButton,'Value') == get(handles.cutButton,'Max'))
    CutFromPadToPad(hObject,handles,8)
elseif(strcmp(get(handles.button8,'Visible'),'off')) % if no sample
    EmptyPadStatus(handles,8);
else    % if there is a sample
    % If in Save Mode, save samples from pad 8
    if(get(handles.saveButton,'Value') == get(handles.saveButton,'Max'))
        SaveFromPad(handles,8);
    % If in Delete Mode, delete samples from pad 8
    elseif(get(handles.deleteButton,'Value') == get(handles.deleteButton,'Max'))
        DelFromPad(hObject,handles,8);
    % Normal Play sound
    else
        SelectButton(hObject, handles, 8);
        PlayFromPad(handles, 8);
    end
end

% --- Executes on button press in pad9.
function pad9_Callback(hObject, eventdata, handles)
% hObject    handle to pad9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% If in Load Mode, load samples into pad 9
if(get(handles.loadButton,'Value') == get(handles.loadButton,'Max'))
    LoadToPad(hObject,handles,9);
% If in Copy Mode
elseif(get(handles.copyButton,'Value') == get(handles.copyButton,'Max')) 
    CopyFromPadToPad(hObject,handles,9);
% If in Cut Mode
elseif(get(handles.cutButton,'Value') == get(handles.cutButton,'Max'))
    CutFromPadToPad(hObject,handles,9)
elseif(strcmp(get(handles.button9,'Visible'),'off')) % if no sample
    EmptyPadStatus(handles,9);
else    % if there is a sample
    % If in Save Mode, save samples from pad 9
    if(get(handles.saveButton,'Value') == get(handles.saveButton,'Max'))
        SaveFromPad(handles,9);
    % If in Delete Mode, delete samples from pad 9
    elseif(get(handles.deleteButton,'Value') == get(handles.deleteButton,'Max'))
        DelFromPad(hObject,handles,9);
    % Normal Play sound
    else
        SelectButton(hObject, handles, 9);
        PlayFromPad(handles, 9);
    end
end

% --- Executes on button press in pad10.
function pad10_Callback(hObject, eventdata, handles)
% hObject    handle to pad10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% If in Load Mode, load samples into pad 10
if(get(handles.loadButton,'Value') == get(handles.loadButton,'Max'))
    LoadToPad(hObject,handles,10);
% If in Copy Mode
elseif(get(handles.copyButton,'Value') == get(handles.copyButton,'Max')) 
    CopyFromPadToPad(hObject,handles,10);
% If in Cut Mode
elseif(get(handles.cutButton,'Value') == get(handles.cutButton,'Max'))
    CutFromPadToPad(hObject,handles,10)
elseif(strcmp(get(handles.button10,'Visible'),'off')) % if no sample
    EmptyPadStatus(handles,10);
else    % if there is a sample
    % If in Save Mode, save samples from pad 10
    if(get(handles.saveButton,'Value') == get(handles.saveButton,'Max'))
        SaveFromPad(handles,10);
    % If in Delete Mode, delete samples from pad 10
    elseif(get(handles.deleteButton,'Value') == get(handles.deleteButton,'Max'))
        DelFromPad(hObject,handles,10);
    % Normal Play sound
    else
        SelectButton(hObject, handles, 10);
        PlayFromPad(handles, 10);
    end
end

% --- Executes on button press in pad11.
function pad11_Callback(hObject, eventdata, handles)
% hObject    handle to pad11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% If in Load Mode, load samples into pad 11
if(get(handles.loadButton,'Value') == get(handles.loadButton,'Max'))
    LoadToPad(hObject,handles,11);
% If in Copy Mode
elseif(get(handles.copyButton,'Value') == get(handles.copyButton,'Max')) 
    CopyFromPadToPad(hObject,handles,11);
% If in Cut Mode
elseif(get(handles.cutButton,'Value') == get(handles.cutButton,'Max'))
    CutFromPadToPad(hObject,handles,11)
elseif(strcmp(get(handles.button11,'Visible'),'off')) % if no sample
    EmptyPadStatus(handles,11);
else    % if there is a sample
    % If in Save Mode, save samples from pad 11
    if(get(handles.saveButton,'Value') == get(handles.saveButton,'Max'))
        SaveFromPad(handles,11);
    % If in Delete Mode, delete samples from pad 11
    elseif(get(handles.deleteButton,'Value') == get(handles.deleteButton,'Max'))
        DelFromPad(hObject,handles,11);
    % Normal Play sound
    else
        SelectButton(hObject, handles, 11);
        PlayFromPad(handles, 11);
    end
end

% --- Executes on button press in pad12.
function pad12_Callback(hObject, eventdata, handles)
% hObject    handle to pad12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% If in Load Mode, load samples into pad 12
if(get(handles.loadButton,'Value') == get(handles.loadButton,'Max'))
    LoadToPad(hObject,handles,12);
% If in Copy Mode
elseif(get(handles.copyButton,'Value') == get(handles.copyButton,'Max')) 
    CopyFromPadToPad(hObject,handles,12);
% If in Cut Mode
elseif(get(handles.cutButton,'Value') == get(handles.cutButton,'Max'))
    CutFromPadToPad(hObject,handles,12)
elseif(strcmp(get(handles.button12,'Visible'),'off')) % if no sample
    EmptyPadStatus(handles,12);
else    % if there is a sample
    % If in Save Mode, save samples from pad 12
    if(get(handles.saveButton,'Value') == get(handles.saveButton,'Max'))
        SaveFromPad(handles,12);
    % If in Delete Mode, delete samples from pad 12
    elseif(get(handles.deleteButton,'Value') == get(handles.deleteButton,'Max'))
        DelFromPad(hObject,handles,12);
    % Normal Play sound
    else
        SelectButton(hObject, handles, 12);
        PlayFromPad(handles, 12);
    end
end

% --- Executes on button press in pad13.
function pad13_Callback(hObject, eventdata, handles)
% hObject    handle to pad13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% If in Load Mode, load samples into pad 13
if(get(handles.loadButton,'Value') == get(handles.loadButton,'Max'))
    LoadToPad(hObject,handles,13);
% If in Copy Mode
elseif(get(handles.copyButton,'Value') == get(handles.copyButton,'Max')) 
    CopyFromPadToPad(hObject,handles,13);
% If in Cut Mode
elseif(get(handles.cutButton,'Value') == get(handles.cutButton,'Max'))
    CutFromPadToPad(hObject,handles,13)
elseif(strcmp(get(handles.button13,'Visible'),'off')) % if no sample
    EmptyPadStatus(handles,13);
else    % if there is a sample
    % If in Save Mode, save samples from pad 13
    if(get(handles.saveButton,'Value') == get(handles.saveButton,'Max'))
        SaveFromPad(handles,13);
    % If in Delete Mode, delete samples from pad 13
    elseif(get(handles.deleteButton,'Value') == get(handles.deleteButton,'Max'))
        DelFromPad(hObject,handles,13);
    % Normal Play sound
    else
        SelectButton(hObject, handles, 13);
        PlayFromPad(handles, 13);
    end
end

% --- Executes on button press in pad14.
function pad14_Callback(hObject, eventdata, handles)
% hObject    handle to pad14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% If in Load Mode, load samples into pad 14
if(get(handles.loadButton,'Value') == get(handles.loadButton,'Max'))
    LoadToPad(hObject,handles,14);
% If in Copy Mode
elseif(get(handles.copyButton,'Value') == get(handles.copyButton,'Max')) 
    CopyFromPadToPad(hObject,handles,14);
% If in Cut Mode
elseif(get(handles.cutButton,'Value') == get(handles.cutButton,'Max'))
    CutFromPadToPad(hObject,handles,14)
elseif(strcmp(get(handles.button14,'Visible'),'off')) % if no sample
    EmptyPadStatus(handles,14);
else    % if there is a sample
    % If in Save Mode, save samples from pad 14
    if(get(handles.saveButton,'Value') == get(handles.saveButton,'Max'))
        SaveFromPad(handles,14);
    % If in Delete Mode, delete samples from pad 14
    elseif(get(handles.deleteButton,'Value') == get(handles.deleteButton,'Max'))
        DelFromPad(hObject,handles,14);
    % Normal Play sound
    else
        SelectButton(hObject, handles, 14);
        PlayFromPad(handles, 14);
    end
end

% --- Executes on button press in pad15.
function pad15_Callback(hObject, eventdata, handles)
% hObject    handle to pad15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% If in Load Mode, load samples into pad 15
if(get(handles.loadButton,'Value') == get(handles.loadButton,'Max'))
    LoadToPad(hObject,handles,15);
% If in Copy Mode
elseif(get(handles.copyButton,'Value') == get(handles.copyButton,'Max')) 
    CopyFromPadToPad(hObject,handles,15);
% If in Cut Mode
elseif(get(handles.cutButton,'Value') == get(handles.cutButton,'Max'))
    CutFromPadToPad(hObject,handles,15)
elseif(strcmp(get(handles.button15,'Visible'),'off')) % if no sample
    EmptyPadStatus(handles,15);
else    % if there is a sample
    % If in Save Mode, save samples from pad 15
    if(get(handles.saveButton,'Value') == get(handles.saveButton,'Max'))
        SaveFromPad(handles,15);
    % If in Delete Mode, delete samples from pad 15
    elseif(get(handles.deleteButton,'Value') == get(handles.deleteButton,'Max'))
        DelFromPad(hObject,handles,15);
    % Normal Play sound
    else
        SelectButton(hObject, handles, 15);
        PlayFromPad(handles, 15);
    end
end

% --- Executes on button press in pad16.
function pad16_Callback(hObject, eventdata, handles)
% hObject    handle to pad16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% If in Load Mode, load samples into pad 16
if(get(handles.loadButton,'Value') == get(handles.loadButton,'Max'))
    LoadToPad(hObject,handles,16);
% If in Copy Mode
elseif(get(handles.copyButton,'Value') == get(handles.copyButton,'Max')) 
    CopyFromPadToPad(hObject,handles,16);
% If in Cut Mode
elseif(get(handles.cutButton,'Value') == get(handles.cutButton,'Max'))
    CutFromPadToPad(hObject,handles,16)
elseif(strcmp(get(handles.button16,'Visible'),'off')) % if no sample
    EmptyPadStatus(handles,16);
else    % if there is a sample
    % If in Save Mode, save samples from pad 16
    if(get(handles.saveButton,'Value') == get(handles.saveButton,'Max'))
        SaveFromPad(handles,16);
    % If in Delete Mode, delete samples from pad 16
    elseif(get(handles.deleteButton,'Value') == get(handles.deleteButton,'Max'))
        DelFromPad(hObject,handles,16);
    % Normal Play sound
    else
        SelectButton(hObject, handles, 16);
        PlayFromPad(handles, 16);
    end
end

function LoadToPad(hObject,handles,num)
% Load an audio sample into the corresponding pad
%   hObject: handle to pad
%   handles: structure with handles and user data
%   num: the pad which the sample is loading into
[pathname, filename] = GetLoadPath();   % get file path
if filename == 0  % if user canceled to load
    set(handles.status,'String','Load Mode: Cancel to load');
else
    ShowBusyStatus(handles);    % show the 'Busy' status
    pause(.0000001);            % pause for a short time to allow status changes
    handles.samples(num) = Load([pathname, filename]);  % load the file to handles
    guidata(hObject, handles);  % update handles
    HideBusyStatus(handles);    % hide the 'Busy' status
    SetPadColor(handles);       % refresh the color of pads
    statusStr = sprintf('Load Mode: Successfully load ''%s'' into pad %d',filename,num);
    set(handles.status,'String',statusStr);
    ShowButton(handles, num);
    if(handles.curPad == num)   % if load into current selected pad, set curPad to 0
        handles.curPad = 0;
        guidata(hObject,handles);   % update handles
    end
    if(handles.curPad == 0)     % if there is no other sample
        SelectButton(hObject,handles,num);
    end
end

function SaveFromPad(handles,num)
% Save the sample to file from the corresponding pad
%   hObject: handle to pad
%   handles: structure with handles and user data
%   num: the pad which the sample is saving from
[pathname, filename] = GetSavePath(num);    % get file path
if filename == 0     % if user canceled to save
    set(handles.status,'String','Save Mode: Cancel to save');
else
    ShowBusyStatus(handles);    % show the 'Busy' status
    pause(.0000001);            % pause for a short time to allow status changes
    Save([pathname, filename],handles.samples(num));  % save the file
    HideBusyStatus(handles);    % hide the 'Busy' status
    statusStr = sprintf('Save Mode: Successfully save from pad %d as ''%s''',num,filename);
    set(handles.status,'String',statusStr);
end

function CopyFromPadToPad(hObject,handles,num)
% Copy the sample from a pad to another
%   hObject: handle to pad
%   handles: structure with handles and user data
%   num: the current pad
if(isempty(get(handles.copyButton,'UserData')))     % if it was the first click
    buttonStr = ['button',num2str(num)];    % the field name of the object
    if(strcmp(get(handles.(buttonStr),'Visible'),'off'))    % if no sample
        EmptyPadStatus(handles,num);
    else    % if there is a sample, save the pad number
        padStr = ['pad',num2str(num)];    % the field name of the object
        set(handles.(padStr),'BackgroundColor',[0.231 0.894 0.929]);   % change color to turquoise
        set(handles.copyButton,'UserData',num);     % save the pad number
        statusStr = sprintf('Copy Mode: Copy from pad %d to ...',num);   % show status
        set(handles.status,'String',statusStr);
    end
else    % if it was the second click, copy the sample and reset color
    copyFromPad = get(handles.copyButton,'UserData');
    ShowBusyStatus(handles);    % show the 'Busy' status
    pause(.0000001);            % pause for a short time to allow status changes
    handles.samples(num) = handles.samples(copyFromPad);   % copy the sample
    guidata(hObject, handles);  % update handles
    HideBusyStatus(handles);    % hide the 'Busy' status
    SetPadColor(handles);   % refresh color
    ShowButton(handles,num);
    if(handles.curPad == num && copyFromPad ~= num) % if it's copying from another pad to current pad
        handles.curPad = 0;
        guidata(hObject, handles);
        SelectButton(hObject, handles, num);
    end
    if(copyFromPad == handles.curPad) % if it's copying from current pad
        SelectButton(hObject, handles, num);  % select the copy-to pad
    end
    statusStr = sprintf('Copy Mode: Successfully copy from pad %d to pad %d',copyFromPad,num);   % show status
    if(num == copyFromPad)   % Add A Joke
        statusStr = [statusStr '...Wait...What are you thinking???'];
    end
    set(handles.status,'String',statusStr);
    set(handles.copyButton,'UserData',[]);      % reset UserData
end

function CutFromPadToPad(hObject,handles,num)
% Cut the sample from a pad to another
%   hObject: handle to pad
%   handles: structure with handles and user data
%   num: the current pad
if(isempty(get(handles.cutButton,'UserData')))     % if it was the first click
    buttonStr = ['button',num2str(num)];    % the field name of the object
    if(strcmp(get(handles.(buttonStr),'Visible'),'off'))    % if no sample
        EmptyPadStatus(handles,num);
    else    % if there is a sample, save the pad number
        padStr = ['pad',num2str(num)];    % the field name of the object
        set(handles.(padStr),'BackgroundColor',[0.231 0.392 0.929]);   % change color to blue
        set(handles.cutButton,'UserData',num);     % save the pad number
        statusStr = sprintf('Cut Mode: Cut from pad %d to ...',num);   % show status
        set(handles.status,'String',statusStr);
    end
else    % if it was the second click, copy the sample, delete the original and reset color
    cutFromPad = get(handles.cutButton,'UserData');
    ShowBusyStatus(handles);    % show the 'Busy' status
    pause(.0000001);            % pause for a short time to allow status changes
    handles.samples(num) = handles.samples(cutFromPad);   % copy the sample
    if(num ~= cutFromPad)    % if cutting a pad to itself will not delete the sample
        handles.samples(cutFromPad).points = [];  % delete the original sample
        handles.samples(cutFromPad).sampleRate = 0;
        handles.samples(cutFromPad).selectPeriod = [];
        handles.samples(cutFromPad).filterGain = [];
    end
    guidata(hObject, handles);  % update handles
    HideBusyStatus(handles);    % hide the 'Busy' status
    HideButton(handles, cutFromPad);  % hide the button of original pad
    ShowButton(handles,num);    % show the button of new pad
    if(handles.curPad == num && cutFromPad ~= num) % if it's cutting from another pad to current pad
        handles.curPad = 0;
        guidata(hObject, handles);
        SelectButton(hObject, handles, num);
    end
    if(cutFromPad == handles.curPad) % if it's cutting from current pad
        SelectButton(hObject, handles, num);  % select the cut-to pad
    end
    SetPadColor(handles);   % refresh color
    statusStr = sprintf('Cut Mode: Successfully cut from pad %d to pad %d',cutFromPad,num);   % show status
    if(num == cutFromPad)   % Add A Joke
        statusStr = [statusStr '...Wait...What are you thinking???'];
    end
    set(handles.status,'String',statusStr);
    set(handles.cutButton,'UserData',[]);      % reset UserData
end

function DelFromPad(hObject,handles,num)
% Delete the sample from the corresponding pad
%   hObject: handle to pad
%   handles: structure with handles and user data
%   num: the pad which the sample needs to be deleted
ShowBusyStatus(handles);    % show the 'Busy' status
pause(.0000001);            % pause for a short time to allow status changes
handles.samples(num).points = [];  % delete the sample
handles.samples(num).sampleRate = 0;
handles.samples(num).selectPeriod = [];
handles.samples(num).filterGain = [];
guidata(hObject, handles);  % update handles
HideBusyStatus(handles);    % hide the 'Busy' status
SetPadColor(handles);       % refresh the color of pads

statusStr = sprintf('Delete Mode: Successfully delete the sample in pad %d',num);
set(handles.status,'String',statusStr);

HideButton(handles, num);   % Hide the button
if(handles.curPad == num)   % If trying to delete the current pad
    SelectOtherButton(hObject,handles);     % Select other buttons (if any)
end

function PlayFromPad(handles, num)
% Play the sample from the corresponding pad
%   handles: structure with handles and user data
%   num: the pad which the sample needs to be played
ShowBusyStatus(handles);% show the 'Busy' status
pause(0.0000001);       % pause for a short time to allow status changes
PlaySound(handles.samples(num));
HideBusyStatus(handles);    % hide the 'Busy' status
PlayStatus(handles,num);  % show the 'Playing' status

function [pathname, filename] = GetLoadPath()
[filename, pathname] = uigetfile(...
    {'*.aiff;*.aif;*.aifc;*.au;*.flac;*.m4a;*.mp3;*.mp4;*.oga;*.ogg;*.snd;*.wav',....
    'Audio (*.aiff, *.aif, *.aifc, *.au, *.flac, *.m4a, *.mp3, *.mp4, *.oga, *.ogg, *.snd, *.wav)'},...
    'Select an audio file');

function [pathname, filename] = GetSavePath(num)
defaultFilename = ['pad' num2str(num)];
[filename, pathname] = uiputfile(...
    {'*.wav','Waveform Audio File (*.wav)';...
    '*.m4a;*.mp4','MPEG-4 (*.m4a, *.mp4)';...
    '*.flac','Free Lossless Audio Codec (*.flac)';...
    '*.ogg;*.oga','Ogg Vorbis (*.ogg, *.oga)'},...
    'Save as an audio file', defaultFilename);

% --- Executes on button press in button1.
function button1_Callback(hObject, eventdata, handles)
% hObject    handle to button1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of button1
SelectButton(hObject, handles, 1);  % select the button
SelectStatus(handles,1);    % show status

% --- Executes on button press in button2.
function button2_Callback(hObject, eventdata, handles)
% hObject    handle to button2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of button2
SelectButton(hObject, handles, 2);  % select the button
SelectStatus(handles,2);    % show status

% --- Executes on button press in button3.
function button3_Callback(hObject, eventdata, handles)
% hObject    handle to button3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of button3
SelectButton(hObject, handles, 3);  % select the button
SelectStatus(handles,3);    % show status

% --- Executes on button press in button4.
function button4_Callback(hObject, eventdata, handles)
% hObject    handle to button4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of button4
SelectButton(hObject, handles, 4);  % select the button
SelectStatus(handles,4);    % show status

% --- Executes on button press in button5.
function button5_Callback(hObject, eventdata, handles)
% hObject    handle to button5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of button5
SelectButton(hObject, handles, 5);  % select the button
SelectStatus(handles,5);    % show status

% --- Executes on button press in button6.
function button6_Callback(hObject, eventdata, handles)
% hObject    handle to button6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of button6
SelectButton(hObject, handles, 6);  % select the button
SelectStatus(handles,6);    % show status

% --- Executes on button press in button7.
function button7_Callback(hObject, eventdata, handles)
% hObject    handle to button7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of button7
SelectButton(hObject, handles, 7);  % select the button
SelectStatus(handles,7);    % show status

% --- Executes on button press in button8.
function button8_Callback(hObject, eventdata, handles)
% hObject    handle to button8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of button8
SelectButton(hObject, handles, 8);  % select the button
SelectStatus(handles,8);    % show status

% --- Executes on button press in button9.
function button9_Callback(hObject, eventdata, handles)
% hObject    handle to button9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of button9
SelectButton(hObject, handles, 9);  % select the button
SelectStatus(handles,9);    % show status

% --- Executes on button press in button10.
function button10_Callback(hObject, eventdata, handles)
% hObject    handle to button10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of button10
SelectButton(hObject, handles, 10);  % select the button
SelectStatus(handles,10);    % show status

% --- Executes on button press in button11.
function button11_Callback(hObject, eventdata, handles)
% hObject    handle to button11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of button11
SelectButton(hObject, handles, 11);  % select the button
SelectStatus(handles,11);    % show status

% --- Executes on button press in button12.
function button12_Callback(hObject, eventdata, handles)
% hObject    handle to button12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of button12
SelectButton(hObject, handles, 12);  % select the button
SelectStatus(handles,12);    % show status

% --- Executes on button press in button13.
function button13_Callback(hObject, eventdata, handles)
% hObject    handle to button13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of button13
SelectButton(hObject, handles, 13);  % select the button
SelectStatus(handles,13);    % show status

% --- Executes on button press in button14.
function button14_Callback(hObject, eventdata, handles)
% hObject    handle to button14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of button14
SelectButton(hObject, handles, 14);  % select the button
SelectStatus(handles,14);    % show status

% --- Executes on button press in button15.
function button15_Callback(hObject, eventdata, handles)
% hObject    handle to button15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of button15
SelectButton(hObject, handles, 15);  % select the button
SelectStatus(handles,15);    % show status

% --- Executes on button press in button16.
function button16_Callback(hObject, eventdata, handles)
% hObject    handle to button16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of button16
SelectButton(hObject, handles, 16);  % select the button
SelectStatus(handles,16);    % show status

% --- Executes on button press in loadButton.
function loadButton_Callback(hObject, eventdata, handles)
% hObject    handle to loadButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of loadButton
button_state = get(hObject,'Value');
if button_state == get(hObject,'Max')
    set(handles.status,'String',...
        'Load Mode: Click on the pads to load your samples and reclick ''Load'' to quit');
    set(handles.saveButton,'Visible','off');
    set(handles.copyButton,'Visible','off');
    set(handles.cutButton,'Visible','off');
    set(handles.deleteButton,'Visible','off');
    SetPadColor(handles);
elseif button_state == get(hObject,'Min')
    set(handles.saveButton,'Visible','on');
    set(handles.copyButton,'Visible','on');
    set(handles.cutButton,'Visible','on');
    set(handles.deleteButton,'Visible','on');
    ResetPadColor(handles);
    ClearStatus(handles);
end

% --- Executes on button press in saveButton.
function saveButton_Callback(hObject, eventdata, handles)
% hObject    handle to saveButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of saveButton
button_state = get(hObject,'Value');
if button_state == get(hObject,'Max')
    set(handles.status,'String',...
        'Save Mode: Click on the pads to save your samples and reclick ''Save'' to quit');
    set(handles.loadButton,'Visible','off');
    set(handles.copyButton,'Visible','off');
    set(handles.cutButton,'Visible','off');
    set(handles.deleteButton,'Visible','off');
    SetPadColor(handles);
elseif button_state == get(hObject,'Min')
    set(handles.loadButton,'Visible','on');
    set(handles.copyButton,'Visible','on');
    set(handles.cutButton,'Visible','on');
    set(handles.deleteButton,'Visible','on');
    ResetPadColor(handles);
    ClearStatus(handles);
end

% --- Executes on button press in copyButton.
function copyButton_Callback(hObject, eventdata, handles)
% hObject    handle to copyButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of copyButton
button_state = get(hObject,'Value');
if button_state == get(hObject,'Max')
    set(handles.status,'String',...
        'Copy Mode: Click on the pads to copy your samples from one pad to another and reclick ''Copy'' to cancel');
    set(handles.loadButton,'Visible','off');
    set(handles.saveButton,'Visible','off');
    set(handles.cutButton,'Visible','off');
    set(handles.deleteButton,'Visible','off');
    SetPadColor(handles);
elseif button_state == get(hObject,'Min')
    set(hObject,'UserData',[]);     % reset UserData
    set(handles.loadButton,'Visible','on');
    set(handles.saveButton,'Visible','on');
    set(handles.cutButton,'Visible','on');
    set(handles.deleteButton,'Visible','on');
    ResetPadColor(handles);
    ClearStatus(handles);
end

% --- Executes on button press in cutButton.
function cutButton_Callback(hObject, eventdata, handles)
% hObject    handle to cutButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cutButton
button_state = get(hObject,'Value');
if button_state == get(hObject,'Max')
    set(handles.status,'String',...
        'Cut Mode: Click on the pads to move your samples from one pad to another and reclick ''Cut'' to cancel');
    set(handles.loadButton,'Visible','off');
    set(handles.saveButton,'Visible','off');
    set(handles.copyButton,'Visible','off');
    set(handles.deleteButton,'Visible','off');
    SetPadColor(handles);
elseif button_state == get(hObject,'Min')
    set(hObject,'UserData',[]);     % reset UserData
    set(handles.loadButton,'Visible','on');
    set(handles.saveButton,'Visible','on');
    set(handles.copyButton,'Visible','on');
    set(handles.deleteButton,'Visible','on');
    ResetPadColor(handles);
    ClearStatus(handles);
end

% --- Executes on button press in deleteButton.
function deleteButton_Callback(hObject, eventdata, handles)
% hObject    handle to deleteButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of deleteButton
button_state = get(hObject,'Value');
if button_state == get(hObject,'Max')
    set(handles.status,'String',...
        'Delete Mode: Click on the pads to delete your samples from the pad and reclick ''Delete'' to quit');
    set(handles.loadButton,'Visible','off');
    set(handles.saveButton,'Visible','off');
    set(handles.copyButton,'Visible','off');
    set(handles.cutButton,'Visible','off');
    SetPadColor(handles);
elseif button_state == get(hObject,'Min')
    set(handles.loadButton,'Visible','on');
    set(handles.saveButton,'Visible','on');
    set(handles.copyButton,'Visible','on');
    set(handles.cutButton,'Visible','on');
    ResetPadColor(handles);
    ClearStatus(handles);
end

function Plot(handles)
% Plot the waveplot of selected sample
%   handles: structure with handles and user data
num = handles.curPad;   % get the current pad
ShowBusyStatus(handles);    % show the 'Busy' status
pause(.0000001);            % pause for a short time to allow status changes
if(size(handles.samples(num).points,2) == 1) % if the sample is mono
    set(handles.axes1,'Visible','on');
    set(handles.axes2,'Visible','off');
    
    WavePlot(handles.axes1, handles.samples(num).points, handles.samples(num).sampleRate);
    ChangePlotXAxisLabel(handles.axes1, handles);
    set(handles.axes1,'XAxisLocation','top',...
            'Position',[181 450 925 212],...
            'Box','on');
else % if the sample is stereo
    set(handles.axes1,'Visible','on');
    set(handles.axes2,'Visible','on');
    
    WavePlot(handles.axes1, handles.samples(num).points(:,1), handles.samples(num).sampleRate);
    WavePlot(handles.axes2, handles.samples(num).points(:,2), handles.samples(num).sampleRate);
    ChangePlotXAxisLabel(handles.axes1, handles);
    ChangePlotXAxisLabel(handles.axes2, handles);
    set(handles.axes1,'XAxisLocation','top',...
            'Position',[181 562 925 100],...
            'Box','on');
    set(handles.axes2,'XAxisLocation','top',...
            'Position',[181 450 925 100],...
            'XTickLabel',{},...
            'Box','on');
end
pause(.0000001);            % pause for a short time

% change the start & end time edit text
ChangeChopEditText(handles);

% get the select period and lasting time
period = handles.samples(num).selectPeriod;
duration = size(handles.samples(num).points,1);
% set the slider to current property
set(handles.slider,'Minimum',1,'Maximum',duration,...
            'LowValue',period(1),'HighValue',period(2));

% set slider and chopping visible
set(handles.slider,'Visible',1);
set(handles.chopStartStaticText,'Visible','on');
set(handles.chopStartEditText,'Visible','on');
set(handles.chopEndStaticText,'Visible','on');
set(handles.chopEndEditText,'Visible','on');
set(handles.chopButton,'Visible','on');

HideBusyStatus(handles);    % hide the 'Busy' status

function ChangePlotXAxisLabel(ax, handles)
% Change the x-axis of the waveplot
%   ax: the axis of the waveplot
%   handles: structure with handles and user data
ShowBusyStatus(handles);    % show the 'Busy' status

num = handles.curPad;   % get the current pad
sampleRate = handles.samples(num).sampleRate;   % get the current sample rate
startTime = handles.samples(num).selectPeriod(1)/sampleRate;   % get start time in sec
endTime = handles.samples(num).selectPeriod(2)/sampleRate;     % get end time in sec
[interval,factor,format] = GetTimeFormat(handles);     % Calculate the interval and format for time

xtick = ceil(startTime*factor)/factor + interval.* [0:14];
xticklabel = cell(1,15);
for i = 1:15
    if(xtick(i) > 3600)
        xticklabel{i} = string(duration([0 0 xtick(i)],'Format',['hh:',format]));
    else
        xticklabel{i} = string(duration([0 0 xtick(i)],'Format',format));
    end
end
axes(ax);
if(startTime >= endTime)
    set(handles.status,'String','Too small interval, please first chop the sample down');
else
    xlim([startTime endTime]);
    set(ax,'XTick',xtick,'XTickLabel',xticklabel);
end

HideBusyStatus(handles);    % hide the 'Busy' status

% --- Executes on dragging the slider.
function slider_StateChangedCallback(hObject, eventdata, handles)
% hObject    handle to jRandeSlider
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data
% Update handles structure
% guidata(handles.main,handles);
ClearStatus(handles);
% Retrieve Latest handles structure
handles = guidata(handles.main);

% get current select period
low = hObject.getLowValue();
high = hObject.getHighValue();
curPeriod = [low high];

% apply change to selectPeriod
num = handles.curPad;   % get the current pad
handles.samples(num).selectPeriod = curPeriod;
% Update handles structure
guidata(handles.main,handles);

% change the start & end time edit text
ChangeChopEditText(handles);

% --- Executes on releasing the mouse on the slider.
function slider_MouseReleasedCallback(hObject, eventdata, handles)
% hObject    handle to jRandeSlider
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data
% Update handles structure
% guidata(handles.main,handles);

% Retrieve Latest handles structure
handles = guidata(handles.main);

num = handles.curPad;   % get the current pad
% Change x-axis label
if(size(handles.samples(num).points,2) == 1) % if the sample is mono
    ChangePlotXAxisLabel(handles.axes1, handles);
else % if the sample is stereo
    ChangePlotXAxisLabel(handles.axes1, handles);
    ChangePlotXAxisLabel(handles.axes2, handles);
    set(handles.axes2, 'XTickLabel',{});
end

function chopStartEditText_Callback(hObject, eventdata, handles)
% hObject    handle to chopStartEditText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of chopStartEditText as text
%        str2double(get(hObject,'String')) returns contents of chopStartEditText as a double
ClearStatus(handles);

num = handles.curPad;   % get the current pad
sampleRate = handles.samples(num).sampleRate;   % get the current sample rate
str = get(hObject,'String');
seconds = ConvertStrToTime(str,handles);

if(~isempty(seconds)) % if the format is correct
    startTime = seconds * sampleRate;
    if(startTime < 0 || startTime > size(handles.samples(num).points,1)) % if the start time is out of bound
        set(handles.status,'String','Error: Start time out of bound');
    elseif(startTime > handles.samples(num).selectPeriod(2)) % if the start time > end time
        set(handles.status,'String','Error: Start time should not be larger than end time');
    else
        if(startTime == 0)  % if it's the first sample
            startTime = 1;
        end
        handles.samples(num).selectPeriod(1) = startTime;
        % Update handles structure
        guidata(hObject,handles);
        set(handles.slider,'LowValue',startTime);
        % Change x-axis label
        if(size(handles.samples(num).points,2) == 1) % if the sample is mono
            ChangePlotXAxisLabel(handles.axes1, handles);
        else % if the sample is stereo
            ChangePlotXAxisLabel(handles.axes1, handles);
            ChangePlotXAxisLabel(handles.axes2, handles);
            set(handles.axes2, 'XTickLabel',{});
        end
    end
end
ChangeChopEditText(handles);

function chopEndEditText_Callback(hObject, eventdata, handles)
% hObject    handle to chopEndEditText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of chopEndEditText as text
%        str2double(get(hObject,'String')) returns contents of chopEndEditText as a double
ClearStatus(handles);

num = handles.curPad;   % get the current pad
sampleRate = handles.samples(num).sampleRate;   % get the current sample rate
str = get(hObject,'String');
seconds = ConvertStrToTime(str,handles);

if(~isempty(seconds)) % if the format is correct
    endTime = seconds * sampleRate;
    if(endTime < 0 || endTime > size(handles.samples(num).points,1)) % if the end time is out of bound
        set(handles.status,'String','Error: End time out of bound');
    elseif(endTime < handles.samples(num).selectPeriod(1)) % if the start time < end time
        set(handles.status,'String','Error: End time should not be smaller than start time');
    else
        if(endTime == 0)  % if it's the first sample
            endTime = 1;
        end
        handles.samples(num).selectPeriod(2) = endTime;
        % Update handles structure
        guidata(hObject,handles);
        set(handles.slider,'HighValue',endTime);
        % Change x-axis label
        if(size(handles.samples(num).points,2) == 1) % if the sample is mono
            ChangePlotXAxisLabel(handles.axes1, handles);
        else % if the sample is stereo
            ChangePlotXAxisLabel(handles.axes1, handles);
            ChangePlotXAxisLabel(handles.axes2, handles);
            set(handles.axes2, 'XTickLabel',{});
        end
    end
end
ChangeChopEditText(handles);

function seconds = ConvertStrToTime(str,handles)
% convert a string to time in seconds
%   str: the input string
%   seconds: the corresponding time in seconds
[C,matches] = strsplit(str,':');
C = str2double(C);
if(any(isnan(C)) || ~isreal(C) || length(matches) > 2) % if any of the element in C is NaN, complex numberor or two ':', wrong format
    set(handles.status,'String','Error: Wrong time format');
    seconds = [];
else    % correct format
    if(isempty(matches)) % if there is no ':', just seconds
        seconds = C;
    elseif(length(matches) == 1) % if the time is 'mm:ss.SSS'
        seconds = C(1) * 60 + C(2);
    else    % if the time is 'hh:mm:ss.SSS'
        seconds = C(1) * 3600 + C(2) * 60 + C(3);
    end
end
    
% --- Executes on button press in chopButton.
function chopButton_Callback(hObject, eventdata, handles)
% hObject    handle to chopButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ShowBusyStatus(handles);    % show the 'Busy' status
pause(.0000001);            % pause for a short time to allow status changes
clear sound;            % stop playing
num = handles.curPad;   % get the current pad
startSample = handles.samples(num).selectPeriod(1);
endSample = handles.samples(num).selectPeriod(2);
handles.samples(num).points = handles.samples(num).points(startSample:endSample,:);
handles.samples(num).selectPeriod = [1 size(handles.samples(num).points,1)];
% Update handles structure
guidata(hObject,handles);
% Show status
statusStr = sprintf('Successfully chopped pad %d',num);
set(handles.status,'String',statusStr);
Plot(handles);
HideBusyStatus(handles);    % hide the 'Busy' status

function ChangeChopEditText(handles)
% change the chop start & end edit text
[~,~,format] = GetTimeFormat(handles);    % Calculate the format for time
num = handles.curPad;   % get the current pad
sampleRate = handles.samples(num).sampleRate;   % get the current sample rate
startTime = handles.samples(num).selectPeriod(1)/sampleRate;   % get start time in sec
endTime = handles.samples(num).selectPeriod(2)/sampleRate;     % get end time in sec
% change start time edit text
if(startTime > 3600)
    set(handles.chopStartEditText,'String',...
        string(duration([0 0 startTime],'Format',['hh:',format])));
else
    set(handles.chopStartEditText,'String',...
        string(duration([0 0 startTime],'Format',format)));
end
% change end time edit text
if(endTime > 3600)
    set(handles.chopEndEditText,'String',...
        string(duration([0 0 endTime],'Format',['hh:',format])));
else
    set(handles.chopEndEditText,'String',...
        string(duration([0 0 endTime],'Format',format)));
end

function [interval,factor,format] = GetTimeFormat(handles)
% Calculate the interval and format for time
%   handles: structure with handles and user data
%   interval: the interval of waveplot x-axis
%   format: the format for duration conversion
num = handles.curPad;   % get the current pad
sampleRate = handles.samples(num).sampleRate;   % get the current sample rate
startTime = handles.samples(num).selectPeriod(1)/sampleRate;   % get start time in sec
endTime = handles.samples(num).selectPeriod(2)/sampleRate;     % get end time in sec
elapseTime = endTime - startTime;
if(elapseTime >= 15) % 15 s
    interval = ceil(elapseTime / 15);
    format = 'mm:ss';
    factor = 1;
elseif(elapseTime >= 1.5) % 1.5 s
    interval = ceil(elapseTime*10 / 15)/10;
    format = 'mm:ss.S';
    factor = 10;
elseif(elapseTime >= 0.15) % 0.15 s
    interval = ceil(elapseTime*100 / 15)/100;
    format = 'mm:ss.SS';
    factor = 100;
elseif(elapseTime >= 0.015) % 0.015 s
    interval = ceil(elapseTime*1000 / 15)/1000;
    format = 'mm:ss.SSS';
    factor = 1000;
elseif(elapseTime >= 0.0015) % 0.0015 s
    interval = ceil(elapseTime*10000 / 15)/10000;
    format = 'mm:ss.SSSS';
    factor = 10000;
elseif(elapseTime >= 0.00015) % 0.00015 s
    interval = ceil(elapseTime*100000 / 15)/100000;
    format = 'mm:ss.SSSSS';
    factor = 100000;
elseif(elapseTime >= 0.000015) % 0.000015 s
    interval = ceil(elapseTime*1000000 / 15)/1000000;
    format = 'mm:ss.SSSSSS';
    factor = 1000000;
else % < 0.000015 s
    interval = ceil(elapseTime*10000000 / 15)/10000000;
    format = 'mm:ss.SSSSSSS';
    factor = 10000000;
end

function SetPadColor(handles)
% Set the color of empty pad to red and others to green
for i = 1:16
    str = ['pad',num2str(i)];    % the field name of the object
    if(isempty(handles.samples(i).points))
        set(handles.(str),'BackgroundColor',[0.8 0.255 0.29]);
    else
        set(handles.(str),'BackgroundColor',[0.542 0.907 0.289]);
    end
end

function ResetPadColor(handles)
% Reset the color of pads to default
for i = 1:16
    str = ['pad',num2str(i)];    % the field name of the object
    set(handles.(str),'BackgroundColor',[0.94 0.94 0.94]);
end

function ShowButton(handles, num)
% Show the button of the corresponding pad
str = ['button',num2str(num)];
set(handles.(str),'Visible','on');

function SelectButton(hObject, handles, num)
% Select the button of the corresponding pad
str = ['button',num2str(num)];
set(handles.(str),'Value',get(handles.(str),'Max'));
% if current pad is 0, clear the sound;
% if the current pad is going to be selected or Copy Mode or Cut Mode,
% continue to play;
% otherwise, stop playing
if(handles.curPad == 0 || ~(handles.curPad == num || ...
        get(handles.copyButton,'Value') == get(handles.copyButton,'Max') ||...
        get(handles.cutButton,'Value') == get(handles.cutButton,'Max')))
    clear sound;
end
copyCurPad = handles.curPad;
handles.curPad = num;
guidata(hObject, handles);
% if current pad is 0, plot the graph;
% if it's in Copy Mode or Cut Mode, don't plot the gragh;
% otherwise, plot the graph
if(copyCurPad == 0 || ~(get(handles.copyButton,'Value') == get(handles.copyButton,'Max') ||...
        get(handles.cutButton,'Value') == get(handles.cutButton,'Max')))
    Plot(handles);
end

function HideButton(handles, num)
% Hide the button of the correponding pad
str = ['button',num2str(num)];
set(handles.(str),'Visible','off');

function SelectOtherButton(hObject,handles)
% Select another available pad
for i = 1:16
    str = ['button',num2str(i)];    % the field name of the object
    if(strcmp(get(handles.(str),'Visible'), 'on')) % if it's available
        SelectButton(hObject, handles, i);
        break;
    end
end
% if there is no loaded pad
if(i == 16 && strcmp(get(handles.button16,'Visible'), 'off'))
    clear sound;            % stop playing current pad
    handles.curPad = 0;
    guidata(hObject, handles);  % update handles
    % hide the graph and the chopping seletion
    cla(handles.axes1);
    cla(handles.axes2);
    set(handles.axes1,'Visible','off');
    set(handles.axes2,'Visible','off');
    set(handles.slider,'Visible',0);
    set(handles.chopStartStaticText,'Visible','off');
    set(handles.chopStartEditText,'Visible','off');
    set(handles.chopEndStaticText,'Visible','off');
    set(handles.chopEndEditText,'Visible','off');
    set(handles.chopButton,'Visible','off');
end

function SelectStatus(handles,num)
% Show the 'Select' status
    statusStr = sprintf('Pad %d selected',num);
    set(handles.status,'String',statusStr);

function PlayStatus(handles,num)
% Show the 'Playing' status
    statusStr = sprintf('Playing from pad %d',num);
    set(handles.status,'String',statusStr);

function EmptyPadStatus(handles,num)
% Show the 'Empty Pad' status
    statusStr = sprintf('Empty pad %d, please first load/copy a sample or use piano keyboard',num);
    set(handles.status,'String',statusStr);
    
function ShowBusyStatus(handles)
% Show the 'Busy' status
    set(handles.busy_Status,'String',' Busy');
    
function HideBusyStatus(handles)
% Hide the 'Busy' status
    set(handles.busy_Status,'String','');
    
function ClearStatus(handles)
% Clear the status bar
    set(handles.status,'String','');
