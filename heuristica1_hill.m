function heuristica = heuristica1_hill(estado, Ef)
% estado
% Ef
aux = estado~=Ef;
heuristica = sum(sum(aux));
end

