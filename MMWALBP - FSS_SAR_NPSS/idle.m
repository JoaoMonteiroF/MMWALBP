function idletime = idle(balanceamento,dimension,desempenho,tempostarefas,ciclo)
    total = 0;
    for i = 1:desempenho
        total = total + somatempo(balanceamento, i, dimension, tempostarefas);
    end;
    fractempo = total/(ciclo*desempenho);
    idletime = (1-fractempo)*100;
end