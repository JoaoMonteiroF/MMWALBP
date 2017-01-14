function M1 = matrizpreced(preced,nt)
    %nt = dimension;
    [a,~] = size(preced); % a: number of lines; b: number of columns
    M1 = zeros(nt+1,nt);

    for i = 1:nt
        for j = 1:nt
            for k = 1:a
                if preced(k,1) == i && preced(k,2) == j
                    M1(i,j) = 1;
                end;
            end;
        end;    
    end;


    for i = 1:nt
        for j = 1:nt
            if M1(i,j) == 1
                for k =1:nt
                    M1(k,j) = M1(k,j) + M1(k,i); % M(k,j) só muda de valor se k é pred direto de i e não é de j
                    if M1(k,j) == 2
                        M1(k,j) = 1;
                    end;
                end;
            end;
        end;
    end;

    for j = 1:nt
        cont = 0;
        for i = 1:nt
            if M1(i,j) == 1
                cont = cont+1;
            end;
        end;
        M1(nt+1,j) = cont;
    end;
    
end