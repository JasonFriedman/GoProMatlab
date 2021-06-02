function varargout = testGoPro(varargin)
% TESTGOPRO Test the GoPro connection via wifi
%
% testGoPro - run the GUI (graphical user interface)
% testGoPro(wifiName, wifiPassword) - optionally provie the wifi name and
% password to connect to

% Edit the above text to modify the response to help testGoPro

% Last Modified by GUIDE v2.5 15-Dec-2020 16:02:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @testGoPro_OpeningFcn, ...
                   'gui_OutputFcn',  @testGoPro_OutputFcn, ...
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


% --- Executes just before testGoPro is made visible.
function testGoPro_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to testGoPro (see VARARGIN)

% Choose default command line output for testGoPro
handles.output = hObject;

if nargin>=4
    set(handles.wifiName,'String',varargin{1});
end
if nargin>=5
    set(handles.wifiPassword,'String',varargin{2});
end

handles.wifiCommands = getCommands;
handles.wifiCommands{numel(handles.wifiCommands)+1} = 'SetDateTime';
handles.wifiCommands{numel(handles.wifiCommands)+1} = 'GetLastFile';
set(handles.wifiCommandsList,'String',handles.wifiCommands);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes testGoPro wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = testGoPro_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in wifiCommandsList.
function wifiCommandsList_Callback(hObject, eventdata, handles)

% do nothing

% --- Executes during object creation, after setting all properties.
function wifiCommandsList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wifiCommandsList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in sendCommandButton.
function sendCommandButton_Callback(hObject, eventdata, handles)
% Send the command
command = handles.wifiCommands{get(handles.wifiCommandsList,'Value')};
set(handles.errorMessageText,'String','');

if strcmp(command,'SetDateTime')
    errorMessage = GoProSetDateTime;
elseif strcmp(command,'GetLastFile')
    [filename,errorMessage] = readmedia(1);
    if ~isempty(filename)
        set(handles.errorMessageText,'String',filename);
    end
else
    errorMessage = GoProWifi(command);
end

if ~isempty(errorMessage)
    set(handles.errorMessageText,'String',errorMessage.message);
end



function wifiName_Callback(hObject, eventdata, handles)
% hObject    handle to wifiName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of wifiName as text
%        str2double(get(hObject,'String')) returns contents of wifiName as a double


% --- Executes during object creation, after setting all properties.
function wifiName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wifiName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function wifiPassword_Callback(hObject, eventdata, handles)
% hObject    handle to wifiPassword (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of wifiPassword as text
%        str2double(get(hObject,'String')) returns contents of wifiPassword as a double


% --- Executes during object creation, after setting all properties.
function wifiPassword_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wifiPassword (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in connectToWifi.
function connectToWifi_Callback(hObject, eventdata, handles)
wifiname = get(handles.wifiName,'String');
password = get(handles.wifiPassword,'String');
success = checkConnectedToGoProWifi(wifiname,password);
if success
    set(handles.wifiCommandsList,'Enable','on');
    set(handles.sendCommandButton,'Enable','on');
end
