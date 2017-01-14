%main_mmwalbp

nfish = 30;  
maxit = 500; 
l_inf = -100;
l_sup = 100;
stepend = 0.001;
stepvolend = 0.001;
dimension = size(tempostarefas,1);

opporpdt=3;
nmelhores=1;

switch(parametersSet)
case 1
  wscale = 1000;
  stepinit = 2;
  stepvolinit = 0.2;
case 2
  wscale = 10000;
  stepinit = 2;
  stepvolinit = 0.2;
case 3
  wscale = 1000;
  stepinit = 2;
  stepvolinit = 20;
case 4
  wscale = 10000;
  stepinit = 2;
  stepvolinit = 20;
case 5
  wscale = 1000;
  stepinit = 20;
  stepvolinit = 0.2;
case 6
  wscale = 10000;
  stepinit = 20;
  stepvolinit = 0.2;
case 7
  wscale = 1000;
  stepinit = 20;
  stepvolinit = 20;
case 8
  wscale = 10000;
  stepinit = 20;
  stepvolinit = 20;  
end

opporpdtmax=min(length(unique(tempostarefas(:,3))));

if opporpdt>opporpdtmax
  opporpdt=opporpdtmax;
end

% Criação dos vetores

fish = zeros(nfish, dimension);                 % Matriz de peixes
w = zeros(nfish, 1);                            % Peso de cada peixe
baricentro = zeros(1, dimension);               % Baricento do cardume
instintivo = zeros(1, dimension);               % Direção resultante
deltafish = zeros(nfish, dimension);            % Variação de posição de cada peixe
deltaf = zeros(nfish, 1);                       % Variação de fitness de cada peixe 
fishb = zeros(1, dimension);                    % Posição do peixe com melhor fitness
fishcind = zeros(nfish, dimension);             % Posição resultante do movimento individual   
M = matrizpreced(precedencia,dimension);
melhores=zeros(1,4);
melhores(1,1)=-1000000000000000000000000000;
melhores(1,2)=-1000000000000000000000000000;

% Inicialização 

baricentro = zeros(1,dimension);
fish = rand(nfish,dimension)*(l_sup-l_inf)+l_inf;
w = (wscale/2)*ones(nfish,1);
deltaf = -100000000000000000000000000000000000000000000000*ones(nfish,1);
wtotal = nfish*(wscale/2);
stepind = stepinit;
stepvol = stepvolinit;
%Schooling
    
for counter = 1:maxit
    movimento_individual;
    checkBoundaries;
    deltafmax = max(abs(deltaf));  
    alimentacao;
    movimento_col_instintivo;
    checkBoundaries;
    calcbaricentro;
    movimento_col_volitivo;
    checkBoundaries;
    atualizarmelhores;
    atualizar_stepind;
end

