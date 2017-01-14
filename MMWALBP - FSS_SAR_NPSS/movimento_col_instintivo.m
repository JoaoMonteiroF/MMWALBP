% deltafSar = deltaf;
% deltafSar(deltafSar<0)=0;
% 
% if (deltaf ~= 0)
%   %I = sum(deltafish.*deltafSar)/sum(sum(deltafSar));
%   I = sum(bsxfun(@times, deltafish, deltafSar))/sum(sum(deltafSar));
% else
%   I = zeros(1,dimension);
% end
% 
% bsxfun(@plus, fish, I); 


I = zeros(nfish,dimension);

deltawInstintivo = deltaW;
deltawInstintivo(deltawInstintivo < 0) = 0;

fakeDeltaW = deltawInstintivo;
fakeDeltaX = deltafish;

for i = 1 : nfish
    if deltawInstintivo(i) == 0
       fakeDeltaW(i) = max(deltaW)*(w(i)-1)/(wscale-1);
       fakeDeltaX(i) = stepvol * (bestDeltaX(i)/ bestStepInd(i));
    end    
end


if sum(fakeDeltaW) ~=  0
    for i = 1 : nfish
        I(i,:) = I(i,:) + fakeDeltaX(i,:)* fakeDeltaW(i);
    end
    
     I = I/sum(fakeDeltaW);
end
   
fish = fish + I;
