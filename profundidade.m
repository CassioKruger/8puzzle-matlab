function [aberto,passos] = profundidade(E0, Ef,limite)
    tic
    fechados = {E0, 0, []};
    aberto = struct;
    obj_atingido = 0;
    %%Confere se valores de entrada est�o de acordo:
    if(size(E0) ~= [3 3] | sum(sum(E0)) ~= 36)
    passos = {};
   
    else
        invert = inversoes_profundidade(E0);  %%Confere se existe solu��o:
        
        if rem(invert, 2) == 0 %Caso o n�mero de invers�es seja PAR:
            
            while(obj_atingido ~= 1)
                
                E_atual = fechados{1}; %Pega o proximo valor da fila
                D_atual = fechados{2}; %Pega a distância dele da origem
                P_atual = fechados{3}; %Pega o nó que originou ele


                % Desloca vetor dos fechados
                fechados(1:3)=[];             
                %Passa o estado atual para a lista dos abertos:
                pos = length(aberto)+1;
                aberto(pos).estado=E_atual;
                aberto(pos).custo=D_atual;
                aberto(pos).pai=P_atual;
                
                [L,R,U,D]=mov_profundidade(E_atual); %Procura vizinhos                        
                [obj_atingido, mov_final] = checkobj_profundidade(L,R,U,D,Ef); %confere se algum nó vizinho é o objetivo  
               
                %[L,R,U,D]=teste_ciclo(L,R,U,D,aberto); %testa se algum movimento é repetido
                
                if(obj_atingido)
                    aberto(pos+1).estado = mov_final;
                    aberto(pos+1).custo = D_atual+1;
                    aberto(pos+1).pai = E_atual;
                    aberto(1) = [];
                    passos = caminho_profundidade(aberto,E0,Ef);
                    toc
                end
                
                %Coloca novos n�s na frente da fila pra serem explorados
                fechados = vizinhos_DFS(L,R,U,D,fechados,D_atual,E_atual, limite); 
                
                if(isempty(fechados))
                    aberto(1) = [];
                    passos{1} = E0;
                    fprintf("todos os n�s abertos \n")
                    obj_atingido=1;
                    toc
                end 
                
            end
            
        else
            custo=1000000;
        end
    end
end





