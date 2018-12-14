function varargout = load_image(varargin)
% LOAD_IMAGE MATLAB code for load_image.fig
%      LOAD_IMAGE, by itself, creates a new LOAD_IMAGE or raises the existing
%      singleton*.
%
%      H = LOAD_IMAGE returns the handle to a new LOAD_IMAGE or the handle to
%      the existing singleton*.
%
%      LOAD_IMAGE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LOAD_IMAGE.M with the given input arguments.
%
%      LOAD_IMAGE('Property','Value',...) creates a new LOAD_IMAGE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before load_image_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to load_image_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help load_image

% Last Modified by GUIDE v2.5 11-Dec-2018 13:20:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @load_image_OpeningFcn, ...
                   'gui_OutputFcn',  @load_image_OutputFcn, ...
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


% --- Executes just before load_image is made visible.
function load_image_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to load_image (see VARARGIN)

% Choose default command line output for load_image
handles.output = hObject;
set(handles.axes_picture,'Units','pixels','box','off','XTickLabel',[],'XTick',[],'YTickLabel',[],'YTick',[])
set(handles.axes_res_picture,'Units','pixels','box','off','XTickLabel',[],'XTick',[],'YTickLabel',[],'YTick',[])
set(handles.axes_histogram,'Units','pixels','box','off','XTickLabel',[],'XTick',[],'YTickLabel',[],'YTick',[])
% Update handles structure
global statusGrayScale;
statusGrayScale = 0;


guidata(hObject, handles);

% UIWAIT makes load_image wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = load_image_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in push_btn_browse.
function push_btn_browse_Callback(hObject, eventdata, handles)
% hObject    handle to push_btn_browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global read_img; % define global variable
global statusGrayScale;
statusGrayScale = 0;
[filename pathname] = uigetfile({'*.jpg;*.png;*.jpeg'}, 'File Selector');
img_path = strcat(pathname ,filename);
read_img = imread(img_path);
axes(handles.axes_picture);

% set another button to on
set(handles.push_btn_grayscaling, 'Enable' , 'on');
set(handles.push_btn_zoom2, 'Enable','on');
set(handles.push_btn_unzoom2 , 'Enable' , 'on');
set(handles.push_btn_brightness , 'Enable', 'on');
set(handles.push_btn_up , 'Enable' , 'on');
set(handles.push_btn_down, 'Enable', 'on');
set(handles.push_btn_right, 'Enable','on');
set(handles.push_btn_left,'Enable','on');
set(handles.btn_histogram,'Enable','on');
set(handles.push_btn_histeq, 'Enable', 'on');
set(handles.value_threshold, 'Enable', 'on');
set(handles.value_rep_threshold, 'Enable', 'on');
set(handles.push_btn_threshold, 'Enable', 'on');
set(handles.value_x, 'Enable', 'on');
set(handles.value_y, 'Enable', 'on');
set(handles.push_btn_reg_growth, 'Enable', 'on');
set(handles.value_histeq, 'Enable', 'on');
set(handles.push_btn_blur, 'Enable', 'on');
set(handles.push_btn_edge, 'Enable', 'on');

% set resoultion
[rows cols] = size(read_img);
set(handles.origin_rows , 'String' , rows);
set(handles.origin_cols, 'String', cols);

imshow(read_img)


