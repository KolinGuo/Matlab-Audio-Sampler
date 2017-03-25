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

% Last Modified by GUIDE v2.5 14-Mar-2017 08:30:40

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

% Save the pad number of current selected sample
handles.curPad = 0;

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
        SaveFromPad(hObject,handles,1);
    % If in Delete Mode, delete samples from pad 1
    elseif(get(handles.deleteButton,'Value') == get(handles.deleteButton,'Max'))
        DelFromPad(hObject,handles,1);
    % Normal Play sound
    else
        ShowButton(hObject, handles, 1);
        BusyStatus(handles);    % show the 'Busy' status
        pause(0.0000001);       % pause for a short time to allow status changes
        PlaySound(handles.samples(1));
        PlayStatus(handles,1);  % show the 'Playing' status
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
        SaveFromPad(hObject,handles,2);
    % If in Delete Mode, delete samples from pad 2
    elseif(get(handles.deleteButton,'Value') == get(handles.deleteButton,'Max'))
        DelFromPad(hObject,handles,2);
    % Normal Play sound
    else
        ShowButton(hObject, handles, 2);
        BusyStatus(handles);    % show the 'Busy' status
        pause(0.0000001);       % pause for a short time to allow status changes
        PlaySound(handles.samples(2));
        PlayStatus(handles,2);  % show the 'Playing' status
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
        SaveFromPad(hObject,handles,3);
    % If in Delete Mode, delete samples from pad 3
    elseif(get(handles.deleteButton,'Value') == get(handles.deleteButton,'Max'))
        DelFromPad(hObject,handles,3);
    % Normal Play sound
    else
        ShowButton(hObject, handles, 3);
        BusyStatus(handles);    % show the 'Busy' status
        pause(0.0000001);       % pause for a short time to allow status changes
        PlaySound(handles.samples(3));
        PlayStatus(handles,3);  % show the 'Playing' status
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
        SaveFromPad(hObject,handles,4);
    % If in Delete Mode, delete samples from pad 4
    elseif(get(handles.deleteButton,'Value') == get(handles.deleteButton,'Max'))
        DelFromPad(hObject,handles,4);
    % Normal Play sound
    else
        ShowButton(hObject, handles, 4);
        BusyStatus(handles);    % show the 'Busy' status
        pause(0.0000001);       % pause for a short time to allow status changes
        PlaySound(handles.samples(4));
        PlayStatus(handles,4);  % show the 'Playing' status
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
        SaveFromPad(hObject,handles,5);
    % If in Delete Mode, delete samples from pad 5
    elseif(get(handles.deleteButton,'Value') == get(handles.deleteButton,'Max'))
        DelFromPad(hObject,handles,5);
    % Normal Play sound
    else
        ShowButton(hObject, handles, 5);
        BusyStatus(handles);    % show the 'Busy' status
        pause(0.0000001);       % pause for a short time to allow status changes
        PlaySound(handles.samples(5));
        PlayStatus(handles,5);  % show the 'Playing' status
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
        SaveFromPad(hObject,handles,6);
    % If in Delete Mode, delete samples from pad 6
    elseif(get(handles.deleteButton,'Value') == get(handles.deleteButton,'Max'))
        DelFromPad(hObject,handles,6);
    % Normal Play sound
    else
        ShowButton(hObject, handles, 6);
        BusyStatus(handles);    % show the 'Busy' status
        pause(0.0000001);       % pause for a short time to allow status changes
        PlaySound(handles.samples(6));
        PlayStatus(handles,6);  % show the 'Playing' status
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
        SaveFromPad(hObject,handles,7);
    % If in Delete Mode, delete samples from pad 7
    elseif(get(handles.deleteButton,'Value') == get(handles.deleteButton,'Max'))
        DelFromPad(hObject,handles,7);
    % Normal Play sound
    else
        ShowButton(hObject, handles, 7);
        BusyStatus(handles);    % show the 'Busy' status
        pause(0.0000001);       % pause for a short time to allow status changes
        PlaySound(handles.samples(7));
        PlayStatus(handles,7);  % show the 'Playing' status
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
        SaveFromPad(hObject,handles,8);
    % If in Delete Mode, delete samples from pad 8
    elseif(get(handles.deleteButton,'Value') == get(handles.deleteButton,'Max'))
        DelFromPad(hObject,handles,8);
    % Normal Play sound
    else
        ShowButton(hObject, handles, 8);
        BusyStatus(handles);    % show the 'Busy' status
        pause(0.0000001);       % pause for a short time to allow status changes
        PlaySound(handles.samples(8));
        PlayStatus(handles,8);  % show the 'Playing' status
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
        SaveFromPad(hObject,handles,9);
    % If in Delete Mode, delete samples from pad 9
    elseif(get(handles.deleteButton,'Value') == get(handles.deleteButton,'Max'))
        DelFromPad(hObject,handles,9);
    % Normal Play sound
    else
        ShowButton(hObject, handles, 9);
        BusyStatus(handles);    % show the 'Busy' status
        pause(0.0000001);       % pause for a short time to allow status changes
        PlaySound(handles.samples(9));
        PlayStatus(handles,9);  % show the 'Playing' status
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
        SaveFromPad(hObject,handles,10);
    % If in Delete Mode, delete samples from pad 10
    elseif(get(handles.deleteButton,'Value') == get(handles.deleteButton,'Max'))
        DelFromPad(hObject,handles,10);
    % Normal Play sound
    else
        ShowButton(hObject, handles, 10);
        BusyStatus(handles);    % show the 'Busy' status
        pause(0.0000001);       % pause for a short time to allow status changes
        PlaySound(handles.samples(10));
        PlayStatus(handles,10);  % show the 'Playing' status
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
        SaveFromPad(hObject,handles,11);
    % If in Delete Mode, delete samples from pad 11
    elseif(get(handles.deleteButton,'Value') == get(handles.deleteButton,'Max'))
        DelFromPad(hObject,handles,11);
    % Normal Play sound
    else
        ShowButton(hObject, handles, 11);
        BusyStatus(handles);    % show the 'Busy' status
        pause(0.0000001);       % pause for a short time to allow status changes
        PlaySound(handles.samples(11));
        PlayStatus(handles,11);  % show the 'Playing' status
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
        SaveFromPad(hObject,handles,12);
    % If in Delete Mode, delete samples from pad 12
    elseif(get(handles.deleteButton,'Value') == get(handles.deleteButton,'Max'))
        DelFromPad(hObject,handles,12);
    % Normal Play sound
    else
        ShowButton(hObject, handles, 12);
        BusyStatus(handles);    % show the 'Busy' status
        pause(0.0000001);       % pause for a short time to allow status changes
        PlaySound(handles.samples(12));
        PlayStatus(handles,12);  % show the 'Playing' status
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
        SaveFromPad(hObject,handles,13);
    % If in Delete Mode, delete samples from pad 13
    elseif(get(handles.deleteButton,'Value') == get(handles.deleteButton,'Max'))
        DelFromPad(hObject,handles,13);
    % Normal Play sound
    else
        ShowButton(hObject, handles, 13);
        BusyStatus(handles);    % show the 'Busy' status
        pause(0.0000001);       % pause for a short time to allow status changes
        PlaySound(handles.samples(13));
        PlayStatus(handles,13);  % show the 'Playing' status
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
        SaveFromPad(hObject,handles,14);
    % If in Delete Mode, delete samples from pad 14
    elseif(get(handles.deleteButton,'Value') == get(handles.deleteButton,'Max'))
        DelFromPad(hObject,handles,14);
    % Normal Play sound
    else
        ShowButton(hObject, handles, 14);
        BusyStatus(handles);    % show the 'Busy' status
        pause(0.0000001);       % pause for a short time to allow status changes
        PlaySound(handles.samples(14));
        PlayStatus(handles,14);  % show the 'Playing' status
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
        SaveFromPad(hObject,handles,15);
    % If in Delete Mode, delete samples from pad 15
    elseif(get(handles.deleteButton,'Value') == get(handles.deleteButton,'Max'))
        DelFromPad(hObject,handles,15);
    % Normal Play sound
    else
        ShowButton(hObject, handles, 15);
        BusyStatus(handles);    % show the 'Busy' status
        pause(0.0000001);       % pause for a short time to allow status changes
        PlaySound(handles.samples(15));
        PlayStatus(handles,15);  % show the 'Playing' status
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
        SaveFromPad(hObject,handles,16);
    % If in Delete Mode, delete samples from pad 16
    elseif(get(handles.deleteButton,'Value') == get(handles.deleteButton,'Max'))
        DelFromPad(hObject,handles,16);
    % Normal Play sound
    else
        ShowButton(hObject, handles, 16);
        BusyStatus(handles);    % show the 'Busy' status
        pause(0.0000001);       % pause for a short time to allow status changes
        PlaySound(handles.samples(16));
        PlayStatus(handles,16);  % show the 'Playing' status
    end
