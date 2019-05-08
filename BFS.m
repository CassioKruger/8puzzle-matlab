function [passos,iteracoes,inversoes,flag_solucao,estado_atual] = BFS(estado_inicial,estado_meta)

    % inicializando variaveis
    atual = 1;              % indice para as estruturas
    flag_terminou = 0;      % flag para indicar se o estado meta foi aberto
     
    passos = 0;
    iteracoes = 0;
    inversoes = 0;
    flag_solucao = 0;
    estado_atual = zeros(1,9);
    start = zeros(1,9);
    goal = zeros(1,9);

    %% ---------------------------%%

    start = [estado_inicial(1:3);estado_inicial(4:6);estado_inicial(7:9)];  % converte a array do estado_inicial para uma matriz
    goal = [estado_meta(1:3);estado_meta(4:6);estado_meta(7:9)];
    
    estado_atual = sprintf('%d', estado_inicial);   % para printar    
    
    grafo.fronteira(atual) = {start};           % add estado inicial ao grafo (primeira camada)
    grafo.fronteira{atual}  
    
    grafo.meta(1) = {goal};                     % add estado meta ao grafo
    grafo.meta{:}
    
    % verificacao se para o estado inicial, existe solucao -> IMPAR: sem solucao; PAR: com solucao
    for col = 1:8
        for aux = (col+1):9
            if(estado_inicial(col) > estado_inicial(aux)) && (estado_inicial(aux)>0)
                inversoes = inversoes + 1;
            end
        end
    end

    if (mod(inversoes,2) == 0)        % testa se o RESTO DE 2 de inversoes eh igual a zero
        flag_solucao = 1;             % existe solucao
    else
        flag_solucao = 0;             % n existe solucao
    end

    %% -------------------------%%
    %%  comeco do algoritmo BFS %%
    %% -------------------------%%
       
    % fazer uma queue/consulta
    if (flag_solucao == 1)
        % os proximos movimentos dependem de onde o ZERO esta;
        % se estiver nos cantos, possui mais 2 movimentos possiveis;
        % se estiver nas laterais, mas no quadrado do meio, possui mais 3 movimentos possiveis;
        % se estiver no meio, possui mais 4 movimentos possiveis;

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
        

end