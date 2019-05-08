clear all
clc


atual = 1;
aberto = 1;

estado_inicial = [7,2,4,5,0,6,8,3,1];
estado_meta    = [0,1,2,3,4,5,6,7,8];

start = [estado_inicial(1:3);estado_inicial(4:6);estado_inicial(7:9)] 
goal = [estado_meta(1:3);estado_meta(4:6);estado_meta(7:9)]

%adiciona a fronteira
grafo.fronteira(atual) = {start}  

%movimentos
[lin, col] = find( grafo.fronteira{atual} == 0); %procura a posicao do zero na matriz e retorna lin e col;

% movimentando para gerar novos estados
for r = 1:2

    

    [lin, col] = find( grafo.fronteira{atual} == 0);        %procura a posicao do zero na matriz e retorna lin e col;

    % movimentacoes
    if(lin < 3)
        auxElemento = grafo.fronteira{atual}(lin+1, col);   % salva o valor que esta em cima do vazio
        auxMatriz = grafo.fronteira{atual};
        auxMatriz(lin+1, col) = 0;                          % move o espaco vazio
        auxMatriz(lin, col) = auxElemento;                  % move o elemento para o espaco vazio anterior
        
        % verifica se o novo estado já foi visitado antes; caso sim, nao add na fronteira
        flagJaAberto = find(arrayfun(@(s) (isequal(auxMatriz, s.fronteira)==1), grafo));
        if flagJaAberto == 0
            grafo.fronteira(end+1) = {auxMatriz};           % add o novo estado na fronteira
        end
    end

    if(lin > 1)
        auxElemento = grafo.fronteira{atual}(lin-1, col);   % salva o valor que esta embaixo do vazio
        auxMatriz = grafo.fronteira{atual};
        auxMatriz(lin-1, col) = 0;                          % move o espaco vazio
        auxMatriz(lin, col) = auxElemento;                  % move o elemento para o espaco vazio anterior
        grafo.fronteira(end+1) = {auxMatriz};               % add o novo estado na fronteira

        % verifica se o novo estado já foi visitado antes; caso sim, nao add na fronteira
        flagJaAberto = find(arrayfun(@(s) (isequal(auxMatriz, s.fronteira)==1), grafo));
        if flagJaAberto == 0
            grafo.fronteira(end+1) = {auxMatriz};           % add o novo estado na fronteira
        end
    end

    if(col > 1)    
        auxElemento = grafo.fronteira{atual}(lin, col-1);  % salva o valor que esta na esquerda do vazio
        auxMatriz = grafo.fronteira{atual};
        auxMatriz(lin, col-1) = 0;                          % move o espaco vazio
        auxMatriz(lin, col) = auxElemento;                  % move o elemento para o espaco vazio anterior
        grafo.fronteira(end+1) = {auxMatriz};              % add o novo estado na fronteira

        % verifica se o novo estado já foi visitado antes; caso sim, nao add na fronteira
        flagJaAberto = find(arrayfun(@(s) (isequal(auxMatriz, s.fronteira)==1), grafo));
        if flagJaAberto == 0
            grafo.fronteira(end+1) = {auxMatriz};           % add o novo estado na fronteira
        end
    end
    
    if(col < 3)
        auxElemento = grafo.fronteira{atual}(lin, col+1);  % salva o valor que esta na direita do vazio   
        auxMatriz = grafo.fronteira{atual};
        auxMatriz(lin, col+1) = 0;                         % move o espaco vazio
        auxMatriz(lin,col) = auxElemento;                  % move o elemento para o espaco vazio anterior
        grafo.fronteira(end+1) = {auxMatriz};              % add o novo estado na fronteira

        % verifica se o novo estado já foi visitado antes; caso sim, nao add na fronteira
        flagJaAberto = find(arrayfun(@(s) (isequal(auxMatriz, s.fronteira)==1), grafo));
        if flagJaAberto == 0
            grafo.fronteira(end+1) = {auxMatriz};           % add o novo estado na fronteira
        end
    end

    grafo.visitados(aberto) = grafo.fronteira(atual);      % salva o estado atual nos visitados
    grafo.fronteira(atual) = [];                           % retira o estado recem aberto da fronteira

    aberto = aberto + 1;
    %atual = atual + 1;

end

%grafo.fronteira{atual}
grafo.fronteira
grafo.fronteira{:}

grafo.visitados
grafo.visitados{:}