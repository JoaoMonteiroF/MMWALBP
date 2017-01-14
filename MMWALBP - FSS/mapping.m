function S = mapping(p,dimension)
    maior = -10000000;
    teste = p;
    S = zeros(1,dimension);
    for k = 1:dimension
        for j = 1:dimension
            if teste(1, j) > maior
                maior = teste(1, j);
                pmaximo = j;
            end;
        end;
        teste(1, pmaximo) = -100000000;
        maior = -100000000;
        S(1, pmaximo) = dimension - k + 1;
    end;
end