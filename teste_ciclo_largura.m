function [L, R, U, D] = teste_ciclo_largura(L,R,U,D,aberto)

L_teste = find(arrayfun(@(s) (isequal(L, s.estado)==1), aberto));
R_teste = find(arrayfun(@(s) (isequal(R, s.estado)==1), aberto));
U_teste = find(arrayfun(@(s) (isequal(U, s.estado)==1), aberto));
D_teste = find(arrayfun(@(s) (isequal(D, s.estado)==1), aberto));



    if(isempty(L_teste))
        L = L;
    else
        L = 'n/a';
    end

    if(isempty(R_teste))
        R = R;
    else
        R = 'n/a';
    end

    if(isempty(U_teste))
        U = U;
    else
        U = 'n/a';
    end
    if(isempty(D_teste))
        D = D;
    else
        D = 'n/a';
    end

end

