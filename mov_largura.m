function [L,R,U,D] = mov_largura(E_atual)
    [linha, coluna] = find(E_atual == 0);
    if(linha < 3)
        Valor_abaixo = E_atual(linha+1, coluna);
        D = E_atual;
        D(linha+1, coluna) = 0;
        D(linha, coluna) = Valor_abaixo;
    else
        D = 'n/a';
    end
    if(linha > 1)
        Valor_acima = E_atual(linha-1, coluna);
        U = E_atual;
        U(linha-1, coluna) = 0;
        U(linha, coluna) = Valor_acima;
    else
        U = 'n/a';
    end
    if(coluna > 1)    
        Valor_esquerda = E_atual(linha, coluna-1);
        L = E_atual;
        L(linha, coluna-1) = 0;
        L(linha, coluna) = Valor_esquerda;
    else
        L = 'n/a';
    end
    
    if(coluna < 3)
        Valor_direita = E_atual(linha, coluna+1); 
        R = E_atual;
        R(linha, coluna+1) = 0;
        R(linha,coluna) = Valor_direita;
    else
        R  = 'n/a';
    end
end