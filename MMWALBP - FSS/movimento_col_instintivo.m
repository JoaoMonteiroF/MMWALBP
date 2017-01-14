deltafSar = deltaf;
deltafSar(deltafSar<0)=0;

if (deltaf ~= 0)
  %I = sum(deltafish.*deltafSar)/sum(sum(deltafSar));
  I = sum(bsxfun(@times, deltafish, deltafSar))/sum(sum(deltafSar));
else
  I = zeros(1,dimension);
end

%fish = fish + I; 
bsxfun(@plus, fish, I); 