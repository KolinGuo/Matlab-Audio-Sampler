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

% Last Modified by GUIDE v2.5 12-Mar-2017 20:46:13

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
end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.main);


% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in sample1.
function sample1_Callback(hObject, eventdata, handles)
% hObject    handle to sample1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% If in Load Mode, load samples into pad 1
if(get(handles.loadButton,'Value') == get(handles.loadButton,'Max'))
    LoadToPad(hObject,handles,1);
else
    PlaySound(handles.samples(1));
end


% --- Executes on button press in sample2.
function sample2_Callback(hObject, eventdata, handles)
% hObject    handle to sample2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% If in Load Mode, load samples into pad 2
if(get(handles.loadButton,'Value') == get(handles.loadButton,'Max'))
    LoadToPad(hObject,handles,2);
else
    PlaySound(handles.samples(2));
end


% --- Executes on button press in sample3.
function sample3_Callback(hObject, eventdata, handles)
% hObject    handle to sample3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% If in Load Mode, load samples into pad 3
if(get(handles.loadButton,'Value') == get(handles.loadButton,'Max'))
    LoadToPad(hObject,handles,3);
else
    PlaySound(handles.samples(3));
end


% --- Executes on button press in sample4.
function sample4_Callback(hObject, eventdata, handles)
% hObject    handle to sample4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% If in Load Mode, load samples into pad 4
if(get(handles.loadButton,'Value') == get(handles.loadButton,'Max'))
    LoadToPad(hObject,handles,4);
else
    PlaySound(handles.samples(4));
end


% --- Executes on button press in sample5.
function sample5_Callback(hObject, eventdata, handles)
% hObject    handle to sample5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% If in Load Mode, load samples into pad 5
if(get(handles.loadButton,'Value') == get(handles.loadButton,'Max'))
    LoadToPad(hObject,handles,5);
else
    PlaySound(handles.samples(5));
end


% --- Executes on button press in sample6.
function sample6_Callback(hObject, eventdata, handles)
% hObject    handle to sample6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% If in Load Mode, load samples into pad 6
if(get(handles.loadButton,'Value') == get(handles.loadButton,'Max'))
    LoadToPad(hObject,handles,6);
else
    PlaySound(handles.samples(6));
end


% --- Executes on button press in sample7.
function sample7_Callback(hObject, eventdata, handles)
% hObject    handle to sample7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% If in Load Mode, load samples into pad 7
if(get(handles.loadButton,'Value') == get(handles.loadButton,'Max'))
    LoadToPad(hObject,handles,7);
else
    PlaySound(handles.samples(7));
end


% --- Executes on button press in sample8.
function sample8_Callback(hObject, eventdata, handles)
% hObject    handle to sample8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% If in Load Mode, load samples into pad 8
if(get(handles.loadButton,'Value') == get(handles.loadButton,'Max'))
    LoadToPad(hObject,handles,8);
else
    PlaySound(handles.samples(8));
end


% --- Executes on button press in sample9.
function sample9_Callback(hObject, eventdata, handles)
% hObject    handle to sample9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% If in Load Mode, load samples into pad 9
if(get(handles.loadButton,'Value') == get(handles.loadButton,'Max'))
    LoadToPad(hObject,handles,9);
else
    PlaySound(handles.samples(9));
end


% --- Executes on button press in sample10.
function sample10_Callback(hObject, eventdata, handles)
% hObject    handle to sample10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% If in Load Mode, load samples into pad 10
if(get(handles.loadButton,'Value') == get(handles.loadButton,'Max'))
    LoadToPad(hObject,handles,10);
else
    PlaySound(handles.samples(10));
end


% --- Executes on button press in sample11.
function sample11_Callback(hObject, eventdata, handles)
% hObject    handle to sample11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% If in Load Mode, load samples into pad 11
if(get(handles.loadButton,'Value') == get(handles.loadButton,'Max'))
    LoadToPad(hObject,handles,11);
else
    PlaySound(handles.samples(11));
end


