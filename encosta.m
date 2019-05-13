function [fechados, reset,maxlocais,maxlocaist,aberto_ciclo,fdc] = encosta(vizinhos, ea, ga, fa, er,maxlocais,maxlocaist,Ef,aberto_ciclo,fdc)
if(~isempty(vizinhos))
   %%CALCULA OS CUSTOS F DE CADA MOVIMENTO POSS√?VEL%%
   nvizinhos = length(vizinhos);
   clear custof;
   custof(1:nvizinhos)=100;
   custog = ga + 1;
   for ind = 1:nvizinhos
       estado = vizinhos{ind};
       custoh1 = heuristica1(ea,Ef);
       custoh2 = manhattan(ea,Ef);
       custoh=custoh1+custoh2;
       
       custof(ind) = custoh+custog;
   end
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   %%ESCOLHE O MELHOR CUSTO COMO PR√ìXIMO MOVIMENTO
   [proximo_f,indice]=min(custof);
   proximo_estado = vizinhos{indice};
   proximo_pai = ea;
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   
   if(proximo_f>fa)
%        disp('(pf > fa)');
       if(~isequal(ea,er))
%            disp('adicionando a lista de estados maximos locais');
           maxlocais{end}=ea;
           maxlocais{end+1}=[];
       else
           disp('erro');
       end
       clear aberto_ciclo;
       aberto_ciclo={0};
       fechados.estado = er;
       fechados.pai = [];
       fechados.g = 0;
       fechados.f = 200;
   else
       fechados.estado = proximo_estado;
       fechados.pai = ea;
       fechados.g = ga+1;
       fechados.f = proximo_f;       
   end
   
   
%CASO N√ÉO EXISTAM MOVIMENTOS POSS√?VEIS   
else
%     disp('N√ì SEM SA√?DA');
    proximo_estado = zeros(3,3);
    proximo_f = inf;
    if(~isequal(ea,er))
%         disp('adicionando a lista de estados finais de curso');
        fdc{end}=ea;
        fdc{end+1}=[];
    else
%         disp('trocando o valor inicial');
        limite = length(maxlocais)-1;
        k = randi(limite);
        
        %%TESTA SE O ESTADO INICIAL ALEAT√ìRIO ESCOLHIDO J√? FOI ESCOLHIDO
        %%ANTERIORMENTE!
        aux2 = 0;
        while(~aux2)
            aux = 0;
            lmax = length(maxlocaist)-1;
            for x = 1:lmax
                aux = aux + isequal(maxlocais{k},maxlocaist{x});
            end
            if(aux == 0)
                maxlocaist{end}=maxlocais{k};
                maxlocaist{end+1}={0};                
                aux2=1;
            else
                k = randi(limite);
            end
        end
        er = maxlocais{k};
        maxlocais(k)=[];
   
    end
    clear aberto_ciclo;
    aberto_ciclo={0};
    fechados.estado = er;
    fechados.pai = [];
    fechados.g = 0;
    fechados.f = 200;
   
end
reset = er;

% 
% disp('estado atual:');
% disp(ea);
% disp(fa);
% disp('proximo estado:');
% disp(proximo_estado);
% disp(proximo_f);
% disp('max locais j√° explorados:')
% aux3=length(maxlocaist);
% disp(aux3);
% disp('total de maximos locais encontrados:')
% aux4=length(maxlocais);
% disp(aux4);


end

