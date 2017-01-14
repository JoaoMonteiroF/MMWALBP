testw = wtotal;

if deltafmax==0
  deltafmax=0.000001;
end

w = w + (deltaf/deltafmax);

w(w>wscale)=wscale;
w(w<1)=1;

wtotal = (sum(sum(w))); 