function [passos,iteracoes,inversoes,flag_solucao,estado_atual] = BFS(estado_inicial,estado_meta)

    %inicializando variaveis
    passos = 0;
    iteracoes = 0;
    inversoes = 0;
    flag_solucao = 0;
    estado_atual = zeros(1,9);
    start = zeros(1,9);
    goal = zeros(1,9);

    %% ---------------------------%%

    start = [estado_inicial(1:3);estado_inicial(4:6);estado_inicial(7:9)];  %converte a array do estado_inicial para uma matriz
    goal = [estado_meta(1:3);estado_meta(4:6);estado_meta(7:9)];
    
    estado_atual = sprintf('%d', estado_inicial);   %para printar    
    
    start
    goal
    
    %verificacao se para o estado inicial, existe solucao
    %se o numero de inversoes for PAR, existe solucao
    %se for IMPAR, nao existe

    for col = 1:8
        for aux = (col+1):9
            if(estado_inicial(col) > estado_inicial(aux)) && (estado_inicial(aux)>0)
                inversoes = inversoes + 1;
            end
        end
    end

    if (mod(inversoes,2) == 0)        %testa se o RESTO DE 2 de inversoes eh igual a zero
        flag_solucao = 1;
    else
        flag_solucao = 0;
    end

    %% -------------------------%%
    %%  comeco do algoritmo BFS %%
    %% -------------------------%%

    % fazer uma queue/consulta
    if (flag_solucao == 1)

        A{1,1} = start;
        A{2,1} = 0;
        CloseList{1,1}= A{1,1}; %Lista fechada
        CloseList{2,1}= 1;
        CloseList{3,1}= 0;
        OpenList={[]};
        OpenList{2,1}=1;
        least_open=1;
        k=1;
        i=1;
        k=2;
        father=1;
        var=0;
        N=0;

        while var==0
            [lixo,least_close]=size(CloseList);
            %infos sobre a possibilidade de movimento do espaco em vazio;
            [row,colunm]=find(A{1,1}==0);%informa a localizacao do zero

            left=colunm-1;
            right=colunm+1;
            up=row-1;
            down=row+1;

            %Movimento para esquerda
            if(left>=1)
                NumberLeft=A{1,1}(row,left);%Salva o valor a esquerda do espa�o em vazio
                B=A{1,1};%Salva a matriz a em uma vari�vel tempor�ria
                B(row,left)=0;%Desloca o espa�o vazio para esquerda
                B(row,colunm)=NumberLeft;%Desloca o valor da esquerda para a direita
                %%pause(1);
                for j=1:least_close
                    if (((sum(sum(B~=CloseList{1,j})))==0))
                        N=1;
                    end
                end

                if (N==0)
                    OpenList{1,least_open}=B;
                    OpenList{1,least_open+1}=[];

                    OpenList{2,least_open}=k;
                    OpenList{3,least_open}=father;                             
                    OpenList{4,least_open}=(A{2,1}+1);
                    [lixo,least_open]=size(OpenList);
                    k=k+1;
                end
                if (sum(sum(goal~=B)))==0           %se a soma de goal ~=B for zero, achou a solucao
                    var=1;
                    solution{1,1}= OpenList{1,least_open-1};
                    solution{2,1}= OpenList{2,least_open-1};
                    solution{3,1}= OpenList{3,least_open-1};
                    solution{4,1}= OpenList{4,least_open-1};
                end        
            end   
            N=0;

            if((right<=3))
                [lixo,least_open]=size(OpenList);
                [lixo,least_open]=size(OpenList);
                NumberRight=A{1,1}(row,right);%Salva o valor a direita do espa�o em vazio
                B=A{1,1};%Salva a matriz a em uma vari�vel tempor�ria
                B(row,right)=0;%Desloca o espa�o vazio para esquerda
                B(row,colunm)=NumberRight;%Desloca o valor da esquerda para a direita
                %pause(1);
                for j=1:least_close
                    if (((sum(sum(B~=CloseList{1,j})))==0))
                        N=1;
                    end
                end

                if (N==0)
                    OpenList{1,least_open}=B;
                    OpenList{1,least_open+1}=[];

                    OpenList{2,least_open}=k;
                    OpenList{3,least_open}=father;
                    OpenList{4,least_open}=(A{2,1}+1);
                    [lixo,least_open]=size(OpenList);    
                    k=k+1;
                end

                if (sum(sum(goal~=B)))==0
                    var=1;
                    solution{1,1}= OpenList{1,least_open-1};
                    solution{2,1}= OpenList{2,least_open-1};
                    solution{3,1}= OpenList{3,least_open-1};
                    solution{4,1}= OpenList{4,least_open-1};
                end
            end 


            N=0;
            if(up>=1)
                NumberUp=A{1,1}(up,colunm);%Salva o valor acima do espa�o em vazio;
                B=A{1,1};%Salva a matriz a em uma vari�vel tempor�ria
                B(up,colunm)=0;%Desloca o espa�o vazio para esquerda
                B(row,colunm)=NumberUp;%Desloca o valor da esquerda para a direita
                %pause(1);
                for j=1:least_close
                    if (((sum(sum(B~=CloseList{1,j})))==0))
                        N=1;
                    end
                end

                if (N==0)
                    OpenList{1,least_open}=B;
                    OpenList{1,least_open+1}=[];

                    OpenList{2,least_open}=k;
                    OpenList{3,least_open}=father;
                    OpenList{4,least_open}=(A{2,1}+1);
                    [lixo,least_open]=size(OpenList);
                    k=k+1;
                end

                if (sum(sum(goal~=B)))==0
                    var=1;
                    solution{1,1}= OpenList{1,least_open};
                    solution{2,1}= OpenList{2,least_open-1};
                    solution{3,1}= OpenList{3,least_open-1};
                    solution{4,1}= OpenList{4,least_open-1};
                end
            end

            N=0;
            if((down<=3))
                NumberDown=A{1,1}(down,colunm);%Salva o valor acima do espa�o em vazio;
                B=A{1,1};%Salva a matriz a em uma vari�vel tempor�ria
                B(down,colunm)=0;%Desloca o espa�o vazio para esquerda
                B(row,colunm)=NumberDown;%Desloca o valor da esquerda para a direita
                %pause(1);
                for j=1:least_close
                    if (((sum(sum(B~=CloseList{1,j})))==0))
                        N=1;
                    end
                end

                if (N==0)
                    OpenList{1,least_open}=B;
                    OpenList{1,least_open+1}=[];

                    OpenList{2,least_open}=k;
                    OpenList{3,least_open}=father;

                    OpenList{4,least_open}=(A{2,1}+1);
                    [lixo,least_open]=size(OpenList);
                    k=k+1;
                end

                if (sum(sum(goal~=B)))==0
                    var=1;
                    solution{1,1}= OpenList{1,least_open-1};
                    solution{2,1}= OpenList{2,least_open-1};
                    solution{3,1}= OpenList{3,least_open-1};
                    solution{4,1}= OpenList{4,least_open-1};
                end
            end 
            
            N=0;
            [lixo,least_close]=size(CloseList);
            CloseList{1,least_close+1}= OpenList{1,1};
            CloseList{2,least_close+1}= OpenList{2,1};
            CloseList{3,least_close+1}= OpenList{3,1};
            CloseList{4,least_close+1}= OpenList{4,1};

            OpenList(:,1)=([]);

            [lixo,least_open]=size(OpenList);
            [lixo,least_close]=size(CloseList);

            father=CloseList{2,least_close};

            A{1,1}=CloseList{1,least_close};
            A{2,1}=CloseList{4,least_close};

        end %%%

        CloseList=cat(2,CloseList,OpenList(1:4,1:least_open-1));
        map{1,1}= solution{1,1};
        map{2,1}= solution{2,1};
        map{3,1}= solution{3,1};
        map{4,1}= solution{4,1};
        way=solution{3,1};
        CloseList=cat(2,CloseList,OpenList);
        [lixo,least_close]=size(CloseList);
        %
        for k=least_close:-1:1
            if CloseList{2,k}==way
                i=i+1;
                map{1,i}= CloseList{1,k};
                map{2,i}= CloseList{2,k};
                map{3,i}= CloseList{3,k};
                map{4,i}= CloseList{4,k};

                way=map{3,i};
            end
        end

        iteracoes = i;

        while i~=0
            passos{1,i} = map{1,i};
            i=i-1;
        end

        passos
        iteracoes
    end

end