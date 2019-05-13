function [aberto,passos,t] = profundidade(E0, Ef,limite)
    tic
    clc
    fechados(1).estado = E0;
    fechados(1).custo = 0;
    fechados(1).pai = [];
    custo_atual = 0;
    
    aberto.estado = [];
    aberto_vetor = {0};
    
    obj_atingido = 0;
    tic
    if(size(E0) ~= [3 3] | sum(sum(E0)) ~= 36)
    aberto = {};
    passos = {};
    disp('matriz inválida');
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
        if rem(inversoes, 2) == 0
            while(obj_atingido ~= 1)
                
                %Pega o nó a ser explorado
                custo_anterior = custo_atual;
                
                estado_atual = fechados(1).estado;
                custo_atual = fechados(1).custo;
                pai_atual = fechados(1).pai;
                
                if(custo_anterior ~= custo_atual)
                    clc         
                    disp('camada atual: ');
                    disp(custo_atual);
                    disp('nós explorados: ');
                    exp = length(aberto);                   
                    disp(exp);
                end

                
                % Desloca vetor dos fechados
                fechados(1)=[]; 
                
                
                %Passa o estado atual para a lista dos abertos:
                pos = length(aberto)+1;
                aberto(pos).estado=estado_atual;
                aberto(pos).custo=custo_atual;
                aberto(pos).pai=pai_atual;
                
                aberto_vetor{end}=estado_atual;
                aberto_vetor{end+1}={0};
                
                vizinhos=mov(estado_atual); %Procura vizinhos        
                vizinhos(end)=[];
                
                
                [obj_atingido, mov_final] = checkobj(vizinhos,Ef); %confere se algum nÃ³ vizinho Ã© o objetivo 
                if(mov_final~=0)
                    mov_final = vizinhos{mov_final};
                end
                pai = estado_atual;
                custo = custo_atual + 1;
                
                for i = 1:length(vizinhos)
                   estado = vizinhos{i};
                   lista(i).estado = estado;
                   lista(i).pai = pai;
                   lista(i).custo = custo;
                end
                
                if(custo <= limite)
                    fechados = [lista fechados];
                end
                
                if(obj_atingido)
                    aberto(pos+1).estado = mov_final;
                    aberto(pos+1).custo = custo_atual+1;
                    aberto(pos+1).pai = estado_atual;
                    aberto(1) = [];
                    passos = caminho(aberto,E0,Ef);
                    t=toc;
                end
               
                
                
                if(isempty(fechados))
                    passos = {};                  
                    obj_atingido=1;
                    disp('todos os nós explorados');
                    t=toc;
                end 
%                 pause
            end
            
        else
            custo=1000000;
        end
    end
end





