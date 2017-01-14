function proctime = calcproctime(p,dimension,mix,baltosequence,startendtime,assigned,ciclo)
  total=sum(mix(:,2));
  npdts=find(baltosequence(:,3)!=0);
  proctime=zeros(max(npdts),size(mix,1));
  model=1:size(mix,1);
  for i=1:length(npdts)
    tasks=1:size(find(baltosequence(npdts(i),4:end)!=0),2);
    for j=1:length(tasks)
      for k=1:length(model)
        tasktocheck=baltosequence(npdts(i),tasks(j)+3);
        if(tasks(j)!=0)
          if(assigned(tasks(j),model(k))==1)
            proctime(npdts(i),model(k))+=((total/(assigned(tasktocheck,:)*mix(:,2)))*startendtime(tasktocheck,2)/ciclo);
          end
        end
      end
    end
  end
end