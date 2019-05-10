function caminho_final = caminho_estrela(aberto, E0,Ef)
E_atual = Ef;
caminho = {E_atual};
pos_atual = find(arrayfun(@(s) (isequal(E_atual,s.estado)==1), aberto));
pai_atual = aberto(pos_atual).pai;
caminho{end+1} = pai_atual;
objetivo = isequal(pai_atual,E0);

while(~objetivo)
    pos_atual = find(arrayfun(@(s) (isequal(pai_atual,s.estado)==1), aberto));
    pai_atual = aberto(pos_atual).pai;
    caminho{end+1} = pai_atual;
    objetivo = isequal(pai_atual,E0);
end

caminho_final=flip(caminho);
end

