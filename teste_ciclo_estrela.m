function vizinhos_filtrados = teste_ciclo_estrela(vizinhos,abertov)

vizinhos_filtrados = {0};
limite_vizinhos = length(vizinhos);
limite_vizinhos = limite_vizinhos-1;
contador = 0;
for i = 1:limite_vizinhos                                                    %COMPARA TODOS OS VALORES DE VIZINHOS COM TODOS OS VALORES DO VETOR ABERTO,
    for j = 1:length(abertov)                                               %CASO HAJA ALGUMA COMBINA��O, SOMA NO CONTADOR;
        comp = isequal(abertov{j},vizinhos{i});
        if(comp)
           contador = contador + 1; 
        end
    end
    if(contador==0)
        vizinhos_filtrados{end}=vizinhos{i};
        vizinhos_filtrados{end+1}={};
    end
    contador=0;
end
end

