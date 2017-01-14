for i = 1 : nfish
    
    checking = 0;
    
    if ( (fit(i) > oldFit(i)) &&  ((fit(i) - oldFit(i)) > 0.0001) )
        bestDeltaX(i,:) = deltafish(i,:);
        bestStepInd(i) = stepind;
    end
    
    
end