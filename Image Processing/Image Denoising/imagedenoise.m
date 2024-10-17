function varargout = imagedenoise(varargin)
% IMAGEDENOISE MATLAB code for imagedenoise.fig
%      IMAGEDENOISE, by itself, creates a new IMAGEDENOISE or raises the existing
%      singleton*.
%
%      H = IMAGEDENOISE returns the handle to a new IMAGEDENOISE or the handle to
%      the existing singleton*.
%
%      IMAGEDENOISE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGEDENOISE.M with the given input arguments.
%
%      IMAGEDENOISE('Property','Value',...) creates a new IMAGEDENOISE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before imagedenoise_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to imagedenoise_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help imagedenoise

% Last Modified by GUIDE v2.5 18-Sep-2020 10:55:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @imagedenoise_OpeningFcn, ...
                   'gui_OutputFcn',  @imagedenoise_OutputFcn, ...
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


% --- Executes just before imagedenoise is made visible.
function imagedenoise_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to imagedenoise (see VARARGIN)

% Choose default command line output for imagedenoise
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes imagedenoise wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = imagedenoise_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in selectimage.
function selectimage_Callback(hObject, eventdata, handles)
% hObject    handle to selectimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 [filename, pathname] = uigetfile('*.*', 'Pick a MATLAB code file');
    if isequal(filename,0) || isequal(pathname,0)
       warndlg('User pressed cancel')
    else
       a=imread(strcat(pathname,filename));
       axes(handles.axes1);
       imshow(a);
       handles.a=a;
    end
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in addnoise.
function addnoise_Callback(hObject, eventdata, handles)
% hObject    handle to addnoise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=handles.a

R=a(:,:,1);
G=a(:,:,2);
B=a(:,:,3);
R = imnoise(R,'salt & pepper', 0.12);
G = imnoise(G,'salt & pepper', 0.12);
B = imnoise(B,'salt & pepper', 0.12);
NoisyImage(:,:,1)=R;
NoisyImage(:,:,2)=G;
NoisyImage(:,:,3)=B;
imwrite(NoisyImage,'noisy.png');
axes(handles.axes2);imshow(NoisyImage);
handles.NoisyImage=NoisyImage;
% Update handles structure
guidata(hObject, handles);



% --- Executes on button press in ApplyFilter.
function ApplyFilter_Callback(hObject, eventdata, handles)
% hObject    handle to ApplyFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
NoisyImage =handles.NoisyImage;

R=NoisyImage(:,:,1);
G=NoisyImage(:,:,2);
B=NoisyImage(:,:,3);
R=medfilt2(R,[5 5]);
G=medfilt2(G,[5 5]);
B=medfilt2(B,[5 5]);
FilteredImage(:,:,1)=R;
FilteredImage(:,:,2)=G;
FilteredImage(:,:,3)=B;
axes(handles.axes3);
imshow(FilteredImage);
