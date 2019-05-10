function [flag, pos] = checkobj_largura(L,R,U,D,Ef)
    if(L == Ef)
        flag = 1;
        pos = L;
    elseif(R == Ef)
        flag = 1;
        pos = R;
    elseif(U == Ef)
        flag = 1;
        pos = U;
    elseif(D == Ef)
        flag = 1;
        pos = D;
    else
        flag = 0;
        pos = 0;
    end
    
    
end