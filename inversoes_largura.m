function inversoes = inversoes_largura(E0)
E0V = reshape(E0.',1,9);
inversoes = 0;
for valor_testado = 1:8
    for pos_comparada = valor_testado+1:9
        if(E0V(valor_testado)>E0V(pos_comparada) && E0V(pos_comparada) > 0)
            inversoes = inversoes + 1;
        end
    end 
end
end

