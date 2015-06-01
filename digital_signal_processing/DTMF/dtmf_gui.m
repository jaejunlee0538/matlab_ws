function varargout = dtmf_gui(varargin)
% DTMF_GUI MATLAB code for dtmf_gui.fig
%      DTMF_GUI, by itself, creates a new DTMF_GUI or raises the existing
%      singleton*.
%
%      H = DTMF_GUI returns the handle to a new DTMF_GUI or the handle to
%      the existing singleton*.
%
%      DTMF_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DTMF_GUI.M with the given input arguments.
%
%      DTMF_GUI('Property','Value',...) creates a new DTMF_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dtmf_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dtmf_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dtmf_gui

% Last Modified by GUIDE v2.5 01-Jun-2015 23:18:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dtmf_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @dtmf_gui_OutputFcn, ...
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

function text_dial = textdial_get_text()
text_dial = get(findobj('Tag','st_input_dial'),'String');

function textdial_insert(handles, character)
valid_key_input =  ['1','2','3','A','4','5','6','B','7','8','9','C','*','0','#','D'];
character = upper(character);
if ~isempty(find(valid_key_input==character))
    h_input_dial = findobj('Tag','st_input_dial');
    prev = get(h_input_dial,'String');
    set(h_input_dial, 'String', strcat(prev, character));
    generate_dtmf(handles);
end

function textdial_clear(handles)
set(findobj('Tag','st_input_dial'), 'String', '');
generate_dtmf(handles);

% --- Executes on button press in pb_generate.
function generate_dtmf(handles)
global samples
global sampling_rate
global digits_per_second
input_dials = textdial_get_text();
samples = [];
for i = 1:1:length(input_dials)
    samples = [samples dtmf_samples(input_dials(i),sampling_rate,digits_per_second)];
end

dt = 1/sampling_rate;
axes(handles.plot_dtmf_samples);
if isempty(samples)
    cla
else
    plot(0:dt:dt*(length(samples)-1),samples)
end

% --- Executes just before dtmf_gui is made visible.
function dtmf_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dtmf_gui (see VARARGIN)

% Choose default command line output for dtmf_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes dtmf_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global sampling_rate
global digits_per_second
sampling_rate = 8000;
digits_per_second = 5;
generate_dtmf(handles);


% --- Outputs from this function are returned to the command line.
function varargout = dtmf_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on key press with focus on figure1 and none of its controls.
function figure1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
if length(eventdata.Character) == 1
    textdial_insert(handles, eventdata.Character);
end

% --- Executes on button press in pb_clear.
function pb_clear_Callback(hObject, eventdata, handles)
% hObject    handle to pb_clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global samples
textdial_clear(handles);
samples = [];

% --- Executes on button press in pb_play.
function pb_play_Callback(hObject, eventdata, handles)
% hObject    handle to pb_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global samples
global sampling_rate
if ~isempty(samples)
    soundsc(samples, sampling_rate);
end

% --- Executes on button press in pb_one.
function pb_one_Callback(hObject, eventdata, handles)
% hObject    handle to pb_one (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
textdial_insert(handles,'1')

% --- Executes on button press in pb_two.
function pb_two_Callback(hObject, eventdata, handles)
% hObject    handle to pb_two (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
textdial_insert(handles,'2')

% --- Executes on button press in pb_five.
function pb_five_Callback(hObject, eventdata, handles)
% hObject    handle to pb_five (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
textdial_insert(handles,'5')

% --- Executes on button press in pb_asterisk.
function pb_asterisk_Callback(hObject, eventdata, handles)
% hObject    handle to pb_asterisk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
textdial_insert(handles,'*')

% --- Executes on button press in pb_seven.
function pb_seven_Callback(hObject, eventdata, handles)
% hObject    handle to pb_seven (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
textdial_insert(handles,'7')

% --- Executes on button press in pb_four.
function pb_four_Callback(hObject, eventdata, handles)
% hObject    handle to pb_four (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
textdial_insert(handles,'4')

% --- Executes on button press in pb_nine.
function pb_nine_Callback(hObject, eventdata, handles)
% hObject    handle to pb_nine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
textdial_insert(handles,'9')

% --- Executes on button press in pb_sharp.
function pb_sharp_Callback(hObject, eventdata, handles)
% hObject    handle to pb_sharp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
textdial_insert(handles,'#')

% --- Executes on button press in pb_zero.
function pb_zero_Callback(hObject, eventdata, handles)
% hObject    handle to pb_zero (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
textdial_insert(handles,'0')

% --- Executes on button press in pb_eight.
function pb_eight_Callback(hObject, eventdata, handles)
% hObject    handle to pb_eight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
textdial_insert(handles,'8')

% --- Executes on button press in pb_three.
function pb_three_Callback(hObject, eventdata, handles)
% hObject    handle to pb_three (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
textdial_insert(handles,'3')

% --- Executes on button press in pb_six.
function pb_six_Callback(hObject, eventdata, handles)
% hObject    handle to pb_six (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
textdial_insert(handles,'6')

% --- Executes on button press in pb_A.
function pb_A_Callback(hObject, eventdata, handles)
% hObject    handle to pb_A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
textdial_insert(handles,'A')

% --- Executes on button press in pb_D.
function pb_D_Callback(hObject, eventdata, handles)
% hObject    handle to pb_D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
textdial_insert(handles,'D')

% --- Executes on button press in pb_C.
function pb_C_Callback(hObject, eventdata, handles)
% hObject    handle to pb_C (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
textdial_insert(handles,'C')

% --- Executes on button press in pb_B.
function pb_B_Callback(hObject, eventdata, handles)
% hObject    handle to pb_B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
textdial_insert(handles,'B')



function edit_digits_per_second_Callback(hObject, eventdata, handles)
% hObject    handle to edit_digits_per_second (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_digits_per_second as text
%        str2double(get(hObject,'String')) returns contents of edit_digits_per_second as a double
global digits_per_second
dps = get(hObject,'String');
dps = str2double(get(hObject, 'String'));
if ~isnan(dps)
    digits_per_second = dps;
else
    digits_per_second = 5;
end
generate_dtmf(handles)

% --- Executes during object creation, after setting all properties.
function edit_digits_per_second_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_digits_per_second (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_sampling_rate_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sampling_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sampling_rate as text
%        str2double(get(hObject,'String')) returns contents of edit_sampling_rate as a double
global sampling_rate
rate = get(hObject,'String');
rate = str2double(get(hObject, 'String'));
if ~isnan(rate)
    sampling_rate = rate;
else
    sampling_rate = 8000;
end
generate_dtmf(handles)


% --- Executes during object creation, after setting all properties.
function edit_sampling_rate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sampling_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function st_input_dial_CreateFcn(hObject, eventdata, handles)
% hObject    handle to st_input_dial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% --- Executes during object creation, after setting all properties.
function plot_dtmf_samples_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plot_dtmf_samples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate plot_dtmf_samples


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
