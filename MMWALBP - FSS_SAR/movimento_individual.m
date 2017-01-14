alpha=0.8*exp(-0.007*counter);
%alpha=10;

for i = 1:nfish

    random = rand(size(fish(i,:)));
    fishcind(i,:) = fish(i,:)+(random*2-1)*stepind;    
    
    [c1, c2, c3, c4, bal, startendtimes] = custobal(fishcind(i,:), dimension, M, ciclo, tempostarefas,opporpdt,temposoriginais);
    
    if c1 > deltaf(i,1)                                % Se houve melhora no fitness 
        
        deltafish(i,:) = fishcind(i,:)-fish(i,:);     % Usado no mov. coletivo instintivo 
        fish(i,:) = fishcind(i,:);                    % O peixe se move
        deltaf(i,1) = c1 - deltaf(i,1);                % Usado na alimentação
    
    else                                              % Não houve melhora      
        
        if rand()<alpha
          deltafish(i,:) = fishcind(i,:)-fish(i,:);
          fish(i,:) = fishcind(i,:);
        else
          deltafish(i,:) = zeros(1,dimension);          % O peixe não se move
          deltaf(i,1) = 0;                              % Deltaf = 0
        end;
            
    end;
    
end;