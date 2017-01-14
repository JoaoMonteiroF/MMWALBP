function swaped =  swap(vetor,posicao1,posicao2)

  a=vetor(posicao2);
  vetor(posicao2)=vetor(posicao1);
  vetor(posicao1)=a;
  swaped=vetor;

end