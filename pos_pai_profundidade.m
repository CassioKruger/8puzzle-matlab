function pos_pai = pos_pai_profundidade(pai, aberto)
pos_pai = find(arrayfun(@(s) (isequal(pai,s.estado)==1), aberto));
end

