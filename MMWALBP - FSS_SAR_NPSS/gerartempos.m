function tempo = gerartempos(melhortempo,posicaoorigem,posicaoexecucao,fatormix)

%persistent 
distancias=[0 0.06 0.03 0.03 0 0.015 0.015 0.045 0.045 ; 0.06 0 0.03 0.03 0 0.045 0.045 0.015 0.015 ; 0.03 0.03 0 0.06 0 0.015 0.045 0.015 0.045 ; 0.03 0.03 0.06 0 0 0.045 0.015 0.045 0.015 ; 0 0 0 0 0 0 0 0 0 ; 0.015 0.045 0.015 0.045 0 0 0.03 0.03 0.06 ; 0.015 0.045 0.045 0.015 0 0.03 0 0.06 0.03 ; 0.045 0.015 0.015 0.045 0 0.03 0.06 0 0.03 ; 0.045 0.015 0.045 0.015 0 0.06 0.03 0.03 0];

tempo=melhortempo+distancias(posicaoorigem,posicaoexecucao)*60*15*fatormix;

end