% --- Executes on button press in push_btn_grayscaling.
function push_btn_grayscaling_Callback(hObject, eventdata, handles)
% hObject    handle to push_btn_grayscaling (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global read_img
global grayscale_img
global statusGrayScale;
statusGrayScale = 1;
weight_R = get(handles.param_prob_R , 'String');
weight_G = get(handles.param_prob_G , 'String');
weight_B = get(handles.param_prob_B , 'String');
grayscale_img = myGrayScale(read_img,str2num(weight_R),str2num(weight_G),str2num(weight_B));
axes(handles.axes_picture);

% set another button to on
set(handles.param_prob_R, 'Enable' , 'on');
set(handles.param_prob_G, 'Enable','on');
set(handles.param_prob_B , 'Enable' , 'on');
imshow(grayscale_img)



% --- Executes on button press in push_btn_zoom2.
function push_btn_zoom2_Callback(hObject, eventdata, handles)
% hObject    handle to push_btn_zoom2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global grayscale_img;
global read_img;
global statusGrayScale;

[rows cols map] = size(grayscale_img); 
if (statusGrayScale)
    zoom2x = myZoom2(grayscale_img);
else
    zoom2x = myZoom2(read_img);
end
[rows cols] = size(zoom2x);
set(handles.result_rows , 'String' , rows);
set(handles.result_cols, 'String', cols);

axes(handles.axes_res_picture);
imshow(zoom2x)
refreshdata




% --- Executes on button press in push_btn_unzoom2.
function push_btn_unzoom2_Callback(hObject, eventdata, handles)
% hObject    handle to push_btn_unzoom2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global grayscale_img;
global read_img;
global statusGrayScale;

[rows cols map] = size(grayscale_img); 
if (statusGrayScale)
    unzoom2x = myUnzoom(grayscale_img);
else
    unzoom2x = myUnzoom(read_img);
end
[rows cols] = size(unzoom2x);
set(handles.result_rows , 'String' , rows);
set(handles.result_cols, 'String', cols);

axes(handles.axes_res_picture);
imshow(unzoom2x)
refreshdata



function param_prob_R_Callback(hObject, eventdata, handles)
% hObject    handle to param_prob_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of param_prob_R as text
%        str2double(get(hObject,'String')) returns contents of param_prob_R as a double


% --- Executes during object creation, after setting all properties.
function param_prob_R_CreateFcn(hObject, eventdata, handles)
% hObject    handle to param_prob_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function param_prob_G_Callback(hObject, eventdata, handles)
% hObject    handle to param_prob_G (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of param_prob_G as text
%        str2double(get(hObject,'String')) returns contents of param_prob_G as a double


% --- Executes during object creation, after setting all properties.
function param_prob_G_CreateFcn(hObject, eventdata, handles)
% hObject    handle to param_prob_G (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function param_prob_B_Callback(hObject, eventdata, handles)
% hObject    handle to param_prob_B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of param_prob_B as text
%        str2double(get(hObject,'String')) returns contents of param_prob_B as a double


% --- Executes during object creation, after setting all properties.
function param_prob_B_CreateFcn(hObject, eventdata, handles)
% hObject    handle to param_prob_B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in push_btn_brightness.
function push_btn_brightness_Callback(hObject, eventdata, handles)
% hObject    handle to push_btn_brightness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.val_brightness, 'Enable', 'on');
global read_img;

value_bright = get(handles.val_brightness, 'String');
res = myBrightness(read_img , str2num(value_bright));

axes(handles.axes_res_picture);
imshow(res)




function val_brightness_Callback(hObject, eventdata, handles)
% hObject    handle to val_brightness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of val_brightness as text
%        str2double(get(hObject,'String')) returns contents of val_brightness as a double


% --- Executes during object creation, after setting all properties.
function val_brightness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to val_brightness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in push_btn_right.
function push_btn_right_Callback(hObject, eventdata, handles)
% hObject    handle to push_btn_right (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global read_img;
result = myShifting(read_img, '1' , 20);

axes(handles.axes_res_picture);
imshow(result);

% --- Executes on button press in push_btn_down.
function push_btn_down_Callback(hObject, eventdata, handles)
% hObject    handle to push_btn_down (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global read_img;
result = myShifting(read_img, '4' , 20);

axes(handles.axes_res_picture);
imshow(result);

% --- Executes on button press in push_btn_left.
function push_btn_left_Callback(hObject, eventdata, handles)
% hObject    handle to push_btn_left (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global read_img;
result = myShifting(read_img, '2' , 20);

axes(handles.axes_res_picture);
imshow(result);


% --- Executes on button press in push_btn_up.
function push_btn_up_Callback(hObject, eventdata, handles)
% hObject    handle to push_btn_up (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global read_img;
result = myShifting(read_img, '3' , 20);

axes(handles.axes_res_picture);
imshow(result);


% --- Executes on button press in btn_histogram.
function btn_histogram_Callback(hObject, eventdata, handles)
% hObject    handle to btn_histogram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global read_img;

% get image from axes_res_pict
axes_res = getimage(handles.axes_res_picture);
if(~isempty(axes_res))
    histo = myHistogram(axes_res);
else
    histo = myHistogram(read_img);
end
n = 1:256;
axes(handles.axes_histogram);
cla
red = area(n, histo(1,:));
red.FaceColor = 'red';
hold on
green = area(n,histo(2,:));
green.FaceColor = 'green';
hold on
blue = area(n,histo(3,:));
blue.FaceColor = 'blue';

grid off;



% --- Executes on button press in push_btn_histeq.
function push_btn_histeq_Callback(hObject, eventdata, handles)
% hObject    handle to push_btn_histeq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global read_img;
range = get(handles.value_histeq, 'String');

img_histeq = myHisteq(read_img , str2num(range));
axes(handles.axes_res_picture);
imshow(img_histeq);




function value_histeq_Callback(hObject, eventdata, handles)
% hObject    handle to value_histeq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of value_histeq as text
%        str2double(get(hObject,'String')) returns contents of value_histeq as a double


% --- Executes during object creation, after setting all properties.
function value_histeq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to value_histeq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in push_btn_blur.
function push_btn_blur_Callback(hObject, eventdata, handles)
% hObject    handle to push_btn_blur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global grayscale_img;
global read_img;
global statusGrayScale;

if (statusGrayScale)
    result = myBlur2(grayscale_img);
else
    result = myBlur2(read_img);
end
axes(handles.axes_res_picture);
imshow(result);



% --- Executes on button press in push_btn_edge.
function push_btn_edge_Callback(hObject, eventdata, handles)
% hObject    handle to push_btn_edge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global grayscale_img;
global read_img;
global statusGrayScale;

if (statusGrayScale)
    result = myEdgeDetection(grayscale_img);
else
    result = myEdgeDetection(read_img);
end

axes(handles.axes_res_picture);
imshow(result);



% --- Executes on button press in push_btn_convolve.
function push_btn_convolve_Callback(hObject, eventdata, handles)
% hObject    handle to push_btn_convolve (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function value_threshold_Callback(hObject, eventdata, handles)
% hObject    handle to value_threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of value_threshold as text
%        str2double(get(hObject,'String')) returns contents of value_threshold as a double


% --- Executes during object creation, after setting all properties.
function value_threshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to value_threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function value_rep_threshold_Callback(hObject, eventdata, handles)
% hObject    handle to value_rep_threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of value_rep_threshold as text
%        str2double(get(hObject,'String')) returns contents of value_rep_threshold as a double


% --- Executes during object creation, after setting all properties.
function value_rep_threshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to value_rep_threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function value_x_Callback(hObject, eventdata, handles)
% hObject    handle to value_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of value_x as text
%        str2double(get(hObject,'String')) returns contents of value_x as a double


% --- Executes during object creation, after setting all properties.
function value_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to value_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function value_y_Callback(hObject, eventdata, handles)
% hObject    handle to value_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of value_y as text
%        str2double(get(hObject,'String')) returns contents of value_y as a double


% --- Executes during object creation, after setting all properties.
function value_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to value_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in push_btn_reg_growth.
function push_btn_reg_growth_Callback(hObject, eventdata, handles)
% hObject    handle to push_btn_reg_growth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global grayscale_img;
value_x = get(handles.value_x, 'String');
value_y = get(handles.value_y, 'String');
result = myRegionGrowth(grayscale_img , str2num(value_x) , str2num(value_y), 30);
axes(handles.axes_res_picture);
imshow(result);

% --- Executes on button press in push_btn_threshold.
function push_btn_threshold_Callback(hObject, eventdata, handles)
% hObject    handle to push_btn_threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global grayscale_img;
value_threshold = get(handles.value_threshold, 'String');
value_ths_rep = get(handles.value_rep_threshold, 'String');
result = myThreshold(grayscale_img, str2num(value_threshold), str2num(value_ths_rep));
axes(handles.axes_res_picture);
imshow(result);
