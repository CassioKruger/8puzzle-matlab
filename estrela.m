function [aberto,passos] = estrela(E0, Ef)
    clc
    tic
    fechados.estado = 0;
    fechados.f = 1000;
    fechados.pai = 0;
    fechados.g = 0;   
    fechados(2).estado = E0;
    fechados(2).f = 0;
    fechados(2).pai = [];
    fechados(2).g = 0; 
    aberto = struct;
    abertov = {0};
    obj_atingido = 0;
    custos(1)=100;
    custos(2)=0;
    E_atual = E0;
    
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
                
                [F_atual,indice] = min(custos);     %Pega o menor custo e seu �ndice
                
                
                E_anterior = E_atual;
                E_atual = fechados(indice).estado;  %Pega o estado valor da fila
                G_atual = fechados(indice).g;       %Pega a distância dele da origem
                P_atual = fechados(indice).pai;     %Pega o nó que originou ele
                fechados(indice)=[];                % Desloca vetor dos fechados
                                             

%                 disp('Profundidade atual:')
%                 disp(G_atual);      
%                 disp('Custo atual:')
%                 disp(F_atual);
%                 disp('Estado atual:')
%                 disp(E_atual);


                
                %Passa o estado atual para a lista dos abertos:
                
                pos = length(aberto)+1;             %ponteiro
                aberto(pos).estado=E_atual;         %Adiciona estado atual na lista dos explorados                          
                aberto(pos).g=G_atual;              %Adiciona o custo de _estrela atual
                aberto(pos).pai=P_atual;            %Adiciona o pai atual
                aberto(pos).f = F_atual;            %Adiciona o custo F atual
                abertov{end}=E_atual;               %Adiciona este estado �s c�lulas explorado
                abertov{end+1}={};                  %Desloca a c�lula explorada
                
                vizinhos=mov_estrela(E_atual);             %Procura vizinhos                
                vizinhos_filtrados=teste_ciclo_estrela(vizinhos,abertov); %testa se algum movimento é repetido
                
                
                
                
                
                %LA�O PARA COLOCAR OS VIZINHOS NA FILA DOS FECHADOS%
                total = length(vizinhos_filtrados)-1;
                for ind = 1:total
                    %Obtem os dados sobre o vizinho explorado no momento
                    estado = vizinhos_filtrados{ind};
                    pai = E_atual;
                    custog = G_atual + 1;
%                     custoh = heuristica1(estado,Ef);
                    custoh = manhattan(estado,Ef);
                    custof = custog+custoh;
                    
                    
                    %Adiciona os dados do vizinho para a fila
                    [~,pos] = size(fechados);
                    pos=pos+1;
                    fechados(pos).estado = estado;
                    fechados(pos).pai = pai;
                    fechados(pos).g = custog;
                    fechados(pos).f = custof;           
                end
                
                
                custos=[fechados.f];
%                 disp('vetor de custos');
%                 disp(custos);
                obj_atingido=isequal(E_atual,Ef);
                
                if (obj_atingido)
                   clc
                   passos=caminho_estrela(aberto,E0,Ef);
                   disp('Passos requeridos:');
                   disp(length(passos));
                   aberto(1)=[];
                   fechados(1)=[];
                   toc
                end
                
               
                if(isempty(fechados))
                    aberto(1) = [];
                    passos{1} = E0;
                    disp('todos os n�s conferidos');
                    obj_atingido=1;
                    toc
                end 
                
            end
            
        else
            passos = {};
            abertos = {};
            fechados = {};
            disp('Formato inv�lido');
        end
    end
end




