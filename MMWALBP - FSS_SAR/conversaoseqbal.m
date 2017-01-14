function [desempenho1, desempenho2, desempenho3, desempenho4, balanceamento, startendtime] =  conversaoseqbal(corrigida, dimension, ciclo, tempostarefas,opporpdt,precedencia,temposoriginais)

%Inicialização

% persistent% 
distancias = [0 0.06 0.03 0.03 0 0.015 0.015 0.045 0.045 ; 0.06 0 0.03 0.03 0 0.045 0.045 0.015 0.015 ; 0.03 0.03 0 0.06 0 0.015 0.045 0.015 0.045 ; 0.03 0.03 0.06 0 0 0.045 0.015 0.045 0.015 ; 0 0 0 0 0 0 0 0 0 ; 0.015 0.045 0.015 0.045 0 0 0.03 0.03 0.06 ; 0.015 0.045 0.045 0.015 0 0.03 0 0.06 0.03 ; 0.045 0.015 0.015 0.045 0 0.03 0.06 0 0.03 ; 0.045 0.015 0.045 0.015 0 0.06 0.03 0.03 0];

initindex=1;
endindex=1;
currtaskindex=0;
totaltime=0;
totaltimeporpdt=zeros(1,9);
currtask=0;
currstation=1;
currworkplaces=zeros(1,opporpdt);
balanceamento=zeros(dimension,3);
startendtime=zeros(dimension,4);
pdt=0;
endtimepdt=0;
tempoatual=0;
a=zeros(1,opporpdt);
minimo=0;
linhapdt=0;
linhapdtpreced=0;
currtaskstarttime=0;
k=zeros(1,dimension);
nop=0;

