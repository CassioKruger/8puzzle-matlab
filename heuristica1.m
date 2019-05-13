function heuristica = heuristica1(estado, Ef)
% estado
% Ef
aux = estado~=Ef;
heuristica = sum(sum(aux));
end

