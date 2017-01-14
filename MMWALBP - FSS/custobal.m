function [desempenho1, desempenho2, desempenho3, desempenho4, balanceamento, startendtime] = custobal(fishb, dimension, M, ciclo,tempostarefas,opporpdt,temposoriginais) % Apenas um peixe � o argumento da fun��o (fish(i,:))
    S = mapping(fishb(1,:),dimension); % random key
    corrigida = corrige(S, M); % correção
    [desempenho1, desempenho2, desempenho3, desempenho4, balanceamento, startendtime] =  conversaoseqbal(corrigida, dimension, ciclo, tempostarefas,opporpdt,M,temposoriginais); % realiza balanceamento  
end