%opporpdt = pdts por estação
%
while(endindex<dimension)  %Não está funcionando para endindex<=dimension. Causa ainda n identificada

  %Determina os índices inicial e final da sequência a ser alocada. Calcula o workload básico em cada pdt
  totaltime=0;
  totaltimeporpdt=zeros(1,9);
  currworkplaces=zeros(1,opporpdt);
  endindex=initindex;
  while (totaltime<=(opporpdt*ciclo) && endindex<=dimension)
    totaltimeporpdt(tempostarefas(corrigida(1,endindex),3)+1) = totaltimeporpdt(tempostarefas(corrigida(1,endindex),3)+1) + tempostarefas(corrigida(1,endindex),2);
    totaltime=sum(totaltimeporpdt);
    endindex = endindex + 1;
  end
  if(endindex<dimension) %correção do endindex quando estoura dimension
    endindex=endindex-2;
  elseif(endindex>dimension)
    endindex=dimension;
  end
  %
  %Define os opporpdt a serem abertos na estação atual
  a=zeros(size(totaltimeporpdt));
  a=sort(totaltimeporpdt,'descend');
  %a=a(find(a!=0));
  
  currworkplaces=zeros(1,1);
  for i=1:min(opporpdt,length(a)) %Determina os pdts com maior workload básico
  
    pdt=find(totaltimeporpdt==a(1,i));
    currworkplaces=[currworkplaces pdt];
    
  end
  
  currworkplaces=unique(currworkplaces(1,2:(2+length(currworkplaces)-2))); %Remove pdts duplicados e deixe apenas os opporpdt com mais workload básico
  
  for i=1:length(currworkplaces) %Abre os pdts com maior workload básico
  
    balanceamento(((currstation-1)*opporpdt)+i,1)=currstation;
    balanceamento(((currstation-1)*opporpdt)+i,2)=currworkplaces(i)-1;
  
  end
  
  %
  %alocação da sequ~encia de initindex até endindex
  currtaskindex=initindex;
  currtask=corrigida(currtaskindex);
  lasttask=currtask;
  while(currtaskindex<=endindex)
    
    %sort de currworkplaces baseado na distancia do melhor pdt para uma tarefa específica
    tempos=zeros(1,length(currworkplaces));
    lasttask=currtask; %lasttask é mantido para uso futuro na correção de tempo
    currtask=corrigida(currtaskindex);
    for i=1:length(currworkplaces)
      tempos(i)=distancias(tempostarefas(currtask,3)+1,currworkplaces(i));
    end
    
    for i=1:length(currworkplaces)
      minimo=find(tempos==min(tempos(i:length(currworkplaces))));
      minimo=minimo(1,1);
      tempos=swap(tempos,i,minimo);
      currworkplaces=swap(currworkplaces,i,minimo);    
    end
    
    %tentativas de alocação de currtask em currworkplaces
    for i=1:length(currworkplaces)
      linhapdt=(currstation-1)*opporpdt + find(balanceamento(((currstation-1)*opporpdt+1):((currstation-1)*opporpdt+length(currworkplaces)),2)==(currworkplaces(i)-1));
      colunaop=max(3,max(find(balanceamento(linhapdt,:)~=0))); %localizar última tarefa alocada
      if balanceamento(linhapdt,3)==0 %Se pdt estiver vazio
        endtimepdt=0;
        tempoatual=gerartempos(tempostarefas(currtask,2),tempostarefas(lasttask,3)+1,currworkplaces(i),tempostarefas(currtask,2)/temposoriginais(currtask,1)); %corrgige tempo do melhor pdt para o pdt de alocação
      else
        endtimepdt=startendtime(balanceamento(linhapdt,colunaop),4);
        tempoatual=gerartempos(tempostarefas(currtask,2),tempostarefas(currtask,3)+1,tempostarefas(balanceamento(linhapdt,colunaop),3)+1,tempostarefas(currtask,2)/temposoriginais(currtask,1)); %corrige tempo do último pdt visitado para o pdt de execução
      end
      
      currtaskstarttime=endtimepdt;
  
      if((endtimepdt+tempoatual)<ciclo) %checa se a operação cabe no pdt
       %checar precedencia
        for j=1:length(currworkplaces) %checa se alguma precedente tem sobreosição de tempo num pdt na mesma estação
          linhapdtpreced=(currstation-1)*opporpdt + find(balanceamento(((currstation-1)*opporpdt+1):((currstation-1)*opporpdt+length(currworkplaces)),2)==(currworkplaces(j)-1));
          if(i==j||balanceamento(linhapdtpreced,3)==0) %segue adiante caso o pdt vizinho esteja vazio ou se é o próprio pdt onde está se alocando currtask
            continue;
          end
          colunaoppreced=max(3,max(find(balanceamento(linhapdtpreced,:)~=0)));
          k=balanceamento(linhapdtpreced,4:colunaoppreced);
          k=fliplr(k(find(k~=0))); %checa as operações dos pdts vizinhos de trás pra frente
          for l=1:length(k)
            if(precedencia(k(l),currtask)==1)
              if(startendtime(k(l),4)>currtaskstarttime)
                currtaskstarttime=startendtime(k(l),4); %avança o starttime de currtask para o final da precedente vizinha
                break;
              end            
            end
          end    
        end
        
        if((currtaskstarttime+tempoatual)<ciclo) %alocação
          currtaskindex = currtaskindex + 1;
          balanceamento(linhapdt,colunaop+1)=currtask;
          balanceamento(linhapdt,3)= balanceamento(linhapdt,3) + tempoatual;
          startendtime(currtask,2)=tempoatual;
          startendtime(currtask,3)=currtaskstarttime;
          startendtime(currtask,4)=currtaskstarttime+tempoatual;
          break;
        else
        
          if(currworkplaces(i)==currworkplaces(end)) %checa se é o último pdt aberto para atualização de currtaskindex
            endindex=currtaskindex-1;
            break;
          else
            continue;
          end
  
        end
      
      else
        
        if(currworkplaces(i)==currworkplaces(end))
          endindex=currtaskindex-1;
          break;
        else
          continue;
        end
      end
    
    end
    
  end
  currstation = currstation + 1;
  initindex=min(currtaskindex,dimension);
  
  
end
nop=sum(balanceamento(:,3)~=0);
finalWorkload = sum(balanceamento(:,3));
smoothness=sqrt(sum((ciclo-balanceamento(:,3)).^2));

desempenho1=-1*nop*smoothness;
desempenho2=finalWorkload;
desempenho3=nop;
desempenho4=smoothness;

end