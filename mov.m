function vizinho = mov(E_atual)
    [linha, coluna] = find(E_atual == 0);
    vizinho = {0};

    if(coluna > 1)                                                          %CONFERE SE É POSSÍVEL MOVER PARA ESQUERDA
        Valor_esquerda = E_atual(linha, coluna-1);
        L = E_atual;
        L(linha, coluna-1) = 0;
        L(linha, coluna) = Valor_esquerda;
        vizinho{end}=L;
        vizinho{end+1}={};
    end
    
    if(coluna < 3)                                                          %CONFERE SE É POSSÍVEL MOVER PARA DIREITA
        Valor_direita = E_atual(linha, coluna+1);
        R = E_atual;
        R(linha, coluna+1) = 0;
        R(linha,coluna) = Valor_direita;
        vizinho{end}=R;
        vizinho{end+1}={};
    end
    if(linha > 1)                                                          %CONFERE SE É POSSÍVEL MOVER PARA CIMA
        Valor_acima = E_atual(linha-1, coluna);
        U = E_atual;
        U(linha-1, coluna) = 0;
        U(linha, coluna) = Valor_acima;
        vizinho{end}=U;
        vizinho{end+1}={};
    end
    
    if(linha < 3)                                                          %CONFERE SE É POSSÍVEL MOVER PARA BAIXO
        Valor_abaixo = E_atual(linha+1, coluna);
        D = E_atual;
        D(linha+1, coluna) = 0;
        D(linha, coluna) = Valor_abaixo;
        vizinho{end}=D;
        vizinho{end+1}={};
    end


end