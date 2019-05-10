function fechados = vizinhos_append_largura(L,R,U,D,fechados,D_atual,E_atual)
    if(L ~= 'n/a')
            fechados{1,end+1}=L;
            fechados{1,end+1}=D_atual+1;
            fechados{1,end+1}=E_atual;
    end
    if(R ~= 'n/a')
            fechados{1,end+1}=R;
            fechados{1,end+1}=D_atual+1;
            fechados{1,end+1}=E_atual;
    end
    if(U ~= 'n/a')  
            fechados{1,end+1}=U;
            fechados{1,end+1}=D_atual+1;
            fechados{1,end+1}=E_atual;
    end
    if(D ~= 'n/a')
            fechados{1,end+1}=D;
            fechados{1,end+1}=D_atual+1;
            fechados{1,end+1}=E_atual;
    end
end