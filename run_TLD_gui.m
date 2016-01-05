function varargout = run_TLD_gui(varargin)
% RUN_TLD_GUI MATLAB code for run_TLD_gui.fig
%      RUN_TLD_GUI, by itself, creates a new RUN_TLD_GUI or raises the existing
%      singleton*.
%
%      H = RUN_TLD_GUI returns the handle to a new RUN_TLD_GUI or the handle to
%      the existing singleton*.
%
%      RUN_TLD_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RUN_TLD_GUI.M with the given input arguments.
%
%      RUN_TLD_GUI('Property','Value',...) creates a new RUN_TLD_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before run_TLD_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to run_TLD_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help run_TLD_gui

% Last Modified by GUIDE v2.5 18-Aug-2013 21:04:08
% close all; 
addpath(genpath('.')); %init_workspace; 
tic;

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @run_TLD_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @run_TLD_gui_OutputFcn, ...
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

% --- Update UI controls by plot options
function updatePlotOptToUI(handles, opt)
set(handles.cbpex,'Value',opt.plot.pex);
set(handles.cbnex,'Value',opt.plot.nex);
set(handles.cbtarget,'Value',opt.plot.target);
set(handles.cbconfidence,'Value',opt.plot.confidence);
set(handles.cbreplace,'Value',opt.plot.replace);
set(handles.cbdraw,'Value',opt.plot.draw);
set(handles.cbdt,'Value',opt.plot.dt);
set(handles.cbdrawoutput,'Value', opt.plot.drawoutput > 0);

% --- Update UI controls by source options
function updateSourceOptToUI(handles, opt)
set(handles.rbtnCamera,'Value',opt.source.camera);
set(handles.rbtnVideo,'Value',~opt.source.camera);
if opt.source.camera
    set(handles.editInputDir,'Enable','off');
    set(handles.btnChooseInput,'Enable','off');
else
    set(handles.editInputDir,'Enable','on');
    set(handles.btnChooseInput,'Enable','on');
end
set(handles.editInputDir,'String',opt.source.input);

% --- Update UI controls by window option
function updateTrackerOptToUI(handles, opt)
set(handles.editMinWin, 'String', num2str(opt.model.min_win));
set(handles.editPatchSize, 'String', num2str(opt.model.patchsize(1)));

% --- init TLD options
function initOptions(hObject)
opt.source          = struct('camera',0,'input','_input/','bb0',[]); 
% opt.source          = struct('camera',0,'input',inputdir,'bb0',[]); 
opt.output          = '_output/'; 
if ~exist(opt.output, 'dir'), mkdir(opt.output); end% output directory that will contain bounding boxes + confidence

min_win             = 20; % minimal size of the object's bounding box in the scanning grid, it may significantly influence speed of TLD, set it to minimal size of the object
% min_win             = 20; % minimal size of the object's bounding box in the scanning grid, it may significantly influence speed of TLD, set it to minimal size of the object
patchsize           = [15 15]; % size of normalized patch in the object detector, larger sizes increase discriminability, must be square
fliplr              = 0; % if set to one, the model automatically learns mirrored versions of the object
maxbbox             = 1; % fraction of evaluated bounding boxes in every frame, maxbox = 0 means detector is truned off, if you don't care about speed set it to 1
update_detector     = 1; % online learning on/off, of 0 detector is trained only in the first frame and then remains fixed
opt.plot            = struct('pex',1,'nex',0,'dt',1,'confidence',1,'target',1,'replace',0,'drawoutput',3,'draw',0,'pts',1,'help', 0,'patch_rescale',1,'save',0); 

% Do-not-change -----------------------------------------------------------

opt.model           = struct('min_win',min_win,'patchsize',patchsize,'fliplr',fliplr,'ncc_thesame',0.95,'valid',0.5,'num_trees',10,'num_features',13,'thr_fern',0.5,'thr_nn',0.65,'thr_nn_valid',0.7);
opt.p_par_init      = struct('num_closest',10,'num_warps',20,'noise',5,'angle',20,'shift',0.02,'scale',0.02); % synthesis of positive examples during initialization
opt.p_par_update    = struct('num_closest',10,'num_warps',10,'noise',5,'angle',10,'shift',0.02,'scale',0.02); % synthesis of positive examples during update
opt.n_par             = struct('overlap',0.2,'num_patches',100); % negative examples initialization/update
opt.tracker         = struct('occlusion',10);
opt.control         = struct('maxbbox',maxbbox,'update_detector',update_detector,'drop_img',1,'repeat',1);
hdata = guidata(hObject);
hdata.opt = opt;
guidata(hObject, hdata);


% --- Executes just before run_TLD_gui is made visible.
function run_TLD_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to run_TLD_gui (see VARARGIN)

% figure(1);

% Choose default command line output for run_TLD_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes run_TLD_gui wait for user response (see UIRESUME)
% uiwait(handles.figureTLDrunner);
initOptions(hObject);
hdata = guidata(hObject);
updatePlotOptToUI(handles, hdata.opt);
updateSourceOptToUI(handles, hdata.opt);
updateTrackerOptToUI(handles, hdata.opt);


% --- Outputs from this function are returned to the command line.
function varargout = run_TLD_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnRun.
function btnRun_Callback(hObject, eventdata, handles)
% hObject    handle to btnRun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hdata = guidata(hObject);
if hdata.opt.source.camera
    figure(1);
    [bb,conf] = tldExample(hdata.opt);
