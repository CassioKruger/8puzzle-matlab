function caminho_final = caminho_profundidade(aberto, E0,Ef)
E_atual = Ef;
caminho = {E_atual};
pos_atual = pos_pai_profundidade(E_atual,aberto);
pai_atual = aberto(pos_atual).pai;
caminho{end+1} = pai_atual;
objetivo = isequal(pai_atual,E0);

while(~objetivo)
    pos_atual = pos_pai_profundidade(pai_atual,aberto);
    pai_atual = aberto(pos_atual).pai;
    caminho{end+1} = pai_atual;
    objetivo = isequal(pai_atual,E0);
end

caminho_final=flip(caminho);
end

