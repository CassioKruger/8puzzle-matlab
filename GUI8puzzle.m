function varargout = GUI8puzzle(varargin)
% GUI8PUZZLE MATLAB code for GUI8puzzle.fig
%      GUI8PUZZLE, by itself, creates a new GUI8PUZZLE or raises the existing
%      singleton*.
%
%      H = GUI8PUZZLE returns the handle to a new GUI8PUZZLE or the handle to
%      the existing singleton*.
%
%      GUI8PUZZLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI8PUZZLE.M with the given input arguments.
%
%      GUI8PUZZLE('Property','Value',...) creates a new GUI8PUZZLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI8puzzle_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI8puzzle_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI8puzzle

% Last Modified by GUIDE v2.5 02-May-2019 17:24:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI8puzzle_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI8puzzle_OutputFcn, ...
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


% --- Executes just before GUI8puzzle is made visible.
function GUI8puzzle_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI8puzzle (see VARARGIN)

% Choose default command line output for GUI8puzzle
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI8puzzle wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI8puzzle_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function estado_inicial_Callback(hObject, eventdata, handles)
% hObject    handle to estado_inicial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of estado_inicial as text
%        str2double(get(hObject,'String')) returns contents of estado_inicial as a double


% --- Executes during object creation, after setting all properties.
function estado_inicial_CreateFcn(hObject, eventdata, handles)
% hObject    handle to estado_inicial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function estado_meta_Callback(hObject, eventdata, handles)
% hObject    handle to estado_meta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of estado_meta as text
%        str2double(get(hObject,'String')) returns contents of estado_meta as a double


% --- Executes during object creation, after setting all properties.
function estado_meta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to estado_meta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ASTAR.
function ASTAR_Callback(hObject, eventdata, handles)
    START = [0 0 0; 0 0 0; 0 0 0];  %inicializando a variavel

    %aquisicao do estado inicial e final
    START = str2num(get(handles.estado_inicial,'String'));
    GOAL = str2num(get(handles.estado_meta,'String'));

    [passos,iteracoes,inversoes,flag_solucao,estado_atual] = ASTAR(START,GOAL);

    if(flag_solucao == 1)
        iteracoes = sprintf('%i',iteracoes);
        set(handles.SOL_TEXTO,'String','Solucionado: A*');
        set(handles.MOVIMENTOS,'String', iteracoes);

        assignin('base','passos',passos);
        [nao,numero_de_passos] = size(passos);
        
        set(handles.SLIDER_ESTADOS,'Min',1);
        set(handles.SLIDER_ESTADOS,'Max',numero_de_passos);
        set(handles.SLIDER_ESTADOS,'Value',1);
        set(handles.SLIDER_ESTADOS,'SliderStep',[1/(numero_de_passos-1), 1/(numero_de_passos-1)]);
        
    else
        set(handles.SOL_TEXTO, 'String', 'Numero impar de inversoes! Sem solucao');
    end
% hObject    handle to ASTAR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in BFS.
function BFS_Callback(hObject, eventdata, handles)
    %inicializando a variavel
    START = [0 0 0; 0 0 0; 0 0 0];  

    %aquisicao do estado inicial e final
    START = str2num(get(handles.estado_inicial,'String'));
    GOAL = str2num(get(handles.estado_meta,'String'));

    [passos,iteracoes,inversoes,flag_solucao,estado_atual] = BFS(START,GOAL)

    if(flag_solucao == 1)
        iteracoes = sprintf('%i',iteracoes);
        set(handles.SOL_TEXTO,'String','Solucionado: BFS');
        set(handles.MOVIMENTOS,'String', iteracoes);

        assignin('base','passos',passos);
        [nao,numero_de_passos] = size(passos);
        
        set(handles.SLIDER_ESTADOS,'Min',1);
        set(handles.SLIDER_ESTADOS,'Max',numero_de_passos);
        set(handles.SLIDER_ESTADOS,'Value',1);
        set(handles.SLIDER_ESTADOS,'SliderStep',[1/(numero_de_passos-1), 1/(numero_de_passos-1)]);
        
    else
        set(handles.SOL_TEXTO, 'String', 'Numero impar de inversoes! Sem solucao');
    end
    

    %SOL_TEXTO
    %MOVIMENTOS
    %SOLUCAO_MOVI
    