else
    [bb,conf] = tldExample(hdata.opt);
end
% close 'figureTLDrunner'

% --- Executes on button press in cbpex.
function cbpex_Callback(hObject, eventdata, handles)
% hObject    handle to cbpex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cbpex
hdata = guidata(hObject);
hdata.opt.plot.pex = get(hObject,'Value');
guidata(hObject, hdata);


% --- Executes on button press in cbnex.
function cbnex_Callback(hObject, eventdata, handles)
% hObject    handle to cbnex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cbnex
hdata = guidata(hObject);
hdata.opt.plot.nex = get(hObject,'Value');
guidata(hObject, hdata);


% --- Executes on button press in cbtarget.
function cbtarget_Callback(hObject, eventdata, handles)
% hObject    handle to cbtarget (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cbtarget
hdata = guidata(hObject);
hdata.opt.plot.target = get(hObject,'Value');
guidata(hObject, hdata);


% --- Executes on button press in rbtnCamera.
function rbtnCamera_Callback(hObject, eventdata, handles)
% hObject    handle to rbtnCamera (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbtnCamera



% --- Executes on button press in rbtnCamera.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to rbtnCamera (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbtnCamera



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


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


% --- Executes on button press in btnChooseInput.
function btnChooseInput_Callback(hObject, eventdata, handles)
% hObject    handle to btnChooseInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hdata = guidata(hObject);
opt = hdata.opt;
folder_name = uigetdir(opt.source.input, 'Select input directory');
if ischar(folder_name)
    opt.source.input = [folder_name '\\'];
    set(handles.editInputDir,'String',folder_name);
    hdata.opt = opt;
    guidata(hObject, hdata);
end


function editInputDir_Callback(hObject, eventdata, handles)
% hObject    handle to editInputDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editInputDir as text
%        str2double(get(hObject,'String')) returns contents of editInputDir as a double


% --- Executes during object creation, after setting all properties.
function editInputDir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editInputDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cbconfidence.
function cbconfidence_Callback(hObject, eventdata, handles)
% hObject    handle to cbconfidence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cbconfidence
hdata = guidata(hObject);
hdata.opt.plot.confidence = get(hObject,'Value');
guidata(hObject, hdata);

% --- Executes on button press in cbreplace.
function cbreplace_Callback(hObject, eventdata, handles)
% hObject    handle to cbreplace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cbreplace
hdata = guidata(hObject);
hdata.opt.plot.replace = get(hObject,'Value');
guidata(hObject, hdata);


% --- Executes on button press in cbdrawoutput.
function cbdrawoutput_Callback(hObject, eventdata, handles)
% hObject    handle to cbdrawoutput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cbdrawoutput
hdata = guidata(hObject);
if get(hObject,'Value') > 0
    hdata.opt.plot.drawoutput = 3;
else
    hdata.opt.plot.drawoutput = 0;
end

guidata(hObject, hdata);


% --- Executes on button press in cbdraw.
function cbdraw_Callback(hObject, eventdata, handles)
% hObject    handle to cbdraw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cbdraw
hdata = guidata(hObject);
hdata.opt.plot.draw = get(hObject,'Value');
guidata(hObject, hdata);


% --- Executes on button press in cbdt.
function cbdt_Callback(hObject, eventdata, handles)
% hObject    handle to cbdt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cbdt
hdata = guidata(hObject);
hdata.opt.plot.dt = get(hObject,'Value');
guidata(hObject, hdata);



function editMinWin_Callback(hObject, eventdata, handles)
% hObject    handle to editMinWin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editMinWin as text
%        str2double(get(hObject,'String')) returns contents of editMinWin as a double
hdata = guidata(hObject);
mw = round(str2double(get(hObject,'String')));
if mw >= 10
    hdata.opt.model.min_win = mw;
    guidata(hObject, hdata);
else
    warndlg('Mindow window size must be greater than 10.');
end


% --- Executes during object creation, after setting all properties.
function editMinWin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editMinWin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editPatchSize_Callback(hObject, eventdata, handles)
% hObject    handle to editPatchSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editPatchSize as text
%        str2double(get(hObject,'String')) returns contents of editPatchSize as a double
hdata = guidata(hObject);
ps = round(str2double(get(hObject,'String')));
if ps >= 10
    hdata.opt.model.patchsize = [ps, ps];
    guidata(hObject, hdata);
else
    warndlg('Patch size must be greater than 10.');
end


% --- Executes during object creation, after setting all properties.
function editPatchSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editPatchSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over btnChooseInput.
function btnChooseInput_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to btnChooseInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected object is changed in uipanelSource.
function uipanelSource_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanelSource 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
hdata = guidata(hObject);
opt = hdata.opt;
newtag = get(eventdata.NewValue,'Tag'); % Get Tag of selected object.
switch newtag
    case 'rbtnCamera'
        % Code for when rbtnCamera is selected.
        opt.source.camera = true;
    case 'rbtnVideo'
        % Code for when rbtnVideo is selected.
        opt.source.camera = false;
    % Continue with more cases as necessary.
    otherwise
        % Code for when there is no match.
end
updateSourceOptToUI(handles, opt);
hdata.opt = opt;
guidata(hObject, hdata);