end

function LoadToPad(hObject,handles,num)
% Load an audio sample into the corresponding pad
%   hObject: handle to pad
%   handles: structure with handles and user data
%   num: the pad which the sample is loading into
filePath = GetLoadPath();   % get file path
BusyStatus(handles);        % show the 'Busy' status
pause(.0000001);            % pause for a short time to allow status changes
handles.samples(num) = Load(filePath);  % load the file to handles
SetPadColor(handles);       % refresh the color of pads
if(isempty(handles.samples(num).points))    % if user canceled to load
    set(handles.status,'String','Load Mode: Cancel to load');
else
    statusStr = sprintf('Load Mode: Successfully load into pad %d',num);
    set(handles.status,'String',statusStr);
    ShowButton(hObject, handles, num);
end
guidata(hObject, handles);  % update handles

function SaveFromPad(hObject,handles,num)
% Save the sample to file from the corresponding pad
%   hObject: handle to pad
%   handles: structure with handles and user data
%   num: the pad which the sample is saving from
filePath = GetSavePath(num);    % get file path
if isnumeric(filePath)     % if user canceled to save
    set(handles.status,'String','Save Mode: Cancel to save');
else
    BusyStatus(handles);        % show the 'Busy' status
    pause(.0000001);            % pause for a short time to allow status changes
    Save(filePath,handles.samples(num));  % save the file
    statusStr = sprintf('Save Mode: Successfully save from pad %d',num);
    set(handles.status,'String',statusStr);
    ShowButton(hObject, handles, num);