% --- Executes on button press in sample12.
function sample12_Callback(hObject, eventdata, handles)
% hObject    handle to sample12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% If in Load Mode, load samples into pad 12
if(get(handles.loadButton,'Value') == get(handles.loadButton,'Max'))
    LoadToPad(hObject,handles,12);
else
    PlaySound(handles.samples(12));
end


% --- Executes on button press in sample13.
function sample13_Callback(hObject, eventdata, handles)
% hObject    handle to sample13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% If in Load Mode, load samples into pad 13
if(get(handles.loadButton,'Value') == get(handles.loadButton,'Max'))
    LoadToPad(hObject,handles,13);
else
    PlaySound(handles.samples(13));
end


% --- Executes on button press in sample14.
function sample14_Callback(hObject, eventdata, handles)
% hObject    handle to sample14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% If in Load Mode, load samples into pad 14
if(get(handles.loadButton,'Value') == get(handles.loadButton,'Max'))
    LoadToPad(hObject,handles,14);
else
    PlaySound(handles.samples(14));
end


% --- Executes on button press in sample15.
function sample15_Callback(hObject, eventdata, handles)
% hObject    handle to sample15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% If in Load Mode, load samples into pad 15
if(get(handles.loadButton,'Value') == get(handles.loadButton,'Max'))
    LoadToPad(hObject,handles,15);
else
    PlaySound(handles.samples(15));
end


% --- Executes on button press in sample16.
function sample16_Callback(hObject, eventdata, handles)
% hObject    handle to sample16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% If in Load Mode, load samples into pad 16
if(get(handles.loadButton,'Value') == get(handles.loadButton,'Max'))
    LoadToPad(hObject,handles,16);
else
    PlaySound(handles.samples(16));
end


function LoadToPad(hObject,handles,num)
% Load an audio sample into the corresponding pad
%   handles: structure with handles and user data
%   num: the pad which the sample is loading into
handles.samples(num) = Load();
SetPadColor(handles);
if(isempty(handles.samples(num).points))
    set(handles.status,'String','Load Mode: Cancel to load');
else
    statusStr = sprintf('Load Mode: Successfully load into pad %d',num);
    set(handles.status,'String',statusStr);
    str = ['button',num2str(num)];
    set(handles.(str),'Visible','on','Value',get(handles.(str),'Max'));
    guidata(hObject, handles);
end


% --- Executes on button press in button7.
function button7_Callback(hObject, eventdata, handles)
% hObject    handle to button7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of button7


% --- Executes on button press in button9.
function button9_Callback(hObject, eventdata, handles)
% hObject    handle to button9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of button9


% --- Executes on button press in button14.
function button14_Callback(hObject, eventdata, handles)
% hObject    handle to button14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of button14


% --- Executes on button press in button15.
function button15_Callback(hObject, eventdata, handles)
% hObject    handle to button15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of button15


% --- Executes on button press in button16.
function button16_Callback(hObject, eventdata, handles)
% hObject    handle to button16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of button16


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
    SetPadColor(handles);
elseif button_state == get(hObject,'Min')
    set(handles.saveButton,'Visible','on');
    ResetPadColor(handles);
    ClearStatus(handles);
end

% --- Executes on button press in saveButton.
function saveButton_Callback(hObject, eventdata, handles)
% hObject    handle to saveButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of saveButton


function SetPadColor(handles)
% Set the color of empty pad to red and others to green
for i = 1:16
    str = ['sample',num2str(i)];    % the field name of the object
    if(isempty(handles.samples(i).points))
        set(handles.(str),'BackgroundColor',[0.8 0.255 0.29]);
    else
        set(handles.(str),'BackgroundColor',[0.542 0.907 0.289]);
    end
end

function ResetPadColor(handles)
% Reset the color of pads to default
for i = 1:16
    str = ['sample',num2str(i)];    % the field name of the object
    set(handles.(str),'BackgroundColor',[0.94 0.94 0.94]);
end

function ClearStatus(handles)
% Clear the status bar
    set(handles.status,'String','');
