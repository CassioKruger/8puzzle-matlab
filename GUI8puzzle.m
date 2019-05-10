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

% Last Modified by GUIDE v2.5 10-May-2019 13:36:28

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
    set(handles.SOL_TEXTO,'String','Processando');    
    START = [0 0 0; 0 0 0; 0 0 0];  %inicializando a variavel
    
    %aquisicao do estado inicial e final
    estadoInicial = str2num(get(handles.estado_inicial,'String'));
    estadoMeta = str2num(get(handles.estado_meta,'String'));

    if (sum(sum(estadoInicial)) ~= 36)
        set(handles.SOL_TEXTO,'String','Matriz Invalida!','ForegroundColor','red');     
    else
        START = [estadoInicial(1:3);estadoInicial(4:6);estadoInicial(7:9)]
        GOAL  = [estadoMeta(1:3);estadoMeta(4:6);estadoMeta(7:9)]

        [abertosEstrela,passosEstrela] = estrela(START,GOAL);

        iteracoes = length(abertosEstrela)
        passos = length(passosEstrela)

        iteracoes = sprintf('%i',iteracoes);
        set(handles.SOL_TEXTO,'String','A*','ForegroundColor','green');
        set(handles.MOVIMENTOS,'String', iteracoes);
        set(handles.SOLUCAO_MOVI,'String', passos);

        assignin('base','passos',passosEstrela);
        assignin('base','abertos',abertosEstrela);
            
        set(handles.SLIDER_ESTADOS,'Min',1);
        set(handles.SLIDER_ESTADOS,'Max',passos);
        set(handles.SLIDER_ESTADOS,'Value',1);
        set(handles.SLIDER_ESTADOS,'SliderStep',[1/(passos-1), 1/(passos-1)]);
        SLIDER_ESTADOS_Callback(handles.SLIDER_ESTADOS, eventdata, handles);
    end
    
% hObject    handle to ASTAR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in BFS.
function BFS_Callback(hObject, eventdata, handles)
    set(handles.SOL_TEXTO,'String','Processando');
    %inicializando a variavel
    START = [0 0 0; 0 0 0; 0 0 0];  %inicializando a variavel

    %aquisicao do estado inicial e final
    estadoInicial = str2num(get(handles.estado_inicial,'String'));
    estadoMeta = str2num(get(handles.estado_meta,'String'));
    limite = str2num(get(handles.limiteProfundidade,'String'));

    if (sum(sum(estadoInicial)) ~= 36)
        set(handles.SOL_TEXTO,'String','Matriz Invalida!','ForegroundColor','red');     
    else
        START = [estadoInicial(1:3);estadoInicial(4:6);estadoInicial(7:9)]
        GOAL  = [estadoMeta(1:3);estadoMeta(4:6);estadoMeta(7:9)]
        [abertosLargura,passosLargura] = largura(START,GOAL);

        iteracoes = length(abertosLargura)
        passos = length(passosLargura)

        iteracoes = sprintf('%i',iteracoes);
        set(handles.SOL_TEXTO,'String','LARGURA','ForegroundColor','green');
        set(handles.MOVIMENTOS,'String', iteracoes);
        set(handles.SOLUCAO_MOVI,'String', passos);

        assignin('base','passos',passosLargura);
            
        set(handles.SLIDER_ESTADOS,'Min',1);
        set(handles.SLIDER_ESTADOS,'Max',passos);
        set(handles.SLIDER_ESTADOS,'Value',1);
        set(handles.SLIDER_ESTADOS,'SliderStep',[1/(passos-1), 1/(passos-1)]);
        SLIDER_ESTADOS_Callback(handles.SLIDER_ESTADOS, eventdata, handles);  
    end  

    
% hObject    handle to BFS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in DFS.
function DFS_Callback(hObject, eventdata, handles)
    set(handles.SOL_TEXTO,'String','Processando');
    %inicializando a variavel
    START = [0 0 0; 0 0 0; 0 0 0];  %inicializando a variavel

    %aquisicao do estado inicial e final
    estadoInicial = str2num(get(handles.estado_inicial,'String'));
    estadoMeta = str2num(get(handles.estado_meta,'String'));
    limite = str2num(get(handles.limiteProfundidade,'String'));
  
    if (sum(sum(estadoInicial)) ~= 36)
        set(handles.SOL_TEXTO,'String','Matriz Invalida!','ForegroundColor','red');     
    else
        START = [estadoInicial(1:3);estadoInicial(4:6);estadoInicial(7:9)]
        GOAL  = [estadoMeta(1:3);estadoMeta(4:6);estadoMeta(7:9)]  
        [abertosProfundidade,passosProfundidade] = profundidade(START,GOAL,limite);

        iteracoes = length(abertosProfundidade)
        passos = length(passosProfundidade)

        if (passos > 1)                                                                  % se encontrou solucao
            iteracoes = sprintf('%i',iteracoes);
            set(handles.SOL_TEXTO,'String','PROFUNDIDADE','ForegroundColor','green');
            set(handles.MOVIMENTOS,'String', iteracoes);
            set(handles.SOLUCAO_MOVI,'String', passos);

            assignin('base','passos',passosProfundidade);
                
            set(handles.SLIDER_ESTADOS,'Min',1);
            set(handles.SLIDER_ESTADOS,'Max',passos);
            set(handles.SLIDER_ESTADOS,'Value',1);
            set(handles.SLIDER_ESTADOS,'SliderStep',[1/(passos-1), 1/(passos-1)]);
            SLIDER_ESTADOS_Callback(handles.SLIDER_ESTADOS, eventdata, handles); 
        else                                                                              % se nao encontrou
            iteracoes = sprintf('%i',iteracoes);
            set(handles.SOL_TEXTO,'String','PROFUNDIDADE');
            set(handles.MOVIMENTOS,'String', 'profundidade insuficiente');
            set(handles.SOLUCAO_MOVI,'String', 'profundidade insuficiente');

            set(handles.SOL11,'FontWeight','bold','ForegroundColor','red','BackgroundColor','black','String','null');
            set(handles.SOL12,'FontWeight','bold','ForegroundColor','red','BackgroundColor','black','String','null');
            set(handles.SOL13,'FontWeight','bold','ForegroundColor','red','BackgroundColor','black','String','null');
            set(handles.SOL21,'FontWeight','bold','ForegroundColor','red','BackgroundColor','black','String','null');
            set(handles.SOL22,'FontWeight','bold','ForegroundColor','red','BackgroundColor','black','String','null');
            set(handles.SOL23,'FontWeight','bold','ForegroundColor','red','BackgroundColor','black','String','null');
            set(handles.SOL31,'FontWeight','bold','ForegroundColor','red','BackgroundColor','black','String','null');
            set(handles.SOL32,'FontWeight','bold','ForegroundColor','red','BackgroundColor','black','String','null');
            set(handles.SOL33,'FontWeight','bold','ForegroundColor','red','BackgroundColor','black','String','null');
        end 
    end
    
