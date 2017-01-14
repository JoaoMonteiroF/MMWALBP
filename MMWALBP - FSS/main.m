%Main
clear

numberOfExperiments = 450; %450

%1 = 4M_Small
%2 = 50M_Small
%3 = 4M_Medium
%4 = 50M_Medium
%5 = 4M_Large
%6 = 50M_Large
%7 = 4M_VeryLarge
%8 = 50M_VeryLarge

dataSet = 1; %Rodar de 1 até 6
parametersSet = 7; %Não Modificar

results = zeros(numberOfExperiments,4);

disp('Start!'); 

tic();

switch(dataSet)
  case 1
    fileName='_4M_Small.txt';    
    fileName=strcat(num2str(parametersSet),fileName);
    Mix4 = xlsread('Mix4teste.xls');
    mix=Mix4;
    Precedencia1 = xlsread('Precedencia1teste.xls');
    precedencia = Precedencia1;
    TemposDasTarefas1_4 = xlsread('TemposDasTarefas1_4teste.xls');
    tempostarefas = TemposDasTarefas1_4;
  case 2
    fileName='_50M_Small.txt';   
    fileName=strcat(num2str(parametersSet),fileName);
    Mix50 = xlsread('Mix50teste.xls');
    mix=Mix50;
    Precedencia1 = xlsread('Precedencia1teste.xls');
    precedencia = Precedencia1;
    TemposDasTarefas1_50 = xlsread('TemposDasTarefas1_50teste.xls');
    tempostarefas = TemposDasTarefas1_50;
  case 3
    fileName='_4M_Medium.txt'; 
    fileName=strcat(num2str(parametersSet),fileName);
    Mix4 = xlsread('Mix4teste.xls');
    mix=Mix4;
    Precedencia2 = xlsread('Precedencia2teste.xls');
    precedencia = Precedencia2;
    TemposDasTarefas2_4 = xlsread('TemposDasTarefas2_4teste.xls');
    tempostarefas = TemposDasTarefas2_4;
  case 4
    fileName='_50M_Medium.txt'; 
    fileName=strcat(num2str(parametersSet),fileName);
    Mix50 = xlsread('Mix50teste.xls');
    mix=Mix50;
    Precedencia2 = xlsread('Precedencia2teste.xls');
    precedencia = Precedencia2;
    TemposDasTarefas2_50 = xlsread('TemposDasTarefas2_50teste.xls');
    tempostarefas = TemposDasTarefas2_50;
  case 5
    fileName='_4M_Large.txt'; 
    fileName=strcat(num2str(parametersSet),fileName);
    Mix4 = xlsread('Mix4teste.xls');
    mix=Mix4;
    Precedencia3 = xlsread('Precedencia3teste.xls');
    precedencia = Precedencia3;
    TemposDasTarefas3_4 = xlsread('TemposDasTarefas3_4teste.xls');
    tempostarefas = TemposDasTarefas3_4;
  case 6
    fileName='_50M_Large.txt'; 
    fileName=strcat(num2str(parametersSet),fileName);
    Mix50 = xlsread('Mix50teste.xls');
    mix=Mix50;
    Precedencia3 = xlsread('Precedencia3teste.xls');
    precedencia = Precedencia3;
    TemposDasTarefas3_50 = xlsread('TemposDasTarefas3_50teste.xls');
    tempostarefas = TemposDasTarefas3_50;
  case 7
    fileName='_4M_VeryLarge.txt'; 
    fileName=strcat(num2str(parametersSet),fileName);
    Mix4 = xlsread('Mix4teste.xls');
    mix=Mix4;
    Precedencia4 = xlsread('Precedencia4teste.xls');
    precedencia = Precedencia4;
    TemposDasTarefas4_4 = xlsread('TemposDasTarefas4_4teste.xls');
    tempostarefas = TemposDasTarefas4_4;
  case 8
    fileName='_50M_VeryLarge.txt'; 
    fileName=strcat(num2str(parametersSet),fileName);
    Mix50 = xlsread('Mix50teste.xls');
    mix=Mix50;
    Precedencia4 = xlsread('Precedencia4teste.xls');
    precedencia = Precedencia4;
    TemposDasTarefas4_50 = xlsread('TemposDasTarefas4_50teste.xls');
    tempostarefas = TemposDasTarefas4_50;
end   

temposoriginais=tempostarefas(:,2);
tempostarefas(:,2)=conversaosalbp(tempostarefas,mix);
ciclo = 1000;

disp('loading Time:');
toc()

disp('Data loaded');

disp('Start of balancing...');

tic();

for ac=1:numberOfExperiments

  main_mmwalbp
  results(ac,:)=melhores;
end

disp('Balancing Time:');
toc()

disp('Balancing done');

disp('Output:');
results

fid = fopen(fileName , 'w');

for i=1:size(results,1)
  
  fprintf(fid , '%f ' , results(i,:));
  fprintf(fid, '\r\n');
  
end
fclose(fid);

