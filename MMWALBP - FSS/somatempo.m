function somatempo = somatempo(balanceamento, estacao, dimension, tempostarefas)
    somatempo = 0;
    for k = 1:dimension
        tarefa = balanceamento(estacao, k);
        if tarefa > 0 
            somatempo = somatempo + tempostarefas(tarefa);
        end;    
    end;
endf