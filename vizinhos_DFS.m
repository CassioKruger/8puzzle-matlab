function fechados = vizinhos_append(L,R,U,D,fechados,D_atual,E_atual,limite)
if(D_atual+1 <= limite)
    if(L ~= 'n/a')
            lista = {L D_atual+1 E_atual};
            fechados = [lista fechados];
    end
    if(R ~= 'n/a')
            lista = {R D_atual+1 E_atual};
            fechados = [lista fechados];
    end
    if(U ~= 'n/a')  
            lista = {U D_atual+1 E_atual};
            fechados = [lista fechados];
    end
    if(D ~= 'n/a')
            lista = {D D_atual+1 E_atual};
            fechados = [lista fechados];
    end
end
end