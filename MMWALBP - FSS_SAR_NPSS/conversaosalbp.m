function corrigida = conversaosalbp(tempostarefas,mix)
  
  total=sum(mix(:,2));
  
  corrigida=(tempostarefas(:,2).*(tempostarefas(:,4:end)*mix(:,2)))/total;
    
end