% hObject    handle to BFS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in DFS.
function DFS_Callback(hObject, eventdata, handles)
    START = [0 0 0; 0 0 0; 0 0 0];  %inicializando a variavel
% hObject    handle to DFS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in RRHILL.
function RRHILL_Callback(hObject, eventdata, handles)
    START = [0 0 0; 0 0 0; 0 0 0];  %inicializando a variavel
% hObject    handle to RRHILL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on slider movement.
function SLIDER_ESTADOS_Callback(hObject, eventdata, handles)
% hObject    handle to SLIDER_ESTADOS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
    valorAtual = round(get(hObject,'Value'));
    lista_passos = evalin('base','passos');
    [nao,numero_de_passos] = size(lista_passos);
    
    if round(valorAtual) == valorAtual
        temp = lista_passos{1,numero_de_passos - (valorAtual-1)};
        SOL11 = temp(1,1);
        SOL12 = temp(1,2);
        SOL13 = temp(1,3);
        SOL21 = temp(2,1);
        SOL22 = temp(2,2);
        SOL23 = temp(2,3);
        SOL31 = temp(3,1);
        SOL32 = temp(3,2);
        SOL33 = temp(3,3);
        
        if SOL11 == 0
            set(handles.SOL11,'FontWeight','bold');
            set(handles.SOL11,'String',SOL11);
        else
            set(handles.SOL11,'FontWeight','normal');
            set(handles.SOL11,'String',SOL11);
        end
        
        if SOL12 == 0
            set(handles.SOL12,'FontWeight','bold');
            set(handles.SOL12,'String',SOL12);
        else
            set(handles.SOL12,'FontWeight','normal');
            set(handles.SOL12,'String',SOL12);
        end
        
        if SOL13 == 0
            set(handles.SOL13,'FontWeight','bold');
            set(handles.SOL13,'String',SOL13);
        else
            set(handles.SOL13,'FontWeight','normal');
            set(handles.SOL13,'String',SOL13);
        end
        
        if SOL21 == 0
            set(handles.SOL21,'FontWeight','bold');
            set(handles.SOL21,'String',SOL21);
        else
            set(handles.SOL21,'FontWeight','normal');
            set(handles.SOL21,'String',SOL21);
        end
        
        if SOL22 == 0
            set(handles.SOL22,'FontWeight','bold');
            set(handles.SOL22,'String',SOL22);
        else
            set(handles.SOL22,'FontWeight','normal');
            set(handles.SOL22,'String',SOL22);
        end
        
        if SOL23 == 0
            set(handles.SOL23,'FontWeight','bold');
            set(handles.SOL23,'String',SOL23);
        else
            set(handles.SOL23,'FontWeight','normal');
            set(handles.SOL23,'String',SOL23);
        end
        
        if SOL31 == 0
            set(handles.SOL31,'FontWeight','bold');
            set(handles.SOL31,'String',SOL31);
        else
            set(handles.SOL31,'FontWeight','normal');
            set(handles.SOL31,'String',SOL31);
        end
        
        if SOL32 == 0
            set(handles.SOL32,'FontWeight','bold');
            set(handles.SOL32,'String',SOL32);
        else
            set(handles.SOL32,'FontWeight','normal');
            set(handles.SOL32,'String',SOL32);
        end
        
        if SOL33 == 0
            set(handles.SOL33,'FontWeight','bold');
            set(handles.SOL33,'String',SOL33);
        else
            set(handles.SOL33,'FontWeight','normal');
            set(handles.SOL33,'String',SOL33);
        end
    end

% --- Executes during object creation, after setting all properties.
function SLIDER_ESTADOS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLIDER_ESTADOS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
