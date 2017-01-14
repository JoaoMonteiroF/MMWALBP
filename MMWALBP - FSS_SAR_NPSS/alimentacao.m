for i = 1 : nfish
    w(i) = 1 + (wscale-1)*(fit(i)-Fmin)/(Fmax-Fmin);
    oldW(i) = 1 + (wscale-1)*(oldFit(i)-Fmin)/(Fmax-Fmin);
end

deltaW = w - oldW;

wtotal = (sum(sum(w)));
oldWtotal= (sum(sum(oldW)));