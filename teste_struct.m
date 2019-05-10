function [aberto,passos] = largura(E0, Ef)
    tic
    fechados = {E0, 0, []};
    aberto = struct;
    obj_atingido = 0;
    D_anterior = 0;
    tic
    t_anterior = datestr(now,'HH:MM:SS');
    if(size(E0) ~= [3 3] | sum(sum(E0)) ~= 36)
    custo = 0;
    else
        invert = inversoes(E0);
        if rem(invert, 2) == 0
            while(obj_atingido ~= 1)
                
                E_atual = fechados{1}; %Pega o proximo valor da fila
                D_atual = fechados{2}; %Pega a distância dele da origem
                P_atual = fechados{3}; %Pega o nó que originou ele
               
                %Para testar profundidade de busca:
%                 if(D_anterior ~= D_atual)
%                     t_atual = datestr(now,'HH:MM:SS');
%                     disp(D_atual)
%                     fprintf('Tempo anterior: %s\n', t_anterior)
%                     fprintf('Tempo atual: %s\n', t_atual)
%                     t_anterior = t_atual;
%                 end
%                 D_anterior = D_atual;

                % Desloca vetor dos fechados
                fechados(1:3)=[];             
                %Passa o estado atual para a lista dos abertos:
                pos = length(aberto)+1;
                aberto(pos).estado=E_atual;
                aberto(pos).custo=D_atual;
                aberto(pos).pai=P_atual;
                
                [L,R,U,D]=mov(E_atual); %Procura vizinhos                        
                [L,R,U,D]=teste_ciclo(L,R,U,D,aberto); %testa se algum movimento é repetido
                [obj_atingido, mov_final] = checkobj(L,R,U,D,Ef); %confere se algum nó vizinho é o objetivo             
                fechados = vizinhos_append(L,R,U,D,fechados,D_atual,E_atual); %Coloca eles na fila pra serem explorados
                if(obj_atingido)
                    aberto(pos+1).estado = mov_final;
                    aberto(pos+1).custo = D_atual+1;
                    aberto(pos+1).pai = E_atual;
                    aberto(1) = [];
                    passos = caminho(aberto,E0,Ef);
                toc
                end
                if(isempty(fechados))
                    obj_atingido=1;
                end 
                
            end
            
        else
            custo=1000000;
        end
    end
end





