Fmax_candidato = max(fit);
Fmin_candidato = min(fit);

if Fmax_candidato > Fmax
    Fmax = Fmax_candidato;
end

if Fmin_candidato < Fmin
    Fmin = Fmin_candidato;
end
