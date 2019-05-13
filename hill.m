function [aberto,passos,t] = hill(E0, Ef)
    clc
    tic
    estado_reset = E0;
    
    
    %LISTA DE NÓS NÃO EXPLORADOS:%
    fechados.estado=estado_reset;
    fechados.f = 300;
    fechados.g = 0;
    fechados.pai = [];
    
    
    %VARIAVEIS DE APOIO
    maxlocais = {0};
    aberto_ciclo = {0};
    aberto.estado = [];
    maxlocaisfinal = {0};
    fdc = {0};
    estado_atual = estado_reset;
    f_atual = 0;
    proximo_estado = 0;
    proximo_f = 0;
    obj_atingido = 0;
    maxlocaist={0};
    
    
    
    
    
    
    
    %%Confere se valores de entrada est�o de acordo:
    if(size(E0) ~= [3 3] | sum(sum(E0)) ~= 36)
    passos = {};
    aberto = {};
    fechados = {};
    else
        
        E0V = reshape(E0.',1,9);
        inversoes = 0;
        for valor_testado = 1:8
            for pos_comparada = valor_testado+1:9
                if(E0V(valor_testado)>E0V(pos_comparada) && E0V(pos_comparada) > 0)
                    inversoes = inversoes + 1;
                end
            end
        end
        
        
        
        
        if rem(inversoes, 2) == 0 %Caso o n�mero de invers�es seja PAR:
            while(obj_atingido ~= 1)   

 
                
                %PROXIMO NÓ A SER EXPLORADO:%
                estado_atual=fechados.estado;
                pai_atual=fechados.pai;
                g_atual=fechados.g;
                f_atual=fechados.f;
                fechados(1).estado=[];
                
                
                %SALVA ESTE NÓ NA LISTA DE NÓS EXPLORADOS FINAL
                aberto(end).estado = estado_atual;
                aberto(end).pai = pai_atual;
                aberto(end).g = g_atual;
                aberto(end).f = f_atual;
                aberto(end+1).estado = [];
                
                aberto_ciclo{end}=estado_atual;
                aberto_ciclo{end+1}={0};

                %BUSCA POSS�?VEIS MOVIMENTOS E FILTRA ELES
                vizinhos = mov(estado_atual);
                vizinhos_filtro = teste_ciclo(vizinhos,maxlocais);
                vizinhos_filtro1 = teste_ciclo(vizinhos_filtro, aberto_ciclo);
                vizinhos_filtro2 = teste_ciclo(vizinhos_filtro1, fdc);
                vizinhos_filtro2(end)=[];
                
                [fechados, estado_reset,maxlocais,maxlocaist,aberto_ciclo,fdc] = encosta(vizinhos_filtro2, estado_atual, g_atual, f_atual, estado_reset,maxlocais,maxlocaist,Ef,aberto_ciclo,fdc);
                


                obj_atingido = isequal(estado_atual,Ef);

                if (obj_atingido)
                   clc
                   passos=caminho(aberto,E0,Ef);
                   disp('Passos requeridos:');
                   disp(length(passos));
                   aberto(1)=[];
                   t=toc
                end
                
                
                
%                 pause;
            end
            
        else
            passos = {};
            aberto = {};
            fechados = {};
            disp('Formato inv�lido');
        end
    end
end




