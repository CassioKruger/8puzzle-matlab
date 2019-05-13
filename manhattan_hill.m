function h = manhattan_hill(estado,Ef)
h=0;

for i = 0:8
    [l_atual,c_atual]=find(estado==i);
    [l_meta,c_meta]=find(Ef==i);
    h=h+abs(l_atual-l_meta) + abs(c_atual-c_meta);
    
end
    

end