end
guidata(hObject, handles);  % update handles

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
        statusStr = sprintf('Copy Mode: Copy pad %d to ...',num);   % show status
        set(handles.status,'String',statusStr);
    end
else    % if it was the second click, copy the sample and reset color
    copyPadNum = get(handles.copyButton,'UserData');
    BusyStatus(handles);        % show the 'Busy' status
    pause(.0000001);            % pause for a short time to allow status changes
    handles.samples(num) = handles.samples(copyPadNum);   % copy the sample
    SetPadColor(handles);   % refresh color
    ShowButton(hObject, handles, num);  % select the pad
    statusStr = sprintf('Copy Mode: Successfully copy from pad %d to pad %d',copyPadNum,num);   % show status
    if(num == copyPadNum)   % Add A Joke
        statusStr = [statusStr '...Wait...What are you thinking???'];
    end
    set(handles.status,'String',statusStr);
    set(handles.copyButton,'UserData',[]);      % reset UserData
end
guidata(hObject, handles);  % update handles

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
        statusStr = sprintf('Cut Mode: Cut pad %d to ...',num);   % show status
        set(handles.status,'String',statusStr);
    end
else    % if it was the second click, copy the sample, delete the original and reset color
    cutPadNum = get(handles.cutButton,'UserData');
    BusyStatus(handles);        % show the 'Busy' status
    pause(.0000001);            % pause for a short time to allow status changes
    handles.samples(num) = handles.samples(cutPadNum);   % copy the sample
    if(num ~= cutPadNum)    % if cutting a pad to itself will not delete the sample
        handles.samples(cutPadNum).points = [];  % delete the original sample
        handles.samples(cutPadNum).sampleRate = 0;
    end
    HideButton(hObject, handles, cutPadNum);  % hide the button of original pad
    ShowButton(hObject, handles, num);  % select the current pad
    SetPadColor(handles);   % refresh color
    statusStr = sprintf('Cut Mode: Successfully cut from pad %d to pad %d',cutPadNum,num);   % show status
    if(num == cutPadNum)   % Add A Joke
        statusStr = [statusStr '...Wait...What are you thinking???'];
    end
    set(handles.status,'String',statusStr);
    set(handles.cutButton,'UserData',[]);      % reset UserData
