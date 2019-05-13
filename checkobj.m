function [flag, pos] = checkobj(vizinhos, Ef)
comprimento = length(vizinhos);
flag = 0;
pos = 0;
for j = 1:comprimento
    if isequal(vizinhos{j},Ef)
        pos = j;
        flag = 1;
    end
end
   
end