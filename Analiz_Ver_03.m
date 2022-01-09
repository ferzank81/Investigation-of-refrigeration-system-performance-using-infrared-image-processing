function varargout = Analiz_Ver_03(varargin)
% ANALIZ_VER_03 MATLAB code for Analiz_Ver_03.fig
%      ANALIZ_VER_03, by itself, creates a new ANALIZ_VER_03 or raises the existing
%      singleton*.
%
%      H = ANALIZ_VER_03 returns the handle to a new ANALIZ_VER_03 or the handle to
%      the existing singleton*.
%
%      ANALIZ_VER_03('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANALIZ_VER_03.M with the given input arguments.
%
%      ANALIZ_VER_03('Property','Value',...) creates a new ANALIZ_VER_03 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Analiz_Ver_03_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Analiz_Ver_03_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Analiz_Ver_03

% Last Modified by GUIDE v2.5 28-Mar-2020 20:27:03

% Begin initialization code - DO NOT EDIT
%--------------------------------------------------------
%NOTE:

%Please perform the following steps in order

%-----------------------------------------------------------
% 1. Select the thermal image you will work with by pressing the "Görüntü Aç" button.
% 2. Enter the "ALT" lower and "ÜST" upper values (tempuratures) written in the thermal image into the relevant text boxes.
% 3. After pressing the "Kes" button, click your mouse twice to determine the area you will work on.
% 4. Enter the segmentation number in the two text boxes and click the "Bölütleme" button.
% 5. After entering the Segmentation numbers to be analyzed, click the "Analize Baþla" button.
%------------------------------------------------------------

% For more descriptive and theoretical information, you can review the article below.

% KATIRCIOÐLU, F., CÝNGÝZ, Z., Yusuf, Ç. A. Y., GÜREL, A. E., SARIDEMÝR, S., & KOLÝP,A. (2020)
% R22 ve Alternatifleri R438A ile R417A Soðutucu Akýþkanlarý için Kýzýlötesi Görüntü Ýþleme Teknikleri Kullanarak, 
% Soðutma Sistem Performansýnýn Ýncelenmesi. Academic Platform Journal of Engineering and Science, 8(3), 500-513.
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Analiz_Ver_03_OpeningFcn, ...
                   'gui_OutputFcn',  @Analiz_Ver_03_OutputFcn, ...
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


% --- Executes just before Analiz_Ver_03 is made visible.
function Analiz_Ver_03_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Analiz_Ver_03 (see VARARGIN)

% Choose default command line output for Analiz_Ver_03
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Analiz_Ver_03 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Analiz_Ver_03_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


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


% --- Executes on button press in Kes.
function Kes_Callback(hObject, eventdata, handles)
% hObject    handle to Kes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global resim1;
global resim2;
global Temp1;

alt= str2num(get(handles.edit1, 'String'));
ust = str2num(get(handles.edit2, 'String'));

Temp=sicaklik(resim1,alt, ust);

[xreg yreg] = ginput(2); %2 points
    if (length(xreg) < 2)
      return%break
  end
    rect=[min(xreg)   min(yreg)   abs(xreg(2)-xreg(1))    abs(yreg(2)-yreg(1))];
  x1 = round(min(xreg));
  x2 = round( abs(xreg(2)-xreg(1)));
  y1 = round(min(yreg));
  y2 = round(abs(yreg(2)-yreg(1)));
  
  resim2= resim1(y1:y2,x1:x2,:);
  Temp1= Temp(y1:y2,x1:x2,:);
  resim2 = imresize(resim2,[240 320]);
  Temp1 = imresize(Temp1,[240 320]);
  
   axes(handles.axes2);
    imshow(resim2);
%     figure, imshow(Temp1);
    



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Bolutleme.
function Bolutleme_Callback(hObject, eventdata, handles)
% hObject    handle to Bolutleme (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes2,'reset');
global resim2;
global Img1;
global Temp1;
global Temp11;



resim3=[];
resim3=resim2;%Referans görüntü

satir = str2num(get(handles.edit3, 'String'));
sutun = str2num(get(handles.edit4, 'String'));
I=rgb2gray(resim3);
[satirlar, sutunlar]=size(I);
    mr = round(satirlar/satir); % median of rows
    mc = round(sutunlar/sutun); % median of columns
     
    mr1=mr;
    sayac2=0;
    sayac3=1;
for i = 1 : mr : satirlar-2
    if(sayac2==satir-1)
            mr1=satirlar;
        end
    mc1=mc;
    sayac1=0;
    
    for j = 1 : mc : sutunlar-2
        if(sayac1==sutun-1)
            mc1=sutunlar;
        end

         image1(:,:,1)=resim3(i:mr1, j:mc1,1);
         image1(:,:,2)=resim3(i:mr1, j:mc1,2);
         image1(:,:,3)=resim3(i:mr1, j:mc1,3);
         %--------------------------------------
         
         %--------------------------------------
         image3=Temp1(i:mr1, j:mc1);
         
         %--------------------------------
         Img1{sayac3}=image1;
         
         Temp11{sayac3}=image3;
        
         mc1=mc1+mc;
         sayac1=sayac1+1;
         sayac3=sayac3+1;
    end
    mr1=mr1+mr;
    sayac2=sayac2+1;
end
%Seçilmiþ bölgeleri numaralandýrma ve bölgeleri çizme
% axes(handles.axes7);
% figure, imshow(resim2);
% hold on;
sayi=1;
for row = 1 : satirlar/satir : satirlar
    for col = 1 : sutunlar/sutun : sutunlar
%     resim2 = insertText(resim2, , sayi,10);
%     resim3=insertText(resim3,[col row ],sayi,'FontSize',10,'TextColor','white');
    sayi=sayi+1;
    end
end
 axes(handles.axes2);
 imshow(resim3);
hold on;
for row = 1 : satirlar/satir : satirlar
    line([1, sutunlar], [row, row], 'Color', 'r', 'LineWidth', 1);
end
for col = 1 : sutunlar/sutun : sutunlar
    line([col, col], [1, satirlar], 'Color', 'r', 'LineWidth', 1);
end
hold off;


function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Analiz.
function Analiz_Callback(hObject, eventdata, handles)
% hObject    handle to Analiz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Img1;

global Temp11;
global veri;
bolgeler = str2num(get(handles.edit5, 'String'));
%Kesilen parçalarýn görüntülenmesi
 sayi=numel(bolgeler);
 axes(handles.axes3); imshow(Img1{bolgeler(1,1)});imwrite(Img1{bolgeler(1,1)}, '1.jpg');
 
 axes(handles.axes4); imshow(Img1{bolgeler(1,2)}); imwrite(Img1{bolgeler(1,2)}, '2.jpg');

 axes(handles.axes5); imshow(Img1{bolgeler(1,3)}); imwrite(Img1{bolgeler(1,3)}, '3.jpg');
 
 axes(handles.axes6); imshow(Img1{bolgeler(1,4)}); imwrite(Img1{bolgeler(1,4)}, '4.jpg');
 
 axes(handles.axes7); imshow(Img1{bolgeler(1,5)}); imwrite(Img1{bolgeler(1,5)}, '5.jpg');

 axes(handles.axes8); imshow(Img1{bolgeler(1,6)}); imwrite(Img1{bolgeler(1,6)}, '6.jpg');
 
 axes(handles.axes10); imshow(Img1{bolgeler(1,7)}); imwrite(Img1{bolgeler(1,7)}, '7.jpg');
 
 axes(handles.axes11); imshow(Img1{bolgeler(1,8)}); imwrite(Img1{bolgeler(1,8)}, '8.jpg');
 
 axes(handles.axes12); imshow(Img1{bolgeler(1,9)}); imwrite(Img1{bolgeler(1,9)}, '9.jpg');
 
 axes(handles.axes13); imshow(Img1{bolgeler(1,10)}); imwrite(Img1{bolgeler(1,10)}, '10.jpg');
 %Kesilen parçalardan özniteliklerin oluþturulmasý
 alt= str2num(get(handles.edit1, 'String'));
ust = str2num(get(handles.edit2, 'String'));
  data1=zeros(sayi,8);
  
 for i=1:10
%      for j=1:6
         Img1{bolgeler(1,i)};
         [X1 X2 X3 X4 X5 X6 X7 X8]=oznitelikler(Img1{bolgeler(1,i)},Temp11{bolgeler(1,i)}, alt, ust);
         data1(i,1)=X1; data1(i,2)=X2; data1(i,3)=X3; data1(i,4)=X4;
         data1(i,5)=X5; data1(i,6)=X6; data1(i,7)=X7; data1(i,8)=X8;
      
      
       
        x=1:8; 
        axes(handles.axes9);

        plot(x,data1(i,:));
        
        title(['\fontsize{10}  Kesilen bölgelerin daðýlým grafikleri']);
        xlabel('\fontsize{8} Öznitelik Sayýsý');
        ylabel('\fontsize{8} Öznitelik Deðerleri');
         
        hold on;
       
 end
 veri=[];
 veri=data1;
 %Elde edilen  matrisin görüntülenmesi
  text_to_display = cellstr(num2str(data1));
  figure;
  for i=1:10
      x=1:8; 
       
        plot(x,veri(i,:));
        
               
        hold on;
  end
 title(['\fontsize{10}  Kesilen bölgelerin daðýlým grafikleri']);
  xlabel('\fontsize{8} Öznitelik Sayýsý');
  ylabel('\fontsize{8} Öznitelik Deðerleri');
set(handles.uitable1,'data',data1);
  
% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
global resim1;
[path, iptal]=imgetfile();
if iptal==0
    resim1=imread(path);
    axes(handles.axes1);
    imshow(resim1);
end



% --- Executes during object creation, after setting all properties.
function uitable1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function axes9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes9