end
guidata(hObject, handles);  % update handles

function DelFromPad(hObject,handles,num)
% Delete the sample from the corresponding pad
%   hObject: handle to pad
%   handles: structure with handles and user data
%   num: the pad which the sample needs to be deleted
BusyStatus(handles);        % show the 'Busy' status
pause(.0000001);            % pause for a short time to allow status changes
handles.samples(num).points = [];  % delete the sample
handles.samples(num).sampleRate = 0;
SetPadColor(handles);       % refresh the color of pads

statusStr = sprintf('Delete Mode: Successfully delete the sample in pad %d',num);
set(handles.status,'String',statusStr);

HideButton(hObject, handles, num);  % Hide the button
clear sound;
guidata(hObject, handles);  % update handles

function [filePath] = GetLoadPath()
[filename, pathname] = uigetfile(...
    {'*.aiff;*.aif;*.aifc;*.au;*.flac;*.m4a;*.mp3;*.mp4;*.oga;*.ogg;*.snd;*.wav',....
    'Audio (*.aiff, *.aif, *.aifc, *.au, *.flac, *.m4a, *.mp3, *.mp4, *.oga, *.ogg, *.snd, *.wav)'},...
    'Select an audio file');
filePath = [pathname, filename];

function [filePath] = GetSavePath(num)
defaultFilename = ['pad' num2str(num)];
[filename, pathname] = uiputfile(...
    {'*.wav','Waveform Audio File (*.wav)';...
    '*.m4a;*.mp4','MPEG-4 (*.m4a, *.mp4)';...
    '*.flac','Free Lossless Audio Codec (*.flac)';...
    '*.ogg;*.oga','Ogg Vorbis (*.ogg, *.oga)'},...
    'Save as an audio file', defaultFilename);
filePath = [pathname, filename];

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

function ShowButton(hObject, handles, num)
% Show the button of the correponding pad
str = ['button',num2str(num)];
set(handles.(str),'Visible','on','Value',get(handles.(str),'Max'));
handles.curPad = num;
guidata(hObject, handles);
    
function HideButton(hObject, handles, num)
% Hide the button of the correponding pad
str = ['button',num2str(num)];
set(handles.(str),'Visible','off');
% Select another available pad
for i = 1:16
    str = ['button',num2str(i)];    % the field name of the object
    if(strcmp(get(handles.(str),'Visible'), 'on')) % if it's available
        set(handles.(str),'Value',get(handles.(str),'Max'));    % select it
        handles.curPad = i;
        break;
    end
end
guidata(hObject, handles);
    
function PlayStatus(handles,num)
% Show the 'Playing' status
    statusStr = sprintf('Playing from pad %d',num);
    set(handles.status,'String',statusStr);

function EmptyPadStatus(handles,num)
% Show the 'Empty Pad' status
    statusStr = sprintf('Empty pad %d, please first load/copy a sample or use piano keyboard',num);
    set(handles.status,'String',statusStr);
    
function BusyStatus(handles)
% Show the 'Busy' status
    set(handles.status,'String','Busy');
    
function ClearStatus(handles)
% Clear the status bar
    set(handles.status,'String','');