% hObject    handle to DFS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in RRHILL.
function RRHILL_Callback(hObject, eventdata, handles)
    set(handles.SOL_TEXTO,'String','Processando');
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
    passoAtual = round(get(hObject,'Value'))
    listaPassos = evalin('base','passos')
    steps = length(listaPassos)
    
    if round(passoAtual) == passoAtual
        temp = listaPassos{passoAtual};
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
            set(handles.SOL11,'FontWeight','bold','ForegroundColor','green','BackgroundColor','black');
            set(handles.SOL11,'String',SOL11);
        else
            set(handles.SOL11,'FontWeight','normal','ForegroundColor','black','BackgroundColor','white');
            set(handles.SOL11,'String',SOL11);
        end
        
        if SOL12 == 0
            set(handles.SOL12,'FontWeight','bold','ForegroundColor','green','BackgroundColor','black');
            set(handles.SOL12,'String',SOL12);
        else
            set(handles.SOL12,'FontWeight','normal','ForegroundColor','black','BackgroundColor','white');
            set(handles.SOL12,'String',SOL12);
        end
        
        if SOL13 == 0
            set(handles.SOL13,'FontWeight','bold','ForegroundColor','green','BackgroundColor','black');
            set(handles.SOL13,'String',SOL13);
        else
            set(handles.SOL13,'FontWeight','normal','ForegroundColor','black','BackgroundColor','white');
            set(handles.SOL13,'String',SOL13);
        end
        
        if SOL21 == 0
            set(handles.SOL21,'FontWeight','bold','ForegroundColor','green','BackgroundColor','black');
            set(handles.SOL21,'String',SOL21);
        else
            set(handles.SOL21,'FontWeight','normal','ForegroundColor','black','BackgroundColor','white');
            set(handles.SOL21,'String',SOL21);
        end
        
        if SOL22 == 0
            set(handles.SOL22,'FontWeight','bold','ForegroundColor','green','BackgroundColor','black');
            set(handles.SOL22,'String',SOL22);
        else
            set(handles.SOL22,'FontWeight','normal','ForegroundColor','black','BackgroundColor','white');
            set(handles.SOL22,'String',SOL22);
        end
        
        if SOL23 == 0
            set(handles.SOL23,'FontWeight','bold','ForegroundColor','green','BackgroundColor','black');
            set(handles.SOL23,'String',SOL23);
        else
            set(handles.SOL23,'FontWeight','normal','ForegroundColor','black','BackgroundColor','white');
            set(handles.SOL23,'String',SOL23);
        end
        
        if SOL31 == 0
            set(handles.SOL31,'FontWeight','bold','ForegroundColor','green','BackgroundColor','black');
            set(handles.SOL31,'String',SOL31);
        else
            set(handles.SOL31,'FontWeight','normal','ForegroundColor','black','BackgroundColor','white');
            set(handles.SOL31,'String',SOL31);
        end
        
        if SOL32 == 0
            set(handles.SOL32,'FontWeight','bold','ForegroundColor','green','BackgroundColor','black');
            set(handles.SOL32,'String',SOL32);
        else
            set(handles.SOL32,'FontWeight','normal','ForegroundColor','black','BackgroundColor','white');
            set(handles.SOL32,'String',SOL32);
        end
        
        if SOL33 == 0
            set(handles.SOL33,'FontWeight','bold','ForegroundColor','green','BackgroundColor','black');
            set(handles.SOL33,'String',SOL33);
        else
            set(handles.SOL33,'FontWeight','normal','ForegroundColor','black','BackgroundColor','white');
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



function limiteProfundidade_Callback(hObject, eventdata, handles)
% hObject    handle to limiteProfundidade (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of limiteProfundidade as text
%        str2double(get(hObject,'String')) returns contents of limiteProfundidade as a double


% --- Executes during object creation, after setting all properties.
function limiteProfundidade_CreateFcn(hObject, eventdata, handles)
% hObject    handle to limiteProfundidade (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
