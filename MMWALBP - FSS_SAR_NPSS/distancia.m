function distancia = distancia(p,q)
    somaquadrados = sum((p - q).^2);
    distancia = sqrt(somaquadrados);
end