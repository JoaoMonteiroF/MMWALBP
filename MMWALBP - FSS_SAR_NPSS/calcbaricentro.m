%baricentro = sum(fish.*w)/wtotal;
baricentro = sum(bsxfun(@times, fish, w))/wtotal;