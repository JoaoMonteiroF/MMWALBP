if wtotal > oldWtotal      
    for i = 1:nfish
        fish(i,:) = fish(i,:) - (stepvol*rand(1,dimension).*((fish(i,:) - baricentro)/distancia(fish(i,:),baricentro))); 
    end;    
else
    for i = 1:nfish
        fish(i,:) = fish(i,:) + (stepvol*rand(1,dimension).*((fish(i,:) - baricentro)/distancia(fish(i,:),baricentro)));
    end;
end; 

