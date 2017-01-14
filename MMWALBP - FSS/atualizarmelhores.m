for j = 1:nfish
      [deltaf(j,1),workload, c3, c4, t1,t2] = custobal(fish(j,:), dimension, M, ciclo, tempostarefas,opporpdt,temposoriginais);
      
      if deltaf(j,1) > melhores(1,1)
        %if k<nmelhores
        %  melhores(k+1,:)=melhores(k,:);
        %endif
        melhores(1,:)=[deltaf(j,1),workload, c3, c4];
      elseif deltaf(j,1)== melhores(1,1) && workload < melhores(1,2)
        %if k<nmelhores
        %  melhores(k+1,:)=melhores(k,:);
        %endif
        melhores(1,:)=[deltaf(j,1),workload, c3, c4];
      end;
      
 end;    
